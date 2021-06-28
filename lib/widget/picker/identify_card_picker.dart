import 'dart:io';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/widget/picker/bee_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class IdentifyCardPicker extends StatefulWidget {
  static Widget front(Function(File? file) onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '上传身份证正面'.text.size(28.sp).color(ktextPrimary).make(),
        24.w.heightBox,
        IdentifyCardPicker(
          onChange: onChange,
          path: R.ASSETS_STATIC_ID_CARD_FRONT_PNG,
        )
      ],
    );
  }

  static Widget back(Function(File? file) onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '上传身份证背面'.text.size(28.sp).color(ktextPrimary).make(),
        24.w.heightBox,
        IdentifyCardPicker(
            onChange: onChange, path: R.ASSETS_STATIC_ID_CARD_BACK_PNG)
      ],
    );
  }

  final Function(File? file) onChange;
  final String path;
  IdentifyCardPicker({Key? key, required this.onChange, required this.path})
      : super(key: key);

  @override
  _IdentifyCardPickerState createState() => _IdentifyCardPickerState();
}

class _IdentifyCardPickerState extends State<IdentifyCardPicker> {
  File? _file;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _file = await BeeImagePicker.pick(title: '选择身份证照片');
        if (_file != null) {
          widget.onChange(_file);
        }
      },
      child: Container(
        width: 350.w,
        height: 220.w,
        child: _file != null ? Image.file(_file!) : Image.asset(widget.path),
      ),
    );
  }
}
