import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/widget/common_image_picker.dart';
import 'package:get/get.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController _ideaContent = new TextEditingController();

  Widget _containerTextField() {
    return Container(
      padding: EdgeInsets.only(
          top: 24.w,
          left: 24.w,
          right: 32.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: Color(0xffd4cfbe), width: 1.0),
      ),
      child: TextFormField(
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
        ),
        controller: _ideaContent,
        onChanged: (String value) {},
        maxLines: 10,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: 0.w,
            bottom: 0.w,
          ),
          hintText: '请输入',
          border: InputBorder.none, //去掉输入框的下滑线
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 28.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _inkWellSubmit() {
    return InkWell(
      onTap: () {
        if (TextUtil.isEmpty(_ideaContent.text))
          BotToast.showText(text:'意见不能为空');
        else {
          showDialog(
            context: context,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
          Future.delayed(Duration(milliseconds: 1000 + Random().nextInt(1000)),
              () {
            BotToast.showText(text:'提交成功');
            Get.back();
            Get.back();
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 85.w,
        width: 686.w,
        padding: EdgeInsets.symmetric(vertical: 20.w),
        decoration: BoxDecoration(
          color: Color(0xffffc40c),
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        child: Text(
          '确认提交',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '意见反馈',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 36.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 76.w),
                  Text(
                    '意见反馈',
                    style: TextStyle(
                        fontSize: 28.sp,
                        color: Color(0xff333333)),
                  ),
                  SizedBox(height: 24.w),
                  _containerTextField(),
                  SizedBox(height: 24.w),
                  Text(
                    '添加图片信息(0/9)',
                    style: TextStyle(
                        fontSize: 28.sp,
                        color: Color(0xff333333)),
                  ),
                  SizedBox(height: 24.w),
                  CommonImagePicker(),
                  SizedBox(height: 76.w),
                  _inkWellSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
