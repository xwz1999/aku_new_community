import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/painters/upload_painter.dart';
import 'package:aku_community/widget/picker/bee_image_picker.dart';

class UploadWidget extends StatelessWidget {
  final String sheetTitle;
  final Function(File file) onPressed;
  const UploadWidget(
      {Key? key, required this.sheetTitle, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        File? _file = await BeeImagePicker.pick(title: sheetTitle);
        if (_file != null) {
          onPressed(_file);
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
                  40.w.heightBox,
                  '点击上传文件'
                      .text
                      .size(32.sp)
                      .color(Color(0xFFADB2C4))
                      .bold
                      .make(),
                  40.w.heightBox,
                  '仅支持PDF、PNG、JPG格式的文件'
                      .text
                      .size(28.sp)
                      .color(Color(0xFFADB2C4))
                      .make(),
                ],
              ),
            )),
      ),
    );
  }
}
