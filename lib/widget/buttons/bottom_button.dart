import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aku_community/base/base_style.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const BottomButton({
    Key key,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        disabledColor: Colors.white.withOpacity(0.5),
        disabledTextColor: ktextSubColor.withOpacity(0.8),
        textColor: ktextPrimary,
        child: child,
        onPressed: onPressed,
        color: kPrimaryColor,
        height: 98.w,
        minWidth: double.infinity,
      ),
    );
  }
}
