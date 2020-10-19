import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class OrderCard extends StatefulWidget {
  final Function fun;
  OrderCard({Key key,this.fun}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Container _orderInfo() {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(20),
        bottom: Screenutil.length(20),
        left: Screenutil.length(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '去年（2019年）',
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: BaseStyle.color666666,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: Screenutil.length(24)),
            child: Row(
              children: [
                Text(
                  '待缴：4项',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    color: BaseStyle.color333333,
                  ),
                ),
                SizedBox(width: Screenutil.length(40)),
                Text(
                  '已选：4项',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    color: BaseStyle.color333333,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    fontWeight: FontWeight.bold),
                children: <InlineSpan>[
                  TextSpan(
                    text: '合计：',
                    style: TextStyle(color: BaseStyle.color333333),
                  ),
                  TextSpan(
                    text: '¥${747.98}',
                    style: TextStyle(color: Color(0xfffc361d)),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  InkWell _checkInfo(Function fun) {
    return InkWell(
      onTap: (){
         Navigator.pushNamed(context, PageName.life_pay_info_page.toString(),
        arguments: Bundle()
          ..putMap('detailMap', {'title': '去年（2019年）'}));
      },
      child: Container(
        margin: EdgeInsets.only(top: Screenutil.length(20)),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: Screenutil.length(7)),
        height: Screenutil.length(44),
        width: Screenutil.length(128),
        decoration: BoxDecoration(
          color: Color(0xff2a2a2a),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          '选择明细',
          style: TextStyle(
            fontSize: BaseStyle.fontSize22,
            color: Color(0xffffffff),
          ),
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
      padding: EdgeInsets.symmetric(horizontal: Screenutil.length(32)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.radio_button_unchecked,
              color: BaseStyle.color999999,
              size: Screenutil.length(40),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _orderInfo(),
                  _checkInfo(widget.fun),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
