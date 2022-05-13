import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/ui/profile/house/house_func.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/others/bee_input_row.dart';
import 'package:aku_new_community/widget/others/house_head_card.dart';
import 'package:aku_new_community/widget/others/upload_widget.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:aku_new_community/widget/picker/bee_date_picker.dart';
import 'package:aku_new_community/widget/views/doc_view.dart';

class UploadEmptyListPage extends StatefulWidget {
  UploadEmptyListPage({Key? key}) : super(key: key);

  @override
  _UploadEmptyListPageState createState() => _UploadEmptyListPageState();
}

class _UploadEmptyListPageState extends State<UploadEmptyListPage> {
  List<File> _files = [];
  List<String> _urls = [];

  int get sysLeaseId => UserTool.appProvider.selectedHouse!.sysLeaseId ?? 0;
  DateTime? _date = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '提交终止申请',
      bodyColor: Colors.white,
      body: ListView(
        children: [
          HouseHeadCard(context: context),
          40.w.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BeeInputRow.button(
                    title: '收房时间',
                    onPressed: () async {
                      _date = await BeeDatePicker.pick(_date!);
                      setState(() {});
                    },
                    hintText: DateUtil.formatDate(_date, format: 'yyyy-MM-dd')),
                40.w.heightBox,
                '上传腾空单'.text.size(28.sp).color(ktextPrimary).make(),
                24.w.heightBox,
                UploadWidget(
                    sheetTitle: '上传腾空单',
                    onPicked: (file) {
                      _files.add(file);
                      setState(() {});
                    }),
                64.w.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ..._files
                          .map(
                            (e) => DocViw(
                              title: e.path.split('/').last,
                              margin: EdgeInsets.zero,
                              onLongPress: () async {
                                await Get.bottomSheet(_deleteSheet(() {
                                  _files.remove(e);
                                  Get.back();
                                  setState(() {});
                                }));
                              },
                              onPressed: () async {
                                await OpenFile.open(e.path);
                              },
                            ),
                          )
                          .toList()
                    ].sepWidget(separate: 12.w.heightBox),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavi: BottomButton(
          onPressed: () async {
            Function cancel = BotToast.showLoading();
            if (_files.isNotEmpty) {
              _urls.addAll(await HouseFunc().uploadClearingSingle(_files));
            } else {
              BotToast.showText(text: '请先选择腾空单');
            }
            bool result = await HouseFunc().submitTerminationApplication(
                sysLeaseId,
                DateUtil.formatDate(_date, format: 'yyyy-MM-dd HH:mm:ss'),
                _urls);
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

  Widget _deleteSheet(VoidCallback onTap) {
    return CupertinoActionSheet(
      title:
          '删除文件'.text.size(28.sp).bold.isIntrinsic.color(ktextPrimary).make(),
      actions: [
        CupertinoActionSheetAction(
            onPressed: onTap,
            child: '删除'
                .text
                .size(32.sp)
                .isIntrinsic
                .bold
                .color(kDangerColor)
                .make())
      ],
    );
  }
}
