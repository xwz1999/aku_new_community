import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/widget/bee_divider.dart';

class BeePickerBox extends StatelessWidget {
  final VoidCallback? onPressed;
  final String confirmString;
  final String? title;
  final Widget child;

  const BeePickerBox(
      {Key? key,
      this.onPressed,
      this.confirmString = '完成',
      this.title,
      required this.child})
      : super(key: key);

  _buildButton({
    required String title,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      // height: 48.w,
      child: TextButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kForeGroundColor,
      child: SizedBox(
        height: 650.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 88.w,
              child: NavigationToolbar(
                leading: _buildButton(
                  title: '取消',
                  onPressed: () => Navigator.pop(context),
                ),
                middle: Text(
                  title ?? '',
                  style: TextStyle(
                    color: ktextPrimary,
                    fontSize: 28.sp,
                  ),
                ),
                trailing: _buildButton(
                  title: confirmString,
                  onPressed: onPressed,
                ),
              ),
            ),
            BeeDivider.horizontal(),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
