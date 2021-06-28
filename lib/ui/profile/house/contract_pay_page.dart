import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/pages/life_pay/pay_finish_page.dart';
import 'package:aku_community/pages/life_pay/pay_util.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/bee_input_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';

class ContractPayPage extends StatefulWidget {
  final int id;

  ContractPayPage({Key? key, required this.id}) : super(key: key);

  @override
  _ContractPayPageState createState() => _ContractPayPageState();
}

class _ContractPayPageState extends State<ContractPayPage> {
  late TextEditingController _contractCodeController;
  late TextEditingController _payTotalController;
  String _payMethod = '选择支付方式';
  @override
  void initState() {
    super.initState();
    _contractCodeController = TextEditingController();
    _payTotalController = TextEditingController();
  }

  @override
  void dispose() {
    _contractCodeController.dispose();
    _payTotalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '支付信息',
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        children: [
          BeeInputRow(
            controller: _contractCodeController,
            hintText: '请填写合同编号',
            title: '合同编号',
            isRequire: true,
          ),
          BeeInputRow(
              title: '保证金金额(元)',
              controller: _payTotalController,
              hintText: '填写保证金金额'),
          BeeInputRow.button(
              title: '支付方式',
              hintText: _payMethod,
              onPressed: () async {
                Get.bottomSheet(
                  _payMethodSheet(),
                );
              }),
        ].sepWidget(separate: 24.w.heightBox),
      ),
      bottomNavi: BottomButton(
        child: '点击支付'.text.size(32.sp).bold.color(ktextPrimary).make(),
        onPressed: () async {
          String code = await HouseFunc().leaseAlipay(widget.id, 1, 0.01);
          bool result =
              await PayUtil().callAliPay(code, API.pay.leaseCheckAlipay);
          if (result) {
            Get.off(() => PayFinishPage());
          }
        },
      ),
    );
  }

  Widget _payMethodSheet() {
    return CupertinoActionSheet(
      title:
          '支付方式'.text.size(32.sp).bold.color(ktextPrimary).isIntrinsic.make(),
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
              _payMethod = '支付宝';
              Get.back();
              setState(() {});
            },
            child:
                '支付宝'.text.size(32.sp).color(ktextPrimary).isIntrinsic.make())
      ],
    );
  }
}
