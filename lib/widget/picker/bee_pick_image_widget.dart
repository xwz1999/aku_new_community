// Dart imports:
import 'dart:io';

import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/widget/picker/bee_image_picker.dart';
// Package imports:
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class BeePickImageWidget extends StatefulWidget {
  final double? size;
  final Function(List<File> files) onChanged;
  final String description;

  BeePickImageWidget(
      {Key? key, this.size, required this.onChanged, this.description = '上传照片'})
      : super(key: key);

  @override
  _BeePickImageWidgetState createState() => _BeePickImageWidgetState();
}

class _BeePickImageWidgetState extends State<BeePickImageWidget> {
  List<File> _files = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      spacing: 10.w,
      runSpacing: 10.w,
      children: [
        ..._files.map((e) => showImage(e)).toList(),
        GestureDetector(
          onTap: () async {
            await BeeImagePicker.pick(title: '选择图片').then(
              (value) {
                if (value != null) {
                  _files.add(
                    File(value.path),
                  );
                }
              },
            );
            widget.onChanged(_files);
            setState(() {});
          },
          child: DottedBorder(
            color: Colors.black.withOpacity(0.25),
            borderType: BorderType.RRect,
            strokeWidth: 2.w,
            dashPattern: [6, 3],
            radius: Radius.circular(8.w),
            child: Container(
              width: widget.size ?? 160.w,
              height: widget.size ?? 160.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.icons.camera.path,
                    width: 60.w,
                    height: 60.w,
                    color: Color(0xFF999999),
                  ),
                  4.w.heightBox,
                  widget.description.text
                      .color(Colors.black.withOpacity(0.45))
                      .size(22.sp)
                      .make(),
                ],
              ),
            ),
          ).material(color: Colors.transparent),
        )
      ],
    );
  }

  Widget showImage(File file) {
    return Stack(children: [
      Container(
        width: widget.size ?? 160.w,
        height: widget.size ?? 160.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            color: Colors.black.withOpacity(0.03)),
        child: Image.file(file,fit: BoxFit.cover,),
      ),
      Positioned(
        top: 8.w,
        right: 8.w,
        child: Container(
          width: 40.w,
          height: 40.w,
          child: Icon(
            CupertinoIcons.xmark,
            size: 20.w,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            color: Color(0xFF000000),
          ),
        ).onTap(() {
          _files.remove(file);
          widget.onChanged(_files);
          setState(() {});
        }),
      )
    ]);
  }
}
