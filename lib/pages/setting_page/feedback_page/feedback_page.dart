import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/picker/grid_image_picker.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key? key}) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController _ideaContent = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<File> _files = [];

  Widget _containerTextField() {
    return Container(
      padding: EdgeInsets.only(top: 24.w, left: 24.w, right: 32.w),
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
        validator: (text) {
          if (text?.isEmpty ?? true) return '意见不能为空';
          return null;
        },
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
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          if (_files.isNotEmpty) {
          }
          var cancelAction = BotToast.showLoading();
          await NetUtil().post(
            API.user.feedback,
            params: {
              'content': _ideaContent.text,
              'fileUrls': [],
            },
            showMessage: true,
          );
          cancelAction();
          Get.back();
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
    return BeeScaffold(
      title: '意见反馈',
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
                    style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
                  ),
                  SizedBox(height: 24.w),
                  Form(
                    child: _containerTextField(),
                    key: _formKey,
                  ),
                  SizedBox(height: 24.w),
                  Text(
                    '添加图片信息(0/9)',
                    style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
                  ),
                  SizedBox(height: 24.w),
                  GridImagePicker(onChange: (files) {
                    _files = files;
                  }),
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
