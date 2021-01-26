// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

extension PageExt on Widget {
  Function get to => () => Get.to(this);
}
