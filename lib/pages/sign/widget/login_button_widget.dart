import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aku_new_community/base/base_style.dart';

class LoginButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  const LoginButtonWidget({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 686.w,
      height: 97.w,
      onPressed: onTap,
      elevation: 0,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 32.sp,
        ),
      ),
      disabledTextColor: Colors.black.withOpacity(0.45),
      disabledColor: Colors.black.withOpacity(0.06),
      color: kPrimaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.w)),
    );
  }
}
