import 'package:akuCommunity/pages/life_pay/life_pay_info_page/life_pay_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
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
        top: 20.w,
        bottom: 20.w,
        left: 24.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '去年（2019年）',
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: ktextSubColor,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 24.w),
            child: Row(
              children: [
                Text(
                  '待缴：4项',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    color: ktextPrimary,
                  ),
                ),
                SizedBox(width: 40.w),
                Text(
                  '已选：4项',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    color: ktextPrimary,
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
                    style: TextStyle(color: ktextPrimary),
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
        LifePayInfoPage(bundle: Bundle()
          ..putMap('detailMap', {'title': '去年（2019年）'}),).to;
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.w),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 7.w),
        height: 44.w,
        width: 128.w,
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
        top: 32.w,
        left: 32.w,
        right: 32.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 32.w),
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
              size: 40.w,
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
