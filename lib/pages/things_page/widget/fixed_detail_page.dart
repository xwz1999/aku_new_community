import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/model/manager/fixed_detail_model.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/utils/bee_map.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/views/horizontal_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akuCommunity/utils/headers.dart';

class FixedDetailPage extends StatefulWidget {
  final int id;
  FixedDetailPage(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _FixedDetailPageState createState() => _FixedDetailPageState();
}

class _FixedDetailPageState extends State<FixedDetailPage> {
  bool _onLoading = true;
  EasyRefreshController _easyRefreshController;
  FixedDetailModel _model=FixedDetailModel();
  bool get showRepairCard => _model?.appDispatchListVo!=null;
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
                  child: BeeMap()
                      .fixTag[model.appReportRepairVo.type]
                      .text
                      .black
                      .size(20.sp)
                      .make(),
                ),
                Spacer(),
                BeeMap()
                    .fixState[model.appReportRepairVo.status]
                    .text
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
                children: [
                  _buildHead(_model),
                  showRepairCard?_reparCard(_model):null,
                  
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
          onPressed: () {},
          child: '确认完成'.text.black.size(32.sp).bold.make(),
        ),
      ),
    );
  }
}
