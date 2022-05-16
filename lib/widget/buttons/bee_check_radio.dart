import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/utils/headers.dart';

class BeeCheckRadio<T> extends StatefulWidget {
  final T? value;
  final List<T>? groupValue;
  final Widget? indent;
  final Color? backColor;
  final double? size;
  final bool? canCheck;

  BeeCheckRadio(
      {Key? key,
      this.value,
      this.groupValue,
      this.indent,
      this.backColor,
      this.size,
      this.canCheck,})
      : super(key: key);

  @override
  _BeeCheckRadioState createState() => _BeeCheckRadioState();
}

class _BeeCheckRadioState extends State<BeeCheckRadio> {
  bool get _selected {
    if (widget.groupValue!.contains(widget.value)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.canCheck!=null&&widget.canCheck!){
      return AnimatedContainer(
        height: widget.size ?? 40.w,
        width: widget.size ?? 40.w,
        decoration: BoxDecoration(
          color: Color(0xFF979797),
          border: Border.all(
            color: Color(0xFF979797),
            width: 3.w,
          ),
          borderRadius: BorderRadius.circular((widget.size??40.w)/2),
        ),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        alignment: Alignment.center,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          opacity: 1,
          child:
              Icon(
                CupertinoIcons.checkmark,
                color: Colors.white,
                size: 28.w,
              ),
        ),
      );
    }
    else
    return AnimatedContainer(
      height: widget.size ?? 40.w,
      width: widget.size ?? 40.w,
      decoration: BoxDecoration(
        color: widget.backColor ?? kPrimaryColor.withOpacity(_selected ? 1 : 0),
        border: Border.all(
          color: widget.backColor != null
              ? Color(0xFFBBBBBB)
              : (_selected ? kPrimaryColor : Color(0xFF979797)),
          width: 3.w,
        ),
        borderRadius: BorderRadius.circular((widget.size??40.w)/2),
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      alignment: Alignment.center,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        opacity: _selected ? 1 : 0,
        child: widget.indent ??
            Icon(
              CupertinoIcons.checkmark,
              color: Colors.white,
              size: 28.w,
            ),
      ),
    );
  }
}
