import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/model/manager/life_pay_model.dart';
import 'package:akuCommunity/utils/bee_parse.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/bee_check_box.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:get/get.dart';

class LifePayDetailPage extends StatefulWidget {
  final LifePayMolde model;
  LifePayDetailPage({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _LifePayDetailPageState createState() => _LifePayDetailPageState();
}

class _LifePayDetailPageState extends State<LifePayDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
        title:
            '${BeeParse.getCustomYears(widget.model.years)}-${widget.model.years}年明细',
            body: ListView(
              padding: EdgeInsets.only(top: 16.w),
              children: [

              ],
            ),
    bottomNavi: Container(
        padding: EdgeInsets.fromLTRB(
            32.w, 16.w, 32.w, 12.w + MediaQuery.of(context).padding.bottom),
        child: Row(
          children: [
            BeeCheckBox.round(
              onChange: (value) {},
              size: 40.w,
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                    text: TextSpan(
                        text: '合计：',
                        style: TextStyle(
                            color: ktextPrimary,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                          text: '¥3009.84',
                          style: TextStyle(
                              color: kDangerColor,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold)),
                    ])),
                '已选10项'.text.color(ktextSubColor).size(20.sp).make(),
              ],
            ),
            MaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(37.w)),
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
              onPressed: () {
                Get.back();
              },
              child: '选好了'.text.black.size(32.sp).bold.make(),
            ),
          ],
        ),
      ),
            );
  }
}
