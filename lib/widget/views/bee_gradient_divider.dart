import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeeGradientDivider extends StatelessWidget {
  final Axis direction;
  final double? thin;
  final double? length;
  final List<Color> colors;

  const BeeGradientDivider(
      {Key? key,
      required this.direction,
      required this.thin,
      required this.length,
      required this.colors})
      : super(key: key);

  const BeeGradientDivider.horizontal({
    Key? key,
    this.thin,
    this.length,
    this.colors = const [Colors.white, Color(0xFFE8E8E8), Colors.white],
  })  : this.direction = Axis.horizontal,
        super(key: key);

  const BeeGradientDivider.vertical({
    Key? key,
    this.thin,
    this.length,
    this.colors = const [Colors.white, Color(0xFFE8E8E8), Colors.white],
  })  : this.direction = Axis.vertical,
        super(key: key);

  double get dLength => this.length ?? double.infinity;

  double get dThin => this.thin ?? 1.w;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: direction == Axis.horizontal ? dLength : dThin,
      height: direction == Axis.vertical ? dLength : dThin,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: direction == Axis.horizontal
                  ? Alignment.centerLeft
                  : Alignment.topCenter,
              end: direction == Axis.horizontal
                  ? Alignment.centerRight
                  : Alignment.bottomCenter,
              colors: colors)),
    );
  }
}
