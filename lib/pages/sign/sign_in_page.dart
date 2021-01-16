import 'dart:async';
import 'dart:ui';

import 'package:akuCommunity/pages/setting_page/agreement_page/agreement_page.dart';
import 'package:akuCommunity/pages/setting_page/agreement_page/privacy_page.dart';
import 'package:akuCommunity/pages/sign/sign_func.dart';
import 'package:akuCommunity/extensions/num_ext.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/pages/sign/sign_up/sign_up_pick_plot_page.dart';
import 'package:akuCommunity/pages/tab_navigator.dart';
import 'package:akuCommunity/provider/sign_up_provider.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:ani_route/ani_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart' show TextUtil;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _phone = new TextEditingController();
  TextEditingController _code = new TextEditingController();
  AppBar get _appBar => AppBar(elevation: 0, backgroundColor: Colors.white);

  Timer _timer;
  bool get validPhone => RegexUtil.isMobileSimple(_phone.text);

  bool get _canGetCode {
    bool timerActive = _timer?.isActive ?? false;
    return (!timerActive) && validPhone;
  }

  Container _containerImage() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        AssetsImage.LOGO,
        height: 184.w,
        width: 266.w,
      ),
    );
  }

  Future<bool> _showLoginVerify() async {
    return await showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('点击登录即表示您已阅读并同意'),
          content: Text(
              '''点击登录即表示您已阅读并同意《小蜜蜂用户协议》《小蜜蜂隐私政策》（特别是免除或限制责任、管辖等粗体下划线标注的条款）。如您不同意上述协议的任何条款，您应立即停止登录及使用本软件及服务。'''),
          actions: [
            CupertinoDialogAction(
              child: Text('同意'),
              onPressed: () => Get.back(result: true),
            ),
            CupertinoDialogAction(
              child: Text('拒绝'),
              onPressed: () => Get.back(result: false),
            ),
          ],
        );
      },
    );
  }

  _parseLogin(bool result) async {
    final userProvider = Provider.of<UserProvider>(Get.context, listen: false);
    final signUpProvider =
        Provider.of<SignUpProvider>(Get.context, listen: false);
    if (!result) return;
    CancelFunc cancel = BotToast.showLoading();
    Response response = await SignFunc.login(_phone.text, _code.text);

    if (response.data['status']) {
      if (response.data['choose'] == 1) {
        userProvider.setLogin(response.data['token'] as String);

        Get.offAll(TabNavigator());
      } else {
        cancel();
        signUpProvider.setTel(_phone.text);
        await Get.to(SignUpPickPlotPage());
        signUpProvider.clearAll();
      }
    } else {
      BotToast.showText(text: response.data['message']);
      cancel();
    }
  }

  Widget _inkWellLogin() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w),
      child: MaterialButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (TextUtil.isEmpty(_phone.text))
            BotToast.showText(text: '手机号不能为空');
          else if (TextUtil.isEmpty(_code.text))
            BotToast.showText(text: '验证码不能为空');
          else {
            bool result = await _showLoginVerify();
            _parseLogin(result);
          }
        },
        height: 89.w,
        shape: StadiumBorder(),
        elevation: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: '登陆'.text.bold.size(28.sp).color(ktextPrimary).make(),
        color: kPrimaryColor,
      ),
    );
  }

  startTick() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick >= 60) {
        _timer.cancel();
        _timer = null;
      }
      setState(() {});
    });
  }

  _buildTextField({
    String hint,
    Widget prefix,
    Widget suffix,
    TextEditingController controller,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 82.w),
      decoration: BoxDecoration(
        color: Color(0xFFFFF4D7),
        borderRadius: BorderRadius.circular(42.w),
      ),
      child: Row(
        children: [
          36.wb,
          82.hb,
          prefix ?? SizedBox(),
          20.wb,
          TextField(
            controller: controller,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 28.sp,
              ),
            ),
          ).expand(),
          suffix != null
              ? Container(
                  height: 29.w,
                  width: 2.w,
                  color: Color(0xFFD8D8D8),
                )
              : SizedBox(),
          suffix ?? SizedBox(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                153.hb,
                _containerImage(),
                16.hb,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '欢迎登录小蜜蜂',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: BaseStyle.fontSize38,
                        color: ktextPrimary),
                  ),
                ),
                89.hb,
                _buildTextField(
                  hint: '请输入手机号',
                  controller: _phone,
                  prefix: Image.asset(
                    R.ASSETS_IMAGES_PHONE_LOGO_PNG,
                    height: 50.w,
                    width: 50.w,
                  ),
                ),
                26.hb,
                _buildTextField(
                  prefix: Image.asset(
                    R.ASSETS_IMAGES_CODE_LOGO_PNG,
                    height: 50.w,
                    width: 50.w,
                  ),
                  hint: '请输入验证码',
                  controller: _code,
                  suffix: MaterialButton(
                    height: 82.w,
                    shape: StadiumBorder(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text(
                      _timer?.isActive ?? false
                          ? '${60 - _timer.tick}'
                          : '获取验证码',
                      style: TextStyle(
                        color: BaseStyle.color999999,
                        fontSize: BaseStyle.fontSize28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: _canGetCode
                        ? () {
                            SignFunc.sendMessageCode(_phone.text);
                            startTick();
                          }
                        : null,
                  ),
                ),
                SizedBox(height: 59.w),
                _inkWellLogin(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ARoute.push(context, AgreementPage());
                        },
                        child: Text(
                          '《小蜜蜂用户协议》',
                          style: TextStyle(
                            color: Colors.lightBlue,
                          ),
                        )),
                    SizedBox(width: 15.w),
                    FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ARoute.push(context, PrivacyPage());
                        },
                        child: Text(
                          '《小蜜蜂隐私政策》',
                          style: TextStyle(
                            color: Colors.lightBlue,
                          ),
                        ))
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
