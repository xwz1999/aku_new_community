import 'package:aku_new_community/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class DocViw extends StatelessWidget {
  const DocViw({
    Key? key,
    required this.title,
    required this.onPressed,
    this.margin,
    this.onLongPress,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    // if (title?.isEmpty ?? true) return SizedBox();
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        margin: margin ?? EdgeInsets.only(right: 113.w),
        alignment: Alignment.centerLeft,
        child: MaterialButton(
          minWidth: 606.w,
          height: 154.w,
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Row(
            children: [
              title.text.size(32.sp).make().expand(),
              Image.asset(
                R.ASSETS_ICONS_FILE_PNG,
                height: 52.w,
                width: 52.w,
              ),
            ],
          ),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
            side: BorderSide(color: Color(0xFFD4CFBE)),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
