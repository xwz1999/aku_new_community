import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class MyPainter extends CustomPainter {
  @override
  paint(Canvas canvas, Size size) {
    Color shadowColor = Colors.pink;
    var shadowWidth = 20.0;
    final Offset offsetCenter = Offset(10.0, 10.0);
    var outerRadius = 100.0; //外圈大小
    var strokeWidth = 20.0; //圈宽度
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = shadowColor
      ..strokeWidth = (strokeWidth);
    final ringPaint1 = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = (strokeWidth);
    canvas.drawArc(Rect.fromCircle(center: offsetCenter, radius: 30), 10, math.pi/2,
        false, ringPaint);
    canvas.drawArc(Rect.fromCircle(center: offsetCenter, radius: 30), 10+math.pi/2, math.pi/2,
        false, ringPaint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


