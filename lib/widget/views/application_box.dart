import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aku_new_community/utils/headers.dart';

class ApplicationBox extends StatelessWidget {
  final Widget? child;

  ApplicationBox({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(child: child)
        // .margin(EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w))
        .padding(EdgeInsets.all(24.w))
        .color(Colors.white)
        .withRounded(value: 8.w)
        // .withShadow([
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     offset: Offset(1.1, 1.1),
        //     blurRadius: 10.0,
        //   )
        // ])
        .make()
        .centered();
  }
}
