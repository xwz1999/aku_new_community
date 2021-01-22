import 'package:akuCommunity/base/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        child: DefaultTextStyle(
          child: child,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 32.sp,
          ),
        ),
        onPressed: onPressed,
        color: kPrimaryColor,
        height: 98.w,
      ),
    );
  }
}
