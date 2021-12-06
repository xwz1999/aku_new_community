import 'package:flutter/material.dart';

class AnimatedTranslate extends ImplicitlyAnimatedWidget {
  final Widget? child;
  final Offset? offset;

  AnimatedTranslate({this.child, this.offset})
      : super(
          duration: Duration(milliseconds: 300),
        );

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedTranslateState();
}

class _AnimatedTranslateState
    extends AnimatedWidgetBaseState<AnimatedTranslate> {
  Tween<Offset?>? _offsetTween;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _offsetTween!.evaluate(animation)!,
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _offsetTween = visitor(
      _offsetTween,
      widget.offset,
      (value) => Tween<Offset>(begin: value),
    ) as Tween<Offset?>?;
  }
}
