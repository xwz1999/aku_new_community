import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/models/house/lease_detail_model.dart';
import 'package:aku_new_community/pages/life_pay/pay_finish_page.dart';
import 'package:aku_new_community/pages/life_pay/pay_util.dart';
import 'package:aku_new_community/ui/profile/house/house_func.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/bottom_sheets/pay_mothod_bottom_sheet.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/others/bee_input_row.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:power_logger/power_logger.dart';
import 'package:velocity_x/velocity_x.dart';

class ContractPayPage extends StatefulWidget {
  final int id;

  ContractPayPage({Key? key, required this.id}) : super(key: key);

  @override
  _ContractPayPageState createState() => _ContractPayPageState();
}

class _ContractPayPageState extends State<ContractPayPage> {
  String _contractCode = '';
  num _payTotal = 0;
  LeaseDetailModel? _model;
  String _payMethod = '选择支付方式';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () async {
      _model = (await HouseFunc().leaseDetail(widget.id));
      if (_model != null) {
        _contractCode = _model!.code;
        _payTotal = _model!.margin;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '支付信息',
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        children: [
          BeeInputRow.button(
            onPressed: () {},
            hintText: _contractCode,
            title: '合同编号',
            isRequire: true,
          ),
          BeeInputRow.button(
              title: '保证金金额(元)',
              onPressed: () {},
              hintText: _payTotal.toStringAsFixed(2)),
          BeeInputRow.button(
              title: '支付方式',
              hintText: _payMethod,
              onPressed: () async {
                Get.bottomSheet(PayMethodBottomSheet(onChoose: (value) {
                  _payMethod = value;
                  Get.back();
                  setState(() {});
                }));
              }),
        ].sepWidget(separate: 24.w.heightBox),
      ),
      bottomNavi: BottomButton(
        child: '点击支付'.text.size(32.sp).bold.color(ktextPrimary).make(),
        onPressed: () async {
          Function cancel = BotToast.showLoading();
          try {
            String code = await HouseFunc()
                .leaseAlipay(widget.id, 1, _model!.margin.toDouble());
            if (code.isNotEmpty) {
              bool result =
                  await PayUtil().callAliPay(code, API.pay.leaseCheckAlipay);
              if (result) {
                Get.off(() => PayFinishPage());
              }
            }
          } catch (e) {
            LoggerData.addData(e);
          }
          cancel();
        },
      ),
    );
  }
}
