import 'package:flutter/material.dart';

extension ColorExt on Color {
  ///获得此颜色的互补色
  Color get complementary {
    var r = ~this.red;
    var g = ~this.green;
    var b = ~this.blue;
    return Color.fromARGB(this.alpha, r, g, b);
  }
}
