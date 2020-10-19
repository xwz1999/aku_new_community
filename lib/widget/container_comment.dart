import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerComment extends StatelessWidget {
  final Widget customWidget;
  final double radius;
  ContainerComment({Key key, this.customWidget,this.radius = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(32),
        vertical: ScreenUtil().setHeight(17),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(24),
        vertical: ScreenUtil().setHeight(16),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: customWidget,
    );
  }
}
