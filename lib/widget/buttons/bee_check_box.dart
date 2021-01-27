// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';

class BeeCheckBox extends StatefulWidget {
  final Function(bool) onChange;
  BeeCheckBox({Key key, this.onChange}) : super(key: key);

  @override
  _BeeCheckBoxState createState() => _BeeCheckBoxState();
}

class _BeeCheckBoxState extends State<BeeCheckBox> {
  bool _isSelect = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _isSelect = !_isSelect;
        setState(() {});
        widget.onChange(_isSelect);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(
              width: 1.w, color: _isSelect ? kPrimaryColor : kDarkSubColor),
          color: _isSelect ? kPrimaryColor : Colors.transparent,
        ),
        curve: Curves.easeInOutCubic,
        width: 28.w,
        height: 28.w,
        child: _isSelect
            ? Icon(
                CupertinoIcons.check_mark,
                size: 25.w,
                color: Colors.white,
              )
            : SizedBox(),
      ),
    );
  }
}
