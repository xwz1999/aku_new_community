import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/ui/profile/house/contract_stop/refund_bond_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/finish_result_image.dart';

class RefundBondResultPage extends StatefulWidget {
  final int status;
  final String name;
  final double bond;
  final String date;
  final int id;

  RefundBondResultPage(
      {Key? key,
      required this.status,
      required this.name,
      required this.bond,
      required this.date,
      required this.id})
      : super(key: key);

  @override
  _RefundBondResultPageState createState() => _RefundBondResultPageState();
}

class _RefundBondResultPageState extends State<RefundBondResultPage> {
  String get statusString {
    switch (widget.status) {
      case 15:
        return '申请退还保证金审核中';
      case 16:
        return '申请退还保证金驳回';
      case 17:
        return '申请保证金退还成功';

      default:
        return '未知';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '保证金退还情况',
      body: Center(
        child: Column(
          children: [
            276.w.heightBox,
            FinishResultImage(
              status: widget.status == 16 ? false : true,
              haveInHandStatus: widget.status == 15 ? true : false,
            ),
            48.w.heightBox,
            statusString.text.black.size(36.sp).make(),
            96.w.heightBox,
            widget.status == 16
                ? MaterialButton(
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
                    child: '重新申请'.text.color(ktextPrimary).size(36.sp).make(),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
