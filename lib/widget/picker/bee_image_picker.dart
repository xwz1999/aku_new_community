import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

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
          child: '相册'.text.isIntrinsic.make(),
        ),
        CupertinoDialogAction(
          onPressed: () async => Get.back(
            result: await ImagePicker().getImage(source: ImageSource.camera),
          ),
          child: '相机'.text.isIntrinsic.make(),
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
