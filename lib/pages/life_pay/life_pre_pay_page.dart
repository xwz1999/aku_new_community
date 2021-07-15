import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/bottom_sheets/pay_mothod_bottom_sheet.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/bee_input_row.dart';
import 'package:aku_community/widget/others/house_head_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LifePrePayPage extends StatefulWidget {
  LifePrePayPage({Key? key}) : super(key: key);

  @override
  _LifePrePayPageState createState() => _LifePrePayPageState();
}

class _LifePrePayPageState extends State<LifePrePayPage> {
  late TextEditingController _editingController;
  String _payMethod = '支付宝';
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '预缴充值',
      body: ListView(
        children: [
          HouseHeadCard(context: context),
          16.w.heightBox,
          Container(
            padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                '预缴金额'.text.size(28.sp).black.make(),
                30.w.heightBox,
                Row(
                  children: [
                    '¥'.text.size(28.sp).black.bold.make(),
                    16.w.widthBox,
                    TextField(
                      controller: _editingController,
                      decoration: InputDecoration(
                        hintText: '0.0',
                        hintStyle: TextStyle(
                          fontSize: 56.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        fontSize: 56.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                    ).expand(),
                  ],
                ),
                16.w.heightBox,
                BeeDivider.horizontal(),
                16.w.heightBox,
                '当前房屋下的预缴金额为 '
                    .richText
                    .withTextSpanChildren([
                      '2300'
                          .textSpan
                          .bold
                          .size(28.sp)
                          .color(kPrimaryColor)
                          .make(),
                      ' 元'.textSpan.size(28.sp).black.make()
                    ])
                    .black
                    .size(28.sp)
                    .make(),
                16.w.heightBox,
                '当账单到期时，将会自动从当前房屋下的预缴金额中扣除相应费用。'
                    .text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make(),
              ],
            ),
          ),
          16.w.heightBox,
          // Container(
          //   width: double.infinity,
          //   color: Colors.white,
          //   padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
          //   child: Row(
          //     children: [
          //       '缴费方式'.text.size(28.sp).black.make(),
          //       Spacer(),
          //       TextButton(
          //           onPressed: () async {
          //             Get.bottomSheet(PayMethodBottomSheet(onChoose: (value) {
          //               _paymethod = value;
          //               Get.back();
          //               setState(() {});
          //             }));
          //           },
          //           child: _paymethod.text.size(28.sp).black.make()),
          //       24.w.widthBox,
          //       Icon(
          //         CupertinoIcons.chevron_right,
          //         size: 40.w,
          //       ),
          //     ],
          //   ),
          // ),
          BeeInputRow.button(
              title: '支付方式',
              hintText: _payMethod,
              onPressed: () {
                Get.bottomSheet(PayMethodBottomSheet(onChoose: (value) {
                  _payMethod = value;
                  Get.back();
                  setState(() {});
                }));
              }),
        ],
      ),
      bottomNavi: BottomButton(
          onPressed: () {}, child: '立即充值'.text.size(32.sp).bold.black.make()),
    );
  }
}
