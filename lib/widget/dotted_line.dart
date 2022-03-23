import 'package:flutter/material.dart';

/// 虚线
class DottedLine extends StatelessWidget {
  ///虚线高度（横向为高度，纵向为宽度
  final double height;
  final Color color;
  final Axis direction;

  ///虚线宽度
  final double? width;

  ///空白与虚线比例
  final double? proportion;

  const DottedLine({
    this.height = 1,
    this.color = Colors.black,
    this.direction = Axis.horizontal,
    this.width,
    this.proportion,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = direction == Axis.horizontal
            ? constraints.constrainWidth()
            : constraints.constrainHeight();
        final dashWidth = width ?? 10.0;
        final dashHeight = height;
        final spaceProportion = proportion == null ? 2.0 : (1 + proportion!);
        final dashCount = (boxWidth / (spaceProportion * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: direction == Axis.horizontal ? dashWidth : dashHeight,
              height: direction == Axis.horizontal ? dashHeight : dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction,
        );
      },
    );
  }
}
