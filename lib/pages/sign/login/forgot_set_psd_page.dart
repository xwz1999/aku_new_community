import 'package:aku_new_community/pages/sign/login/psd_verify.dart';
import 'package:aku_new_community/pages/sign/sign_func.dart';
import 'package:aku_new_community/pages/sign/widget/login_button_widget.dart';
import 'package:aku_new_community/pages/sign/widget/psd_text_field.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login_page.dart';

class ForgotSetPsdPage extends StatefulWidget {
  final String tel;

  const ForgotSetPsdPage({Key? key, required this.tel}) : super(key: key);

  @override
  _ForgotSetPsdPageState createState() => _ForgotSetPsdPageState();
}

class _ForgotSetPsdPageState extends State<ForgotSetPsdPage> {
  TextEditingController _psdController = TextEditingController();
  TextEditingController _confirmPsdController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

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
    _codeController.dispose();
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
              '已向 '
                  .richText
                  .withTextSpanChildren([
                    widget.tel.textSpan
                        .size(36.sp)
                        .color(Colors.red)
                        .bold
                        .make(),
                    ' 发送验证码'
                        .textSpan
                        .size(36.sp)
                        .color(Colors.black.withOpacity(0.65))
                        .bold
                        .make()
                  ])
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
          Container(
            width: 686.w,
            height: 94.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.w),
              color: Colors.black.withOpacity(0.06),
            ),
            child: TextField(
              onChanged: (text) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _codeController,
              decoration: InputDecoration(
                  isDense: false,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
                  border: InputBorder.none,
                  hintText: '请输入验证码',
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 100.w, maxHeight: 100.w),
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      var base = await SignFunc.sendMessageCode(
                          widget.tel,
                          UserTool.appProvider.pickedCityAndCommunity!
                              .communityModel!.id);
                      if (base.success) {
                        Get.to(() => ForgotSetPsdPage(
                              tel: widget.tel,
                            ));
                        UserTool.appProvider.startTimer();
                      } else {
                        BotToast.showText(text: base.msg);
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        '｜${UserTool.appProvider.second < 60 ? '${UserTool.appProvider.second}秒后重新获取' : '获取验证码'}'
                            .text
                            .size(28.sp)
                            .color(Color(0xFF5096F1))
                            .make(),
                        20.w.widthBox,
                      ],
                    ),
                  ),
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.25), fontSize: 28.sp)),
            ),
          ),
          24.w.heightBox,
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
              onTap: (psdCheck == PSDVERIFY.correct &&
                      _codeController.text.isNotEmpty)
                  ? () async {
                      var result = await SignFunc.settingForgotPsd(
                          _psdController.text,
                          widget.tel,
                          _codeController.text);
                      if (result) {
                        Get.offAll(() => LoginPage());
                      }
                    }
                  : null,
              text: '确认'),
        ],
      ),
    );
  }
}
