import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/screenutil.dart';

class CommonRadio extends StatefulWidget {
  final List<Map<String, dynamic>> commonlist;
  final Function fun;
  CommonRadio({Key key, this.commonlist, this.fun}) : super(key: key);

  @override
  _CommonRadioState createState() => _CommonRadioState();
}

class _CommonRadioState extends State<CommonRadio> {
  InkWell _inkWellRadio(String title, bool isCheck,int index, Function fun) {
    return InkWell(
      onTap: () {
        fun(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w),
        child: Row(
          children: [
            Icon(
              isCheck
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 32.w,
              color: isCheck ? BaseStyle.colorffc40c : BaseStyle.color979797,
            ),
            SizedBox(width: 10.w),
            Text(
              title,
              style: TextStyle(
                  fontSize: BaseStyle.fontSize28, color: ktextPrimary),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: widget.commonlist
            .asMap()
            .keys
            .map((index) => _inkWellRadio(
                  widget.commonlist[index]['title'],
                  widget.commonlist[index]['isCheck'],
                  index,
                  widget.fun
                ))
            .toList(),
      ),
    );
  }
}
