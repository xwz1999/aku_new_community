import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/sign/sign_up/sign_up_common_widget.dart';
import 'package:akuCommunity/pages/sign/sign_up/sign_up_set_nickname_page.dart';
import 'package:akuCommunity/provider/sign_up_provider.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpPickRolePage extends StatefulWidget {
  SignUpPickRolePage({Key key}) : super(key: key);

  @override
  _SignUpPickRolePageState createState() => _SignUpPickRolePageState();
}

class _SignUpPickRolePageState extends State<SignUpPickRolePage> {
  Widget _buildTile(int type, String title) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    return RadioListTile(
      groupValue: signUpProvider.type,
      onChanged: (int value) => signUpProvider.setType(value),
      value: type,
      title: title.text.make(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        children: [
          148.hb,
          signUpTitle('身份选择'),
          190.hb,
          ...[
            _buildTile(1, '租客'),
            _buildTile(2, '业主'),
            _buildTile(3, '亲属'),
          ].sepWidget(
              separate: Divider(
            height: 1.w,
            thickness: 1.w,
            color: Color(0xFFD8D8D8),
          )),
        ],
      ),
      bottomNavigationBar: MaterialButton(
        height: 89.w,
        color: kPrimaryColor,
        shape: StadiumBorder(),
        disabledColor: kPrimaryColor.withOpacity(0.3),
        child: '提交'.text.make(),
        onPressed: () => Get.to(SignUpSetNicknamePage()),
        elevation: 0,
      ).pLTRB(82.w, 0, 82.w, 155.w),
    );
  }
}
