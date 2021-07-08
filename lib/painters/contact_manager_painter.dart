import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactManagerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2.w
      ..style = PaintingStyle.stroke;
    Path path = Path();
    Rect rect = Rect.fromCircle(center: Offset(200.w, 200.w), radius: 120.w);
    path.addArc(rect, 0, pi * 2);
    Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF9F9F9), Color(0xFF4AFD71)]);
    paint.shader = gradient.createShader(rect);
    canvas.drawPath(path, paint);
    rect = Rect.fromCircle(center: Offset(200.w, 200.w), radius: 150.w);
    gradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFF9F9F9), Color(0xFF4AFD71)]);
    Path path2 = Path();
    path2.addArc(rect, 0, pi * 2);
    paint.shader = gradient.createShader(rect);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return false;
  }
}
