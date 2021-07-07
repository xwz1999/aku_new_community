import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/bee_input_row.dart';
import 'package:aku_community/widget/others/house_head_card.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class RefundBondPage extends StatefulWidget {
  final String name;
  final double bond;
  final String date;
  final int id;
  RefundBondPage(
      {Key? key,
      required this.name,
      required this.bond,
      required this.date,
      required this.id})
      : super(key: key);

  @override
  _RefundBondPageState createState() => _RefundBondPageState();
}

class _RefundBondPageState extends State<RefundBondPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      bgColor: Colors.white,
      title: '保证金信息',
      body: ListView(
        children: [
          HouseHeadCard(context: context),
          Column(
            children: [
              BeeInputRow.button(
                  title: '承租人姓名', hintText: widget.name, onPressed: () {}),
              BeeInputRow.button(
                  title: '保证金',
                  hintText: widget.bond.toStringAsFixed(2),
                  onPressed: () {}),
              BeeInputRow.button(
                  title: '保证金缴纳时间', hintText: widget.date, onPressed: () {}),
            ],
          ).paddingSymmetric(horizontal: 32.w)
        ],
      ),
      bottomNavi: BottomButton(
          onPressed: () async {
            Function cancel = BotToast.showLoading();
            bool result = await HouseFunc().refundBond(widget.id);
            if (result) {
              Get.back();
              Get.back();
            }
            cancel();
          },
          child: '提交退款申请'.text.size(32.sp).color(ktextPrimary).bold.make()),
    );
  }
}
