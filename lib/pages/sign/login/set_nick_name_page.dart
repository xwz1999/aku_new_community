import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/pages/sign/sign_func.dart';
import 'package:aku_new_community/pages/sign/widget/login_button_widget.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class SetNickNamePage extends StatefulWidget {
  const SetNickNamePage({Key? key}) : super(key: key);

  @override
  _SetNickNamePageState createState() => _SetNickNamePageState();
}

class _SetNickNamePageState extends State<SetNickNamePage> {
  TextEditingController _nickController = TextEditingController();
  bool _nickIsRepeat = false;

  @override
  void dispose() {
    _nickController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BeeScaffold(
        title: '',
        bodyColor: Colors.white,
        body: ListView(
          children: [
            24.w.heightBox,
            Row(
              children: [
                48.w.widthBox,
                '请设置您的昵称'
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
                '昵称不可设置侮辱性词汇、特殊符号、敏感字符'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.45))
                    .make(),
                Spacer(),
              ],
            ),
            95.w.heightBox,
            Container(
              width: 686.w,
              height: 94.w,
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.w),
                color: Colors.black.withOpacity(0.06),
              ),
              child: TextField(
                onChanged: (text) async {
                  _nickIsRepeat = !(await SignFunc.checkNickRepeat(text));
                  setState(() {});
                },
                maxLength: 20,
                controller: _nickController,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.85),
                ),
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                    isDense: false,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
                    border: InputBorder.none,
                    counterText: '',
                    hintText: '请输入您的昵称，不超过20个字符',
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.25),
                        fontSize: 28.sp)),
              ),
            ),
            _nickIsRepeat ? _nickRepeat() : 100.w.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: LoginButtonWidget(
                  onTap: () async {
                    var result =
                        await SignFunc.setNickName(_nickController.text);
                    if (result) {
                      await UserTool.userProvider.updateUserInfo();
                      await SignFunc.checkNameAndAccount();
                    }
                  },
                  text: '确定'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nickRepeat() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.w.heightBox,
          '该昵称已有人注册，请重新输入'.text.size(28.sp).color(Colors.red).make(),
          50.w.heightBox,
          '试试以下昵称'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.65))
              .make(),
          24.w.heightBox,
          otherNick('123'),
          24.w.heightBox,
          otherNick('321'),
          24.w.heightBox,
          otherNick('231'),
          100.w.heightBox,
        ],
      ),
    );
  }

  Widget otherNick(String extra) {
    return GestureDetector(
      onTap: () {
        _nickController.text = '${_nickController.text}$extra';
      },
      child: Material(
        child: Container(
          height: 70.w,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.03),
              borderRadius: BorderRadius.circular(42.sp)),
          child: '${_nickController.text}$extra'
              .text
              .size(28.sp)
              .color(Color(0xFF5096F1))
              .make(),
        ),
      ),
    );
  }
}
