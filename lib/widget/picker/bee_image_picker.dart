import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:aku_new_community/utils/headers.dart';

class BeeImagePicker {
  static Future<File?> pick(
      {required String title,
      double maxWidth = 1000,
      double maxHeight = 1000}) async {
    PickedFile? file = await Get.bottomSheet(CupertinoActionSheet(
      title: title.text.isIntrinsic.make(),
      actions: [
        CupertinoDialogAction(
          onPressed: () async => Get.back(
            result: await ImagePicker().getImage(
              source: ImageSource.gallery,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
            ),
          ),
          child: [
            Icon(CupertinoIcons.photo),
            30.wb,
            '相册'.text.isIntrinsic.make(),
          ].row(),
        ),
        CupertinoDialogAction(
          onPressed: () async => Get.back(
            result: await ImagePicker().getImage(
              source: ImageSource.camera,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
            ),
          ),
          child: [
            Icon(CupertinoIcons.camera),
            30.wb,
            '相机'.text.isIntrinsic.make(),
          ].row(),
        ),
      ],
      cancelButton: CupertinoDialogAction(
        onPressed: Get.back,
        child: '取消'.text.isIntrinsic.make(),
      ),
    ));
    if (file != null)
      return File(file.path);
    else
      return null;
  }
}
