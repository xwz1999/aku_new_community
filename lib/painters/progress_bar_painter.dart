import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressBarPainter extends CustomPainter {
  final double proportion;
  final int lowLevel;

  ProgressBarPainter({
    required this.proportion,
    required this.lowLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final startAngle = pi * 1.42;
    final sweepAngle = pi * 0.03;
    final animateAngle = pi * 0.1 * proportion;
    final Gradient gradient = new SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: [
        Colors.white.withOpacity(0.0),
        Colors.white,
      ],
    );
    final Gradient endGradient = new SweepGradient(
      startAngle: startAngle + sweepAngle + pi * 0.1,
      endAngle: startAngle + sweepAngle + pi * 0.1 + sweepAngle,
      colors: [
        Colors.black.withOpacity(0.4),
        Colors.black.withOpacity(0),
      ],
    );
    var center = Offset(size.width / 2, 700 - 30);
    final Rect rect = Rect.fromCircle(center: center, radius: 700);
    final foregroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect)
      ..strokeWidth = 10.w;
    final backPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.black.withOpacity(0.4)
      ..strokeWidth = 10.w;
    canvas.drawArc(rect, startAngle, sweepAngle, false, foregroundPaint);
    canvas.drawArc(rect, startAngle + sweepAngle, pi * 0.1, false, backPaint);
    canvas.drawCircle(
        Offset(-110, -21), 12.w, foregroundPaint..style = PaintingStyle.fill);
    canvas.drawArc(rect, startAngle + sweepAngle, animateAngle, false,
        foregroundPaint..style = PaintingStyle.stroke);
    canvas.drawArc(rect, startAngle + sweepAngle + pi * 0.1, sweepAngle, false,
        backPaint..shader = endGradient.createShader(rect));
    canvas.drawCircle(
        Offset(110, -21), 12.w, foregroundPaint..style = PaintingStyle.fill);
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: 'LV$lowLevel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
            )),
        textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, Offset(-117, -40));
    textPainter
      ..text = TextSpan(
          text: 'LV${lowLevel + 1}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
          ));
    textPainter.layout();
    textPainter.paint(canvas, Offset(103, -40));
  }

  @override
  bool shouldRepaint(ProgressBarPainter oldDelegate) {
    return oldDelegate.proportion != proportion;
  }
}
