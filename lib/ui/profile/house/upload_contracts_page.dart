import 'dart:io';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/painters/upload_painter.dart';
import 'package:aku_community/ui/profile/house/contract_pay_page.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/picker/bee_image_picker.dart';
import 'package:aku_community/widget/views/doc_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';

class UploadContractsPage extends StatefulWidget {
  UploadContractsPage({Key? key}) : super(key: key);

  @override
  _UploadContractsPageState createState() => _UploadContractsPageState();
}

class _UploadContractsPageState extends State<UploadContractsPage> {
  List<File> _files = [];
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '上传文件',
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        children: [
          100.w.heightBox,
          _uploadWidget(),
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
          onPressed: () {
            Get.to(() => ContractPayPage());
          },
          child: '提交审核'.text.size(32.sp).color(ktextPrimary).bold.make()),
    );
  }

  Widget _uploadWidget() {
    return GestureDetector(
      onTap: () async {
        File? _file = await BeeImagePicker.pick(title: '选择合同照片');
        if (_file != null) {
          _files.add(_file);
          setState(() {});
        }
      },
      child: Center(
        child: DottedBorder(
            dashPattern: [6, 4],
            child: Container(
              width: 500.w,
              height: 500.w,
              color: Color(0x19C4C4C4),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  87.w.heightBox,
                  SizedBox(
                    width: 200.w,
                    height: 200.w,
                    child: CustomPaint(
                      painter: UploadPainter(),
                    ),
                  ),
                  43.w.heightBox,
                  '点击上传文件'
                      .text
                      .size(32.sp)
                      .color(Color(0xFFADB2C4))
                      .bold
                      .make(),
                  43.w.heightBox,
                  '仅支持PDF、PNG、JPG格式的文件'
                      .text
                      .size(28.sp)
                      .color(Color(0x999999))
                      .make(),
                ],
              ),
            )),
      ),
    );
  }
}
