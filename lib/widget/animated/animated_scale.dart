import 'package:flutter/material.dart';

class AnimatedScale extends ImplicitlyAnimatedWidget {
  final Widget? child;
  final double? scale;

  AnimatedScale({this.child, this.scale})
      : super(
          duration: Duration(milliseconds: 300),
        );
  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedScaleState();
}

class _AnimatedScaleState extends AnimatedWidgetBaseState<AnimatedScale> {
  Tween<double?>? scaleTween;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scaleTween!.evaluate(animation)!,
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    scaleTween = visitor(
      scaleTween,
      widget.scale,
      (value) => Tween<double>(begin: value),
    ) as Tween<double?>?;
  }
}
