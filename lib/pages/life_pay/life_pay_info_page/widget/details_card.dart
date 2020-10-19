import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DetailsCard extends StatefulWidget {
  final Function fun;
  DetailsCard({Key key,this.fun}) : super(key: key);

  @override
  _DetailsCardState createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  Container _detailHeader() {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(20),
        bottom: Screenutil.length(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '公共能耗费',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize30,
              color: BaseStyle.color333333,
            ),
          ),
          Text(
            '宁波华茂悦峰  1幢-1单元-702室',
            style: TextStyle(
              fontSize: BaseStyle.fontSize30,
              color: BaseStyle.color333333,
            ),
          ),
        ],
      ),
    );
  }

  InkWell _detailContent(Function fun) {
    return InkWell(
      onTap: fun,
      child:Container(
      margin: EdgeInsets.only(top: Screenutil.length(32)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.radio_button_unchecked,
                color: BaseStyle.color999999,
                size: Screenutil.length(40),
              ),
              SizedBox(width: Screenutil.length(24)),
              Text(
                '2019上半年',
                style: TextStyle(
                  fontSize: BaseStyle.fontSize28,
                  color: BaseStyle.color333333,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '¥${50.90}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: BaseStyle.fontSize28,
                  color: Color(0xfffc361d),
                ),
              ),
              SizedBox(width: Screenutil.length(28)),
              Icon(
                AntDesign.right,
                color: BaseStyle.color999999,
                size: Screenutil.length(30),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(32),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
      ),
      padding: EdgeInsets.only(
        left: Screenutil.length(32),
        right: Screenutil.length(32),
        bottom: Screenutil.length(32),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailHeader(),
          _detailContent(widget.fun),
          _detailContent(widget.fun),
        ],
      ),
    );
  }
}
