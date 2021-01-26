// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserBottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFFE9E9E9);
    Path path = Path();

    path.moveTo(26.w, 0);
    path.lineTo(size.width - 26.w, 0);
    path.lineTo(size.width + 16.w, size.height);
    path.lineTo(-16.w, size.height);
    path.close();
    canvas.drawPath(path, paint);

    Paint secondPaint = Paint()..color = Color(0xFF767676);
    Path secondPath = Path();
    secondPath.moveTo(30.w, 13.w);
    secondPath.lineTo(size.width - 30.w, 13.w);
    secondPath.lineTo(size.width - 24.w, 23.w);
    secondPath.lineTo(24.w, 23.w);
    secondPath.close();
    canvas.drawPath(secondPath, secondPaint);
  }

  @override
  bool shouldRepaint(UserBottomBarPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(UserBottomBarPainter oldDelegate) => false;
}
