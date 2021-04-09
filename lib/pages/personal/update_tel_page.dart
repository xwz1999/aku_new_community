import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/sign/sign_func.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class UpdateTelPage extends StatefulWidget {
  UpdateTelPage({Key key}) : super(key: key);

  @override
  _UpdateTelPageState createState() => _UpdateTelPageState();
}

class _UpdateTelPageState extends State<UpdateTelPage> {
  TextEditingController _oldTelController;
  TextEditingController _newTelController;
  TextEditingController _codeController;
  Timer _timer;
  bool get validPhone => RegexUtil.isMobileSimple(_newTelController.text);
  bool get _canGetCode {
    bool timeActive = _timer?.isActive ?? false;
    return (!timeActive) && validPhone;
  }

  @override
  void initState() {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    _oldTelController = TextEditingController();
    _newTelController = TextEditingController();
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _codeController?.dispose();
    _oldTelController?.dispose();
    _newTelController?.dispose();
    super.dispose();
  }

  startTick() {
    _timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      if (_timer.tick >= 60) {
        _timer.cancel();
        _timer = null;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      title: '修改手机号',
      body: Material(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: ListView(
            children: [
              55.w.heightBox,
              '旧号码'.text.black.size(28.sp).make(),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]*'))
                ],
                controller: _oldTelController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: '请输入旧号码',
                  hintStyle:
                      TextStyle(color: Color(0xFF999999), fontSize: 34.sp),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFEEEEEE),
                    width: 1.w,
                  )),
                ),
              ),
              24.w.heightBox,
              '新号码'.text.black.size(28.sp).make(),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                controller: _newTelController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 0.w, minWidth: 0.w),
                  suffixIcon: MaterialButton(
                    onPressed: _canGetCode
                        ? () {
                            SignFunc.sendNewMessageCode(_newTelController.text);
                            startTick();
                          }
                        : () {},
                    child: _timer?.isActive ?? false
                        ? '${60 - _timer.tick}'
                            .text
                            .color(kPrimaryColor)
                            .size(28.sp)
                            .make()
                        : '获取验证码'.text.color(kPrimaryColor).size(28.sp).make(),
                    padding: EdgeInsets.zero,
                    minWidth: 177.w,
                    height: 62.w,
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    disabledElevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                      color: kDarkPrimaryColor,
                      width: 1.w,
                    )),
                  ),
                  contentPadding: EdgeInsets.only(top: 20.w),
                  hintText: '请输入新号码',
                  hintStyle:
                      TextStyle(color: Color(0xFF999999), fontSize: 34.sp),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEEEEEE),
                      width: 1.w,
                    ),
                  ),
                ),
              ),
              24.w.heightBox,
              '验证码'.text.black.size(28.sp).make(),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                keyboardType: TextInputType.number,
                controller: _codeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: '请输入验证码',
                  hintStyle:
                      TextStyle(color: Color(0xFF999999), fontSize: 34.sp),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFEEEEEE),
                    width: 1.w,
                  )),
                ),
              ),
              64.w.heightBox,
              MaterialButton(
                onPressed: () {
                  if (TextUtil.isEmpty(_oldTelController.text)) {
                    BotToast.showText(text: '旧手机号不能为空');
                  } else if (TextUtil.isEmpty(_newTelController.text)) {
                    BotToast.showText(text: '新手机号不能为空');
                  } else if (TextUtil.isEmpty(_codeController.text)) {
                    BotToast.showText(text: '验证码不能为空');
                  } else {
                    userProvider.updateTel(_oldTelController.text,
                        _newTelController.text, _codeController.text);
                    Get.back();
                  }
                },
                child: '保存'.text.black.size(32.sp).make(),
                color: Color(0xFFFFC40C),
                elevation: 0,
                minWidth: 686.w,
                height: 85.w,
              ),
              24.w.heightBox,
              '注：新手机号将作为您的登录凭证'
                  .text
                  .color(Color(0xFF999999))
                  .size(24.sp)
                  .maxLines(2)
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
