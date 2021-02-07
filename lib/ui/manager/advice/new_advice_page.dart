// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/ui/manager/advice/advice_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/bottom_button.dart';
import 'package:akuCommunity/widget/picker/grid_image_picker.dart';

class NewAdvicePage extends StatefulWidget {
  final AdviceType type;
  NewAdvicePage({Key key, @required this.type}) : super(key: key);

  @override
  _NewAdvicePageState createState() => _NewAdvicePageState();
}

class _NewAdvicePageState extends State<NewAdvicePage> {
  int _type = 0;
  List<File> _files = [];
  TextEditingController _editingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String get title {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return '建议咨询';
        break;
      case AdviceType.COMPLAIN:
        return '投诉表扬';
        break;
    }
    return '';
  }

  List<String> get tabs {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return ['您的建议', '您的咨询'];
        break;
      case AdviceType.COMPLAIN:
        return ['您的投诉', '您的表扬'];
        break;
    }
    return [];
  }

  _buildType(int index, String asset, String title) {
    bool isSelected = _type == index;
    return GestureDetector(
      onTap: () {
        _type = index;
        setState(() {});
      },
      child: AnimatedContainer(
        height: 72.w,
        width: 176.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36.w),
          border: Border.all(
            color: isSelected ? Color(0xFFFFC40C) : Color(0xFF979797),
            width: 2.w,
          ),
          color: Color(0xFFFFF4D3).withOpacity(isSelected ? 1 : 0),
        ),
        duration: Duration(milliseconds: 300),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, width: 32.w, height: 32.w),
            12.wb,
            title.text
                .size(32.sp)
                .color(isSelected ? Color(0xFF333333) : Color(0xFF999999))
                .make(),
          ],
        ),
      ),
    );
  }

  ///添加建议咨询/投诉表扬 信息
  Future addAdvice(int type, List<File> files, String content) async {
    VoidCallback cancel = BotToast.showLoading();
    List<String> urls =
        await NetUtil().uploadFiles(files, API.upload.uploadArticle);
    BaseModel baseModel = await NetUtil().post(
      API.manager.addAdvice,
      params: {
        'type': type,
        'content': content,
        'fileUrls': urls,
      },
      showMessage: true,
    );
    cancel();
    if (baseModel.status) {
      Get.back(result: true);
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold.white(
      title: title,
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          '业主/租客房屋'.text.size(28.sp).black.make(),
          32.hb,
          <Widget>[
            Image.asset(
              R.ASSETS_IMAGES_HOUSE_ATTESTATION_PNG,
              height: 60.w,
              width: 60.w,
            ),
            40.wb,
            '宁波华茂悦峰\n1幢-1单元-702室'.text.size(32.sp).black.bold.make(),
          ].row(),
          Divider(height: 64.w),
          '您要选择的类型是？'.text.size(28.sp).make(),
          32.hb,
          <Widget>[
            _buildType(0, R.ASSETS_ICONS_PROPOSAL_PNG,
                widget.type == AdviceType.SUGGESTION ? '建议' : '投诉'),
            80.wb,
            _buildType(1, R.ASSETS_ICONS_CONSULT_PNG,
                widget.type == AdviceType.SUGGESTION ? '咨询' : '表扬'),
          ].row(),
          44.hb,
          '请输入内容'.text.size(28.sp).make(),
          24.hb,
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _editingController,
              minLines: 6,
              maxLines: 99,
              validator: (text) {
                if (TextUtil.isEmpty(text)) return '内容不能为空';
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 22.w,
                  vertical: 32.w,
                ),
                hintText: '您对我们的工作有什么建议吗？欢迎您提给我们宝贵的建议，谢谢',
                hintStyle: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xFF999999),
                ),
              ),
            ),
          ),
          32.hb,
          '添加图片信息(${_files.length}/9)'.text.size(28.sp).make(),
          24.hb,
          GridImagePicker(
            onChange: (files) {
              _files = files;
            },
          ),
        ],
      ),
      bottomNavi: BottomButton(
        onPressed: () {
          VoidCallback cancel = BotToast.showLoading();
          if (_formKey.currentState.validate()) {
            int type = 1;
            switch (widget.type) {
              case AdviceType.SUGGESTION:
                type = _type == 0 ? 2 : 1;
                break;
              case AdviceType.COMPLAIN:
                type = _type == 0 ? 4 : 3;
                break;
            }
            addAdvice(type, _files, _editingController.text);
          }
          cancel();
        },
        child: '确认提交'.text.make(),
      ),
    );
  }
}
