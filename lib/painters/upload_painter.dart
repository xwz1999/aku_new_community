import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 20.w
      ..color = Color(0xFFDEE1EB)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Path path = Path();
    Rect rect = Rect.fromCircle(center: Offset(50.w, 100.w), radius: 40.w);
    path.arcTo(rect, pi / 2,  pi, true);
    Rect rect2 = Rect.fromCircle(center: Offset(100.w, 60.w), radius: 50.w);
    path.arcTo(rect2, pi, pi ,true);

     Rect rect3= Rect.fromCircle(center: Offset(150.w, 100.w), radius: 40.w);
      path.arcTo(rect3, 1.5 * pi, pi , true);
    canvas.drawPath(path, paint);
    Paint spaint = Paint()
      ..strokeWidth = 15.w
      ..color = Color(0xFFC3CCEA)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Path spath = Path();
    spath.moveTo(100.w, 110.w);
    spath.lineTo(75.w, 135.w);
    spath.moveTo(100.w, 110.w);
    spath.lineTo(125.w, 135.w);
    spath.moveTo(100.w, 110.w);
    spath.lineTo(100.w, 170.w);
    canvas.drawPath(spath, spaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) {
    return false;
  }
}
