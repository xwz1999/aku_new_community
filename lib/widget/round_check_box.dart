import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';

class RoundCheckBox extends StatefulWidget {
  var value = false;

  Function onChanged;

  String title;

  RoundCheckBox({Key key, @required this.value, this.onChanged, this.title})
      : super(key: key);

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: widget.onChanged,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.value
                ? Icon(
                    Icons.check_circle,
                    size: 30.sp,
                    color: Color(0xffffc40c),
                  )
                : Icon(
                    Icons.panorama_fish_eye,
                    size: 30.sp,
                    color: Color(0xff979797),
                  ),
            SizedBox(width: 10.w),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 26.sp,
                color: Color(0xff333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
