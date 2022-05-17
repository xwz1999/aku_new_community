import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/ui/manager/advice/advice_house_page.dart';
import 'package:aku_new_community/ui/manager/advice/advice_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/picker/grid_image_picker.dart';
import '../../../provider/user_provider.dart';
import '../../../widget/others/user_tool.dart';

class NewAdvicePage extends StatefulWidget {
  final AdviceType type;
  final int initType;

  NewAdvicePage({Key? key, required this.type, required this.initType})
      : super(key: key);

  @override
  _NewAdvicePageState createState() => _NewAdvicePageState();
}

class _NewAdvicePageState extends State<NewAdvicePage> {
  int? _type;
  List<File> _files = [];
  TextEditingController _editingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String get title {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return '建议咨询';
      case AdviceType.COMPLAIN:
        return '投诉表扬';
    }
  }

  List<String> get tabs {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return ['您的建议', '您的咨询'];
      case AdviceType.COMPLAIN:
        return ['您的投诉', '您的表扬'];
    }
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
    List<String?> urls =
        await NetUtil().uploadFiles(files, SAASAPI.uploadFile.uploadImg);
    BaseModel baseModel = await NetUtil().post(
      SAASAPI.advice.insert,
      params: {
        'type': type,
        'content': content,
        'imgUrls': urls,
      },
      showMessage: true,
    );
    cancel();
    if (baseModel.success) {
      Get.back(result: true);
    }
  }

  @override
  void initState() {
    super.initState();
    _type = widget.initType;
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold.white(
      systemStyle: SystemStyle.yellowBottomBar,
      title: title,
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          '业主/租客房屋'.text.size(28.sp).black.make(),
          32.hb,
          GestureDetector(
            onTap: () {
              setState(() {
                Get.to(() => AdviceHousePage());
              });
            },
            child: <Widget>[
              Image.asset(
                R.ASSETS_IMAGES_HOUSE_ATTESTATION_PNG,
                height: 60.w,
                width: 60.w,
              ),
              40.wb,
              userProvider.defaultHouse != null
                  ? '${userProvider.defaultHouse!.addressName}${userProvider.defaultHouse!.communityName}\n'
                          '${userProvider.defaultHouse!.buildingName}幢-${UserTool.userProvider.defaultHouse!.unitName}单元-${userProvider.defaultHouse!.estateName}室'
                      .text
                      .size(32.sp)
                      .black
                      .bold
                      .make()
                  : '请选择房屋'.text.size(32.sp).black.bold.make(),
              300.wb,
              Icon(
                Icons.arrow_forward_ios,
                size: 35.w,
                color: Colors.black.withOpacity(0.25),
              ),
            ].row(),
          ),
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
          if (_formKey.currentState!.validate()) {
            int type = 1;
            switch (widget.type) {
              case AdviceType.SUGGESTION:
                type = _type == 0 ? 2 : 1;
                break;
              case AdviceType.COMPLAIN:
                type = _type == 0 ? 3 : 4;
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
