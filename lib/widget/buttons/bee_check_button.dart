import 'package:flutter/material.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

class BeeCheckButton<T> extends StatefulWidget {
  final Function(T value) onChange;
  final T value;
  final T groupValue;
  final String title;
  BeeCheckButton(
      {Key key, this.onChange, this.value, this.groupValue, this.title})
      : super(key: key);

  @override
  _BeeCheckButtonState createState() => _BeeCheckButtonState();
}

class _BeeCheckButtonState extends State<BeeCheckButton> {
  bool get isSelect => widget.groupValue == widget.value;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        widget.onChange(widget.value);
      },
      child: widget.title.text
          .color(isSelect ? ktextPrimary : Color(0xFF979797))
          .size(32.sp)
          .make(),
      padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 14.w),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: isSelect ? kPrimaryColor : ktextSubColor, width: 3.w),
          borderRadius: BorderRadius.circular(36.w)),
    );
  }
}
