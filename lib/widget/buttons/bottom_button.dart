import 'package:aku_new_community/base/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color bgColor;
  final Color textColor;

  const BottomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.bgColor = kPrimaryColor,
    this.textColor = ktextPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        disabledColor: Colors.white.withOpacity(0.5),
        disabledTextColor: ktextSubColor.withOpacity(0.4),
        textColor: textColor,
        child: child,
        onPressed: onPressed,
        color: bgColor,
        height: 98.w,
        minWidth: double.infinity,
      ),
    );
  }
}
