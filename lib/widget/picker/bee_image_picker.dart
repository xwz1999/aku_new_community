// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';

//TODO 图片大小限制
class BeeImagePicker {
  static Future<File> pick({
    String title,
  }) async {
    PickedFile file = await Get.bottomSheet(CupertinoActionSheet(
      title: title.text.isIntrinsic.make(),
      actions: [
        CupertinoDialogAction(
          onPressed: () async => Get.back(
            result: await ImagePicker().getImage(source: ImageSource.gallery),
          ),
          child: [
            Icon(CupertinoIcons.photo),
            30.wb,
            '相册'.text.isIntrinsic.make(),
          ].row(),
        ),
        CupertinoDialogAction(
          onPressed: () async => Get.back(
            result: await ImagePicker().getImage(source: ImageSource.camera),
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
