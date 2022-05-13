import 'package:flutter/material.dart';

/// 竖线
class VerticalLinePainter extends CustomPainter {
  ///线条颜色
  final Color color;

  ///线条宽度
  final double width;

  ///线条左边内边距
  final double paddingLeft;

  ///线条顶部内边距
  final double paddingTop;

  ///线条底部内边距
  final double paddingBottom;

  VerticalLinePainter({
    this.color: Colors.grey,
    this.width: 1,
    this.paddingLeft: 0,
    this.paddingTop: 0,
    this.paddingBottom: 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = color;
    Path path = new Path(); //使用轨迹画线条
    path.moveTo(paddingLeft, paddingTop);//左上点
    path.lineTo(paddingLeft, size.height + paddingTop - paddingBottom);//左下点
    path.lineTo(width + paddingLeft, size.height + paddingTop - paddingBottom);//右下点
    path.lineTo(width + paddingLeft, paddingTop);//右上点
    path.close();
    canvas.drawPath(path, paint);
  }

  ///有变化刷新
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}