import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/animated/animated_scale.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';

class CommonRadio<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final Widget text;
  final double size;
  CommonRadio({Key key, this.value, this.groupValue, this.text, this.size})
      : super(key: key);

  @override
  _CommonRadioState createState() => _CommonRadioState();
}

class _CommonRadioState extends State<CommonRadio> {
  bool get _selected => widget.value == widget.groupValue;
  double get smallSize {
    return widget.size.isNull ? 24.w : (widget.size * 24 / 40);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          height: widget.size ?? 40.w,
          width: widget.size ?? 40.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: _selected ? kPrimaryColor : Color(0xFF979797),
              width: 3.w,
            ),
            borderRadius: BorderRadius.circular(20.w),
          ),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          alignment: Alignment.center,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            opacity: _selected ? 1 : 0,
            child: AnimatedScale(
              scale: _selected ? 1 : 0,
              child: Container(
                height: smallSize,
                width: smallSize,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
            ),
          ),
        ),
        10.w.widthBox,
        widget.text,
        10.w.widthBox,
      ],
    );
  }
}
