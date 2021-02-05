import 'package:akuCommunity/base/base_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';

class BeeSingleCheck<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  BeeSingleCheck({Key key, this.value, this.groupValue}) : super(key: key);

  @override
  _BeeSingleCheckState createState() => _BeeSingleCheckState();
}

class _BeeSingleCheckState extends State<BeeSingleCheck> {
  bool get _selected => widget.value == widget.groupValue;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 40.w,
      width: 40.w,
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
        child: Icon(
          CupertinoIcons.chevron_up,
          color: Colors.white,
          size: 24.w,
        ),
      ),
    );
  }
}
