import 'dart:async';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/provider/sign_up_provider.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _phone = new TextEditingController();
  TextEditingController _code = new TextEditingController();

  Timer? _timer;

  bool get validPhone => RegexUtil.isMobileSimple(_phone.text);

  bool get _canGetCode {
    bool timerActive = _timer?.isActive ?? false;
    return (!timerActive) && validPhone;
  }

  Container _containerImage() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        R.ASSETS_IMAGES_LOGO_PNG,
        height: 184.w,
        width: 266.w,
      ),
    );
  }

  _parseLogin(bool result) async {
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);
    final signUpProvider =
        Provider.of<SignUpProvider>(Get.context!, listen: false);
    if (!result) return;
    CancelFunc cancel = BotToast.showLoading();
    // Response response = await SignFunc.login(_phone.text, _code.text);
    // LoggerData.addData(response);
    //
    // if (response.data['status']) {
    //   if (response.data['choose'] == 1) {
    //     userProvider.setLogin(response.data['token']);
    //     cancel();
    //     Get.offAll(() => TabNavigator());
    //   } else {
    //     cancel();
    //     signUpProvider.setTel(_phone.text);
    //     await Get.to(() => SignUpSetNicknamePage());
    //     signUpProvider.clearAll();
    //   }
    // } else {
    //   BotToast.showText(text: response.data['message']);
    //   cancel();
    // }
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
            // bool? result = await _showLoginVerify();
            // if (result != null) _parseLogin(result);
            _parseLogin(true);
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
        _timer!.cancel();
        _timer = null;
      }
      setState(() {});
    });
  }

  _buildTextField({
    String? hint,
    Widget? prefix,
    Widget? suffix,
    TextInputType type = TextInputType.number,
    TextEditingController? controller,
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
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            keyboardType: type,
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
    return BeeScaffold(
      leading: BeeBackButton(),
      title: '',
      bgColor: Colors.white,
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
                  type: TextInputType.number,
                  prefix: Image.asset(
                    R.ASSETS_IMAGES_CODE_LOGO_PNG,
                    height: 50.w,
                    width: 50.w,
                  ),
                  hint: '请输入验证码',
                  controller: _code,
                  suffix: MaterialButton(
                    height: 82.w,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(41.w)),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text(
                      _timer?.isActive ?? false
                          ? '${60 - _timer!.tick}'
                          : '获取验证码',
                      style: TextStyle(
                        color: BaseStyle.color999999,
                        fontSize: BaseStyle.fontSize28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: _canGetCode
                        ? () {
                            // SignFunc.sendMessageCode(_phone.text);
                            startTick();
                          }
                        : null,
                  ),
                ),
                SizedBox(height: 59.w),
                _inkWellLogin(),
                10.hb,
              ],
            )),
      ),
    );
  }
}
