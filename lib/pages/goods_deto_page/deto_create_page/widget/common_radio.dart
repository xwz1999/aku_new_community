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
        margin: EdgeInsets.only(left: Screenutil.length(20)),
        child: Row(
          children: [
            Icon(
              isCheck
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: Screenutil.length(32),
              color: isCheck ? BaseStyle.colorffc40c : BaseStyle.color979797,
            ),
            SizedBox(width: Screenutil.length(10)),
            Text(
              title,
              style: TextStyle(
                  fontSize: BaseStyle.fontSize28, color: BaseStyle.color333333),
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
