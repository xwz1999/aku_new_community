// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class ChangeNickName extends StatefulWidget {
  ChangeNickName({Key key}) : super(key: key);

  @override
  _ChangeNickNameState createState() => _ChangeNickNameState();
}

class _ChangeNickNameState extends State<ChangeNickName> {
  TextEditingController _textEditingController;
  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
    _textEditingController =
        TextEditingController(text: userProvider.userInfoModel.nickName);
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      title: '修改昵称',
      body: Material(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              55.w.heightBox,
              '昵称'.text.black.size(28.sp).make(),
              TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: '${userProvider.userInfoModel.nickName}',
                  hintStyle:
                      TextStyle(color: Color(0xFF999999), fontSize: 34.sp),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFEEEEEE),
                    width: 1.w,
                  )),
                ),
              ),
              150.w.heightBox,
              MaterialButton(
                onPressed: () {
                  userProvider.setName(_textEditingController.text);
                  Get.back();
                },
                child: '保存'.text.black.size(32.sp).make(),
                color: Color(0xFFFFC40C),
                elevation: 0,
                minWidth: 686.w,
                height: 85.w,
              ),
              24.w.heightBox,
              '为保护个人隐私，在与邻里交往时显示昵称，默认为真实姓名，您可自行修改'
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
