import 'dart:io';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/bee_input_row.dart';
import 'package:aku_community/widget/others/house_head_card.dart';
import 'package:aku_community/widget/others/upload_widget.dart';
import 'package:aku_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class UploadEmptyListPage extends StatefulWidget {
  UploadEmptyListPage({Key? key}) : super(key: key);

  @override
  _UploadEmptyListPageState createState() => _UploadEmptyListPageState();
}

class _UploadEmptyListPageState extends State<UploadEmptyListPage> {
  File? _file;
  List<String> _urls = [];
  int get sysLeaseId => UserTool.appProveider.selectedHouse!.sysLeaseId ?? 0;
  late TextEditingController _editingController;
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '提交终止申请',
      body: ListView(
        children: [
          HouseHeadCard(context: context),
          40.w.heightBox,
          BeeInputRow(
              title: '收房时间',
              controller: _editingController,
              hintText: '请填写收房时间'),
          40.w.heightBox,
          '上传腾空单'.text.size(28.sp).color(ktextPrimary).make(),
          24.w.heightBox,
          _file != null
              ? Image.file(
                  _file!,
                  width: 480.w,
                  height: 480.w,
                  fit: BoxFit.cover,
                )
              : UploadWidget(
                  sheetTitle: '上传腾空单',
                  onPicked: (file) {
                    _file = file;
                    setState(() {});
                  }),
        ],
      ),
      bottomNavi: BottomButton(
          onPressed: () async {
            Function cancel = BotToast.showLoading();
            if (_file != null) {
              _urls.add(await HouseFunc().uploadClearingSingle(_file!));
            } else {
              BotToast.showText(text: '请先选择腾空单');
            }
            bool result = await HouseFunc().submitTerminationApplication(
                sysLeaseId, _editingController.text, _urls);
            if (result) {
              Get.back();
            } else {
              BotToast.showText(text: '提交失败');
            }
            cancel();
          },
          child: '提交审核'.text.size(32.sp).bold.color(ktextPrimary).make()),
    );
  }
}
