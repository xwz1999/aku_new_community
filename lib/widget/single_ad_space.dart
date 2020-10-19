import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleAdSpace extends StatelessWidget {
  final String imagePath;
  final double radius;
  SingleAdSpace({Key key,this.imagePath,this.radius = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(160),
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(32),
        vertical: ScreenUtil().setHeight(17),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          child: Image.asset(
            imagePath,
            height: ScreenUtil().setHeight(160),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
