import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';
import 'package:aku_community/widget/bee_divider.dart';

class ExpressPackageCard extends StatefulWidget {
  final int index;
  ExpressPackageCard({Key? key, required this.index}) : super(key: key);

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
                '3号柜7号箱',
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
                '131891726735'.text.size(24.sp).color(ktextSubColor).make()),
            _rowTile(R.ASSETS_ICONS_APPOINTMENT_ADDRESS_PNG, '收件人',
                '小蒋'.text.size(24.sp).color(ktextSubColor).make()),
            _rowTile(R.ASSETS_ICONS_APPOINTMENT_ADDRESS_PNG, '联系方式',
                '131891726735'.text.size(24.sp).color(ktextSubColor).make()),
            _rowTile(R.ASSETS_ICONS_APPOINTMENT_ADDRESS_PNG, '配送公司',
                '顺丰速递'.text.size(24.sp).color(ktextSubColor).make()),
            _rowTile(
                R.ASSETS_ICONS_APPOINTMENT_DATE_PNG,
                '送达时间',
                '2020-04-13 11:21'
                    .text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make()),
          ].sepWidget(separate: 12.w.heightBox),
          40.w.heightBox,
          Row(
            children: [
              Spacer(),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(74.w)),
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
                height: 50.w,
                color: kPrimaryColor,
                elevation: 0,
                focusElevation: 0,
                hoverElevation: 0,
                disabledElevation: 0,
                highlightElevation: 0,
                onPressed: () {},
                child: '确认领取'.text.size(24.sp).bold.color(ktextPrimary).make(),
              )
            ],
          ),
        ],
      ),
    );
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
