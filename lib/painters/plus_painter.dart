import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFD8D8D8)
      ..strokeWidth = 8.w
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, 40.w), Offset(80.w, 40.w), paint);
    canvas.drawLine(Offset(40.w, 0), Offset(40.w, 80.w), paint);
  }

  @override
  bool shouldRepaint(PlusPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PlusPainter oldDelegate) => false;
}
