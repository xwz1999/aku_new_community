// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

//TODO CLEAN BOTTOM CODES.
@Deprecated("sh*t container_comment need to be cleaned.")
class ContainerComment extends StatelessWidget {
  final Widget customWidget;
  final double radius;
  ContainerComment({Key key, this.customWidget, this.radius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 17.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 16.w,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: customWidget,
    );
  }
}
