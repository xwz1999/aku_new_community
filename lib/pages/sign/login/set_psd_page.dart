import 'package:aku_new_community/pages/sign/login/forgot_psd_page.dart';
import 'package:aku_new_community/pages/sign/login/psd_verify.dart';
import 'package:aku_new_community/pages/sign/sign_func.dart';
import 'package:aku_new_community/pages/sign/widget/login_button_widget.dart';
import 'package:aku_new_community/pages/sign/widget/psd_text_field.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SetPsdPage extends StatefulWidget {
  const SetPsdPage({Key? key}) : super(key: key);

  @override
  _SetPsdPageState createState() => _SetPsdPageState();
}

class _SetPsdPageState extends State<SetPsdPage> {
  TextEditingController _psdController = TextEditingController();
  TextEditingController _confirmPsdController = TextEditingController();

  PSDVERIFY get psdCheck =>
      PsdVerify.check(_psdController.text, _confirmPsdController.text);

  @override
  void initState() {
    _psdController.addListener(() {
      setState(() {});
    });
    _confirmPsdController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _psdController.removeListener(() {});
    _confirmPsdController.removeListener(() {});
    _psdController.dispose();
    _confirmPsdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '',
      bodyColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          24.w.heightBox,
          Row(
            children: [
              48.w.widthBox,
              '首次登陆，请设置账号密码'
                  .text
                  .size(36.sp)
                  .bold
                  .color(Colors.black.withOpacity(0.65))
                  .make(),
              Spacer(),
            ],
          ),
          16.w.heightBox,
          Row(
            children: [
              48.w.widthBox,
              '密码需由6-20位数字、字母、或符号组成，至少两种'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              Spacer(),
            ],
          ),
          144.w.heightBox,
          PsdTextField(controller: _psdController, hintText: '请输入密码'),
          24.w.heightBox,
          PsdTextField(controller: _confirmPsdController, hintText: '请再次输入密码'),
          16.w.heightBox,
          PsdVerify.checkString(psdCheck)
              .text
              .size(28.sp)
              .color(Color(0xFFCF1322).withOpacity(0.8))
              .make(),
          37.w.heightBox,
          LoginButtonWidget(
              onTap: psdCheck == PSDVERIFY.correct
                  ? () async {
                      var result =
                          await SignFunc.settingPsd(_psdController.text);
                      if (result) {
                        Get.to(() => ForgotPsdPage());
                      }
                    }
                  : null,
              text: '确认'),
        ],
      ),
    );
  }
}
