// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:random_character/chinese_character/random_chinese_charater.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/sign/sign_up/sign_up_common_widget.dart';
import 'package:akuCommunity/pages/sign/sign_up/sign_up_verify_page.dart';
import 'package:akuCommunity/provider/sign_up_provider.dart';
import 'package:akuCommunity/utils/headers.dart';

class SignUpSetNicknamePage extends StatefulWidget {
  SignUpSetNicknamePage({Key key}) : super(key: key);

  @override
  _SignUpSetNicknamePageState createState() => _SignUpSetNicknamePageState();
}

class _SignUpSetNicknamePageState extends State<SignUpSetNicknamePage> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        children: [
          148.hb,
          signUpTitle('设置昵称'),
          190.hb,
          '请输入您的昵称'.text.size(32.sp).color(ktextPrimary).make(),
          Form(
            key: _globalKey,
            child: TextFormField(
              controller: _textEditingController,
              validator: (value) {
                if (TextUtil.isEmpty(value))
                  return '昵称不能为空';
                else
                  return null;
              },
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD8D8D8)),
                ),
                hintText: '为保护个人隐私，在与邻居交流时将显示昵称',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MaterialButton(
            color: kPrimaryColor,
            elevation: 0,
            height: 89.w,
            child: '保存'.text.make(),
            shape: StadiumBorder(),
            onPressed: () {
              if (_globalKey.currentState.validate()) {
                final signUpProvider =
                    Provider.of<SignUpProvider>(context, listen: false);
                signUpProvider.setNickName(_textEditingController.text);
                Get.to(SignUpVerifyPage());
              }
            },
          ),
          MaterialButton(
            elevation: 0,
            height: 89.w,
            child: [
              Icon(Icons.cached_rounded),
              12.wb,
              '换一换'.text.make(),
            ].row(),
            shape: StadiumBorder(),
            onPressed: () {
              _textEditingController.text =
                  RandomCharacter.getChinese(length: 3);
            },
          ),
        ],
      ).pLTRB(82.w, 0, 82.w, 60.w),
    );
  }
}
