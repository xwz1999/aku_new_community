import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/base_style.dart';

class BottomButton extends StatefulWidget {
  final String title;
  final Function fun;
  BottomButton({Key key, this.title, this.fun}) : super(key: key);

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 98.w,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: widget.fun,
        child: Container(
          alignment: Alignment.center,
          color: widget.fun == null
              ? BaseStyle.color999999
              : BaseStyle.colorffc40c,
          padding: EdgeInsets.symmetric(
            vertical: 26.5.w,
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize32,
              color: ktextPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
