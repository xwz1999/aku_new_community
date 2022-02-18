import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/ui/profile/house/contract_stop/refund_bond_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/finish_result_image.dart';

class PayResultPage extends StatefulWidget {
  final String name;
  final double bond;
  final String date;
  final int id;

  PayResultPage(
      {Key? key,
      required this.name,
      required this.bond,
      required this.date,
      required this.id})
      : super(key: key);

  @override
  _PayResultPageState createState() => _PayResultPageState();
}

class _PayResultPageState extends State<PayResultPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '支付信息',
      body: Center(
        child: Column(
          children: [
            276.w.heightBox,
            FinishResultImage(
              status: true,
            ),
            48.w.heightBox,
            '已支付剩余租金'.text.black.size(36.sp).make(),
            96.w.heightBox,
            MaterialButton(
              elevation: 0,
              minWidth: 702.w,
              height: 98.w,
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.w)),
              onPressed: () async {
                Get.to(() => RefundBondPage(
                    name: widget.name,
                    bond: widget.bond,
                    date: widget.date,
                    id: widget.id));
              },
              child: '申请保证金退还'.text.color(ktextPrimary).size(36.sp).make(),
            ),
          ],
        ),
      ),
    );
  }
}
