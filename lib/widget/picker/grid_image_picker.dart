import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/painters/plus_painter.dart';
import 'package:aku_new_community/widget/picker/bee_image_picker.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';

///网格图片选择
///
///返回`File`数组
///
///```dart
///GridImagePicker(
///   onChange:(files){
///     //YOUR CODE HERE.
///   },
///   padding:EdgeInsets.zero,
///),
///```
class GridImagePicker extends StatefulWidget {
  ///文件选择回调
  final Function(List<File> files) onChange;

  ///Padding
  final EdgeInsetsGeometry padding;

  GridImagePicker({
    Key? key,
    required this.onChange,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  _GridImagePickerState createState() => _GridImagePickerState();
}

class _GridImagePickerState extends State<GridImagePicker> {
  List<File> _files = [];

  int get displayLength => _files.length < 9 ? (_files.length + 1) : 9;

  Widget _buildSelect() {
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.w),
        side: BorderSide(
          color: Color(0xFF979797),
          width: 1.w,
        ),
      ),
      child: CustomPaint(
        painter: PlusPainter(),
        size: Size(80.w, 80.w),
      ),
      onPressed: () async {
        File? file = await BeeImagePicker.pick(title: '选择图片');
        if (file != null) _files.insert(0, file);
        setState(() {});
        widget.onChange(_files);
      },
    );
  }

  Widget _buildItem(File file) {
    return Hero(
      tag: file.hashCode,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          image: DecorationImage(
            image: FileImage(file),
            fit: BoxFit.cover,
          ),
        ),
        child: MaterialButton(
          onPressed: () {
            Get.to(() => BeeImagePreview.file(file: file), opaque: false);
          },
          onLongPress: () async {
            bool? result = await Get.dialog(CupertinoAlertDialog(
              title: '删除该图片？'.text.isIntrinsic.make(),
              actions: [
                CupertinoDialogAction(
                  child: '取消'.text.isIntrinsic.make(),
                  onPressed: Get.back,
                ),
                CupertinoDialogAction(
                  child: '确定'.text.red600.isIntrinsic.make(),
                  onPressed: () => Get.back(result: true),
                ),
              ],
            ));
            if (result == true) _files.remove(file);
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: widget.padding,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.w,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          if (_files.length >= 9) {
            return _buildItem(_files[8]);
          } else
            return _buildSelect();
        }
        return _buildItem(_files[index - 1]);
      },
      itemCount: displayLength,
    );
  }
}
