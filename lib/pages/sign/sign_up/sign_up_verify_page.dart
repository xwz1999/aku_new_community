import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/sign/sign_func.dart';
import 'package:akuCommunity/pages/sign/sign_up/sign_up_common_widget.dart';
import 'package:akuCommunity/pages/tab_navigator.dart';
import 'package:akuCommunity/provider/sign_up_provider.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpVerifyPage extends StatefulWidget {
  SignUpVerifyPage({Key key}) : super(key: key);

  @override
  _SignUpVerifyPageState createState() => _SignUpVerifyPageState();
}

class _SignUpVerifyPageState extends State<SignUpVerifyPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          children: [
            148.hb,
            signUpTitle('设置昵称'),
            190.hb,
            '请输入您的姓名'.text.size(32.sp).color(ktextPrimary).make(),
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (TextUtil.isEmpty(value))
                  return '姓名不能为空';
                else
                  return null;
              },
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD8D8D8)),
                ),
                // hintText: '',
              ),
            ),
            40.hb,
            '请输入您的身份证号'.text.size(32.sp).color(ktextPrimary).make(),
            TextFormField(
              controller: _idNumberController,
              validator: (value) {
                if (TextUtil.isEmpty(value)) return '身份证号不能为空';
                if (!RegexUtil.isIDCard(value))
                  return '身份证格式错误';
                else
                  return null;
              },
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD8D8D8)),
                ),
                // hintText: '',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MaterialButton(
        height: 89.w,
        color: kPrimaryColor,
        shape: StadiumBorder(),
        disabledColor: kPrimaryColor.withOpacity(0.3),
        child: '登录'.text.bold.make(),
        onPressed: () async {
          final signUpProvider =
              Provider.of<SignUpProvider>(context, listen: false);

          if (_formKey.currentState.validate()) {
            signUpProvider.setName(_nameController.text);
            signUpProvider.setIdNumber(_idNumberController.text);
            bool result = await SignFunc.signUp();
            if (result) Get.offAll(TabNavigator());
          }
        },
        elevation: 0,
      ).pLTRB(82.w, 0, 82.w, 155.w),
    );
  }
}
