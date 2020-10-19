import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';

class SubmitBar extends StatefulWidget {
  final String title;
  SubmitBar({Key key,this.title}) : super(key: key);

  @override
  _SubmitBarState createState() => _SubmitBarState();
}

class _SubmitBarState extends State<SubmitBar> {
  InkWell _selectAll() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Screenutil.length(29)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.radio_button_unchecked,
              color: BaseStyle.color999999,
              size: Screenutil.length(40),
            ),
            SizedBox(width: Screenutil.length(16)),
            Text(
              '全选',
              style: TextStyle(
                  fontSize: BaseStyle.fontSize24, color: BaseStyle.color666666),
            ),
          ],
        ),
      ),
    );
  }

  Container _submitOrder(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Screenutil.length(12)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: Screenutil.length(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(children: <InlineSpan>[
                    TextSpan(
                      text: '合计：',
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize26,
                          color: BaseStyle.color333333),
                    ),
                    TextSpan(
                      text: '¥${3009.84}',
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffe60e0e)),
                    ),
                  ]),
                ),
                Text(
                  '已选${10}项',
                  style: TextStyle(
                      fontSize: BaseStyle.fontSize22,
                      color: BaseStyle.color999999),
                ),
              ],
            ),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: Screenutil.length(15),
                bottom: Screenutil.length(14),
              ),
              height: Screenutil.length(74),
              width: Screenutil.length(198),
              decoration: BoxDecoration(
                color: BaseStyle.colorffc40c,
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: BaseStyle.fontSize32,
                  color: BaseStyle.color333333,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: Screenutil.length(98),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: Screenutil.length(32)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _selectAll(),
          _submitOrder(widget.title),
        ],
      ),
    );
  }
}
