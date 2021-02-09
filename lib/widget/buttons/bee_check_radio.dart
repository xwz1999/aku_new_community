// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

class BeeCheckRadio<T> extends StatefulWidget {
  final T value;
  final List<T> groupValue;
  BeeCheckRadio({Key key, this.value, this.groupValue}) : super(key: key);

  @override
  _BeeCheckRadioState createState() => _BeeCheckRadioState();
}

class _BeeCheckRadioState extends State<BeeCheckRadio> {
  bool get _selected {
    if (widget.groupValue.contains(widget.value)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 40.w,
      width: 40.w,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(_selected ? 1 : 0),
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
          CupertinoIcons.checkmark,
          color: Colors.white,
          size: 28.w,
        ),
      ),
    );
  }
}
