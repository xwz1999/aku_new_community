import 'dart:io';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/picker/grid_image_picker.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNewEventPage extends StatefulWidget {
  AddNewEventPage({Key key}) : super(key: key);

  @override
  _AddNewEventPageState createState() => _AddNewEventPageState();
}

class _AddNewEventPageState extends State<AddNewEventPage> {
  bool _commentable = true;
  List<File> _files = [];
  TextEditingController _textEditingController = TextEditingController();

  ///发表动态
  _addEvent() async {
    VoidCallback cancel = BotToast.showLoading();
    final String content = _textEditingController.text;
    List<String> imgs;
    if (_files.isNotEmpty) {
      imgs = await NetUtil().uploadFiles(_files, API.upload.uploadEvent);
    }

    Map<String, dynamic> params = {
      //TODO 话题ID
      'gambitId': -1,
      'content': content,
      'isComment': _commentable ? 1 : 0,
      'isPublic': 1,
      'imgUrls': imgs,
    };

    BaseModel baseModel = await NetUtil().post(
      API.community.addEvent,
      params: params,
      showMessage: true,
    );
    cancel();
    if (baseModel.status) {
      Get.back(result: true);
    }
  }

  _buildSelectable() {
    return MaterialButton(
      onPressed: () {
        setState(() {
          _commentable = !_commentable;
        });
      },
      height: 96.w,
      child: Row(
        children: [
          Icon(
            CupertinoIcons.bubble_left,
            size: 32.w,
          ),
          8.wb,
          '不可评论'.text.size(28.sp).make(),
          Spacer(),
          AnimatedOpacity(
            opacity: _commentable ? 0 : 1,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: Icon(
              Icons.check_rounded,
              color: Colors.black,
              size: 40.w,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: Get.back,
          child: '取消'.text.size(34.sp).make(),
        ),
        leadingWidth: 108.w,
        centerTitle: true,
        title: '社区'.text.make(),
        actions: [
          Hero(
            tag: 'event_add',
            child: MaterialButton(
              elevation: 0,
              minWidth: 116.w,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.w),
              ),
              color: kPrimaryColor,
              onPressed: _addEvent,
              child: '发表'.text.size(34.sp).make(),
            ).centered(),
          ),
          32.wb,
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 32.w),
        children: [
          TextField(
            minLines: 3,
            maxLines: 99,
            controller: _textEditingController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: '这一刻的想法',
              hintStyle: TextStyle(
                color: Color(0xFF999999),
                fontSize: 34.sp,
              ),
            ),
          ),
          GridImagePicker(onChange: (files) => _files = files),
          100.hb,
          Divider(height: 1.w),
          _buildSelectable(),
          Divider(height: 1.w),
          28.hb,
          //TODO 选择话题
        ],
      ).material(color: Colors.white),
    );
  }
}
