import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/models/express_package/express_package_list_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpressPackageCard extends StatefulWidget {
  final int index;
  final ExpressPackageListModel model;
  final VoidCallback callFresh;

  ExpressPackageCard(
      {Key? key,
      required this.index,
      required this.model,
      required this.callFresh})
      : super(key: key);

  @override
  _ExpressPackageCardState createState() => _ExpressPackageCardState();
}

class _ExpressPackageCardState extends State<ExpressPackageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.model.placePosition,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: ktextPrimary,
                ),
              ),
              Spacer(),
              (widget.index == 0 ? '未领取' : '已领取')
                  .text
                  .size(30.sp)
                  .color(ktextPrimary)
                  .bold
                  .make(),
            ],
          ),
          16.w.heightBox,
          BeeDivider.horizontal(),
          24.w.heightBox,
          ...<Widget>[
            _rowTile(R.ASSETS_ICONS_APPOINTMENT_ADDRESS_PNG, '包裹单号',
                widget.model.code.text.size(24.sp).color(ktextSubColor).make()),
            _rowTile(
                R.ASSETS_ICONS_APPOINTMENT_ADDRESS_PNG,
                '收件人',
                widget.model.addresseeName.text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make()),
            _rowTile(
                R.ASSETS_ICONS_APPOINTMENT_ADDRESS_PNG,
                '联系方式',
                widget.model.addresseeTel.text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make()),
            _rowTile(
                R.ASSETS_ICONS_APPOINTMENT_DATE_PNG,
                '送达时间',
                widget.model.createDateString.text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make()),
          ].sepWidget(separate: 12.w.heightBox),
          ...widget.index == 1
              ? [SizedBox()]
              : [
                  40.w.heightBox,
                  Row(
                    children: [
                      Spacer(),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(74.w)),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.w, horizontal: 24.w),
                        height: 50.w,
                        color: kPrimaryColor,
                        elevation: 0,
                        focusElevation: 0,
                        hoverElevation: 0,
                        disabledElevation: 0,
                        highlightElevation: 0,
                        onPressed: () async {
                          bool confirm = false;
                          confirm =
                              await _cofirmReceivePackage(widget.model.id);
                          if (confirm) {
                            widget.callFresh();
                          }
                        },
                        child: '确认领取'
                            .text
                            .size(24.sp)
                            .bold
                            .color(ktextPrimary)
                            .make(),
                      )
                    ],
                  ),
                ],
        ],
      ),
    );
  }

  Future _cofirmReceivePackage(int id) async {
    BaseModel baseModel = await NetUtil().get(
      API.manager.packageConfirm,
      params: {
        "packageCollectionId": id,
      },
    );
    if (baseModel.status ?? false) {
      BotToast.showText(text: baseModel.message ?? '未知错误');
    }
    return baseModel.status;
  }

  Widget _rowTile(String assetPath, String titile, Widget content) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 40.w,
          height: 40.w,
        ),
        12.w.widthBox,
        titile.text.size(24.sp).color(ktextSubColor).make(),
        Spacer(),
        content,
      ],
    );
  }
}
