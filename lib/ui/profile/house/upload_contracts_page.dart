import 'dart:io';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/ui/profile/house/contract_pay_page.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/upload_widget.dart';
import 'package:aku_community/widget/views/doc_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';

class UploadContractsPage extends StatefulWidget {
  final int id;
  UploadContractsPage({Key? key, required this.id}) : super(key: key);

  @override
  _UploadContractsPageState createState() => _UploadContractsPageState();
}

class _UploadContractsPageState extends State<UploadContractsPage> {
  List<File> _files = [];
  List<String> _urls = [];
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '上传文件',
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        children: [
          100.w.heightBox,
          UploadWidget(
              sheetTitle: '选择合同照片',
              onPressed: (file) {
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
                          var deleteSheet = CupertinoActionSheet(
                            title: '删除文件'
                                .text
                                .size(28.sp)
                                .bold
                                .isIntrinsic
                                .color(ktextPrimary)
                                .make(),
                            actions: [
                              CupertinoActionSheetAction(
                                  onPressed: () {
                                    _files.remove(e);
                                    Get.back();
                                    setState(() {});
                                  },
                                  child: '删除'
                                      .text
                                      .size(32.sp)
                                      .isIntrinsic
                                      .bold
                                      .color(kDangerColor)
                                      .make())
                            ],
                          );
                          await Get.bottomSheet(
                            deleteSheet,
                          );
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
      bottomNavi: BottomButton(
          onPressed: () async {
            Function cancel = BotToast.showLoading();
            _urls.clear();
            for (var item in _files) {
              String result = await HouseFunc().uploadFormalContract(item);
              if (result.isNotEmpty) {
                _urls.add(result);
              }
            }
            bool result =
                await HouseFunc().submitFormalContract(widget.id, _urls);
            if (result) {
              Get.to(() => ContractPayPage(
                    id: widget.id,
                  ));
            }
            cancel();
          },
          child: '提交审核'.text.size(32.sp).color(ktextPrimary).bold.make()),
    );
  }
}
