import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/utils/headers.dart';

class SubmitBar extends StatefulWidget {
  final String? title;
  SubmitBar({Key? key, this.title}) : super(key: key);

  @override
  _SubmitBarState createState() => _SubmitBarState();
}

class _SubmitBarState extends State<SubmitBar> {
  InkWell _selectAll() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 29.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.radio_button_unchecked,
              color: BaseStyle.color999999,
              size: 40.w,
            ),
            SizedBox(width: 16.w),
            Text(
              '全选',
              style: TextStyle(
                  fontSize: BaseStyle.fontSize24, color: ktextSubColor),
            ),
          ],
        ),
      ),
    );
  }

  Container _submitOrder(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.w),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(children: <InlineSpan>[
                    TextSpan(
                      text: '合计：',
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize26, color: ktextPrimary),
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
                top: 15.w,
                bottom: 14.w,
              ),
              height: 74.w,
              width: 198.w,
              decoration: BoxDecoration(
                color: BaseStyle.colorffc40c,
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: BaseStyle.fontSize32,
                  color: ktextPrimary,
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
      height: 98.w,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _selectAll(),
          _submitOrder(widget.title!),
        ],
      ),
    );
  }
}
