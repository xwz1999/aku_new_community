import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PageExt on Widget {
  Function get to => () => Get.to(this);
}
