import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/model/manager/fixed_detail_model.dart';
import 'package:aku_community/pages/manager_func.dart';
import 'package:aku_community/pages/things_page/widget/fixed_evaluate_page.dart';
import 'package:aku_community/utils/bee_map.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/views/horizontal_image_view.dart';

class FixedDetailPage extends StatefulWidget {
  final int id;
  FixedDetailPage(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _FixedDetailPageState createState() => _FixedDetailPageState();
}

class CancelModel {
  bool cancel;
  String message;
  CancelModel(this.cancel, this.message);
}

class _FixedDetailPageState extends State<FixedDetailPage> {
  bool _onLoading = true;
  EasyRefreshController _easyRefreshController = EasyRefreshController();
  FixedDetailModel _model = FixedDetailModel();
  bool get showRepairCard => _model?.appDispatchListVo != null;
  bool get showProcessCard => _model.appProcessRecordVo.isNotEmpty;

  bool _canComplete(int state) {
    switch (state) {
      case 1:
      case 2:
      case 3:
      case 4:
        return true;
      case 5:
      case 6:
      case 7:
        return false;
      default:
        return false;
    }
  }

  Color _getColor(int state) {
    switch (state) {
      case 1:
      case 2:
      case 3:
        return kDarkPrimaryColor;
      case 4:
      case 5:
      case 6:
      case 7:
        return ktextSubColor;
      default:
        return kDangerColor;
    }
  }

  Widget _buildHead(FixedDetailModel model) {
    return Container(
      decoration: BoxDecoration(
          color: kForeGroundColor, borderRadius: BorderRadius.circular(8.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(28.w, 20.w, 20.w, 24.w),
            child: Row(
              children: [
                '报修信息'.text.black.size(32.sp).bold.make(),
                8.w.widthBox,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kPrimaryColor,
                      width: 2.w,
                    ),
                    borderRadius: BorderRadius.circular(36.w),
                    color: Colors.transparent,
                  ),
                  child: BeeMap.fixTag[model.appReportRepairVo.type].text.black
                      .size(20.sp)
                      .make(),
                ),
                Spacer(),
                BeeMap.fixState[model.appReportRepairVo.status].text
                    .color(_getColor(_model.appReportRepairVo.status))
                    .size(24.sp)
                    .bold
                    .make()
              ],
            ),
          ),
          BeeDivider.horizontal(
            indent: 24.w,
            endIndent: 20.w,
          ),
          24.w.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: model.appReportRepairVo.reportDetail.text.black
                .size(28.sp)
                .maxLines(8)
                .overflow(TextOverflow.ellipsis)
                .make(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
            child: HorizontalImageView(
                model.appReportRepairVo.imgUrls.map((e) => e.url).toList()),
          )
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Container();
  }

  Widget _reparCard(FixedDetailModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.w),
      decoration: BoxDecoration(
          color: kForeGroundColor, borderRadius: BorderRadius.circular(8.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '维修信息'.text.black.size(32.sp).bold.make(),
          24.w.heightBox,
          BeeDivider.horizontal(),
          24.w.heightBox,
          Column(
            children: [
              Row(
                children: [
                  '订单编号'.text.color(ktextSubColor).size(28.sp).make(),
                  Spacer(),
                  model.appDispatchListVo.code.text.black.size(28.sp).make(),
                ],
              ),
              Row(
                children: [
                  '下单时间'.text.color(ktextSubColor).size(28.sp).make(),
                  Spacer(),
                  model.appDispatchListVo.orderDate.text.black
                      .size(28.sp)
                      .make()
                ],
              ),
              Row(
                children: [
                  '派单类型'.text.color(ktextSubColor).size(28.sp).make(),
                  Spacer(),
                  model.appDispatchListVo.type.text.black.size(28.sp).make(),
                ],
              ),
              Row(
                children: [
                  '维修人员'.text.color(ktextSubColor).size(28.sp).make(),
                  Spacer(),
                  model.appDispatchListVo.operatorName.text.black
                      .size(28.sp)
                      .make(),
                ],
              ),
              Row(
                children: [
                  '分配人'.text.color(ktextSubColor).size(28.sp).make(),
                  Spacer(),
                  model.appDispatchListVo.distributorName.text.black
                      .size(28.sp)
                      .make(),
                ],
              ),
            ].sepWidget(separate: 8.w.heightBox),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessCard(FixedDetailModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.w),
      decoration: BoxDecoration(
        color: kForeGroundColor,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '进程处理'.text.black.size(32.sp).bold.make(),
          24.w.heightBox,
          BeeDivider.horizontal(),
          24.w.heightBox,
          ...model.appProcessRecordVo
              .map((e) => Row(
                    children: [
                      BeeMap.processClass[e.operationType].text
                          .color(ktextSubColor)
                          .size(28.sp)
                          .make(),
                      Spacer(),
                      e.operationDate.text.black.size(28.sp).make(),
                    ],
                  ))
              .toList()
              .sepWidget(separate: 8.w.heightBox)
        ],
      ),
    );
  }

  Widget _buttons(FixedDetailModel model) {
    return Container(
      width: 228.w * 3,
      height: 96.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: kForeGroundColor,
      ),
      child: Row(
        children: [
          MaterialButton(
            height: double.infinity,
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () async {
              CancelModel _cancel =
                  _allowCancel(_model.appReportRepairVo.status);
              if (_cancel.cancel) {
                BotToast.showLoading();
                await ManagerFunc.reportRepairCancel(
                    _model.appReportRepairVo.id);
                BotToast.closeAllLoading();
                Get.back();
              } else {
                Get.dialog(
                  CupertinoAlertDialog(
                    title: _cancel.message.text.black
                        .size(30.sp)
                        .isIntrinsic
                        .make(),
                    actions: [
                      CupertinoDialogAction(
                        child: '我知道了'
                            .text
                            .color(kDarkPrimaryColor)
                            .size(36.sp)
                            .isIntrinsic
                            .make(),
                        onPressed: () => Get.back(),
                      )
                    ],
                  ),
                );
              }
            },
            textColor: ktextPrimary,
            disabledColor: kDarkSubColor.withOpacity(0.1),
            disabledTextColor: ktextSubColor.withOpacity(0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  R.ASSETS_ICONS_MANAGER_ORDER_CANCEL_PNG,
                  width: 40.w,
                  height: 40.w,
                ),
                16.w.widthBox,
                '取消订单'.text.size(28.sp).bold.make()
              ],
            ),
            elevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            disabledElevation: 0,
          ).expand(),
          BeeDivider.vertical(),
          MaterialButton(
            height: double.infinity,
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: showProcessCard ? () {} : null,
            disabledColor: kDarkSubColor.withOpacity(0.1),
            disabledTextColor: ktextSubColor.withOpacity(0.3),
            textColor: ktextPrimary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  R.ASSETS_ICONS_MANAGER_PHONE_CALL_PNG,
                  width: 40.w,
                  height: 40.w,
                  color: showProcessCard
                      ? Colors.black
                      : kDarkSubColor.withOpacity(0.5),
                ),
                16.w.widthBox,
                '致电管家'.text.size(28.sp).bold.make()
              ],
            ),
            elevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            disabledElevation: 0,
          ).expand(),
          BeeDivider.vertical(),
          MaterialButton(
            height: 96.w,
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: showRepairCard ? () {} : null,
            disabledColor: kDarkSubColor.withOpacity(0.1),
            disabledTextColor: ktextSubColor.withOpacity(0.3),
            textColor: ktextPrimary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  R.ASSETS_ICONS_MANAGER_PHONE_CALL_PNG,
                  width: 40.w,
                  height: 40.w,
                  color: showRepairCard
                      ? Colors.black
                      : kDarkSubColor.withOpacity(0.5),
                ),
                16.w.widthBox,
                '致电师傅'.text.size(28.sp).bold.make()
              ],
            ),
            elevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            disabledElevation: 0,
          ).expand()
        ],
      ),
    );
  }

  CancelModel _allowCancel(int state) {
    switch (state) {
      case 1:
      case 2:
        return CancelModel(true, '');
      case 3:
        return CancelModel(false, '订单处理中，当前无法取消订单');
      case 4:
      case 5:
        return CancelModel(false, '处理已完成，当前无法取消订单');
      case 6:
        return CancelModel(false, '处理已关闭，当前无法取消订单');
      case 7:
        return CancelModel(false, '处理已作废，当前无法取消订单');
      default:
        return CancelModel(false, '未知错误');
    }
  }

  Widget _showBottomSheet(FixedDetailModel model) {
    return BottomSheet(
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.fromLTRB(
              0, 36.w, 0.w, MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: kForeGroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  children: [
                    '维修结果'.text.black.size(32.sp).bold.isIntrinsic.make(),
                    20.w.heightBox,
                    BeeDivider.horizontal(),
                    // Padding(
                    //   padding: EdgeInsets.all(20.w),
                    //   child: FadeInImage.assetNetwork(
                    //     placeholder: R.ASSETS_EXAMPLE_BG1_PNG,
                    //     image: 'null',
                    //     width: 646.w,
                    //     height: 323.w,
                    //   ),
                    // ),
                    4.w.heightBox,
                    Row(
                      children: [
                        '维修费用总计'.text.black.size(28.sp).isIntrinsic.make(),
                        Spacer(),
                        '¥300'
                            .text
                            .color(kDangerColor)
                            .size(42.sp)
                            .bold
                            .isIntrinsic
                            .make(),
                      ],
                    ),
                    36.w.heightBox,
                    Row(
                      children: [
                        '维修人工费'.text.black.size(28.sp).isIntrinsic.make(),
                        Spacer(),
                        '¥300'
                            .text
                            .color(ktextPrimary)
                            .size(32.sp)
                            .bold
                            .isIntrinsic
                            .make(),
                      ],
                    ),
                    20.w.heightBox,
                    Row(
                      children: [
                        '维修材料费'.text.black.size(28.sp).isIntrinsic.make(),
                        Spacer(),
                        '¥0'
                            .text
                            .color(ktextPrimary)
                            .size(32.sp)
                            .bold
                            .isIntrinsic
                            .make(),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  MaterialButton(
                    textColor: ktextPrimary,
                    disabledColor: kDarkSubColor,
                    disabledTextColor: ktextPrimary.withOpacity(0.8),
                    minWidth: 375.w,
                    onPressed: _canComplete(_model.appReportRepairVo.status)
                        ? () async {
                            BaseModel baseModel =
                                await ManagerFunc.reportRepairComplete(
                                    _model.appReportRepairVo.id);
                            if (baseModel.status) {
                              Get.back();
                              Get.back();
                            }
                          }
                        : null,
                    child: '完成维修'.text.size(32.sp).bold.make(),
                    padding: EdgeInsets.symmetric(vertical: 26.w),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    color: kPrimaryColor,
                  ).expand(),
                  MaterialButton(
                    minWidth: 375.w,
                    onPressed: () {
                      Get.off(FixedEvaluatePage(_model));
                    },
                    child: '立即评价'.text.white.size(32.sp).bold.make(),
                    padding: EdgeInsets.symmetric(vertical: 26.w),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    color: Colors.black,
                  ).expand(),
                ],
              ),
            ],
          ),
        );
      },
      onClosing: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '报事报修',
      body: EasyRefresh(
        firstRefresh: true,
        controller: _easyRefreshController,
        onRefresh: () async {
          _model = await ManagerFunc.reportRepairFindBYLD(widget.id);
          _onLoading = false;
          setState(() {});
        },
        header: MaterialHeader(),
        child: _onLoading
            ? _buildEmpty()
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 36.w),
                children: <Widget>[
                  _buildHead(_model),
                  ...showRepairCard ? [_reparCard(_model)] : [],
                  ...showProcessCard ? [_buildProcessCard(_model)] : [],
                  _buttons(_model),
                ].sepWidget(separate: 16.w.heightBox),
              ),
      ),
      bottomNavi: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 39.w,
            left: 32.w,
            right: 32.w),
        child: MaterialButton(
          minWidth: 686.w,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.w)),
          color: kPrimaryColor,
          padding: EdgeInsets.symmetric(vertical: 26.w),
          elevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Get.bottomSheet(_showBottomSheet(_model));
          },
          child: '确认完成'.text.black.size(32.sp).bold.make(),
        ),
      ),
    );
  }
}
