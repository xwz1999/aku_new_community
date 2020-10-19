import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'widget/bill_card.dart';

class LifePayBillPage extends StatefulWidget {
  LifePayBillPage({Key key}) : super(key: key);

  @override
  _LifePayBillPageState createState() => _LifePayBillPageState();
}

class _LifePayBillPageState extends State<LifePayBillPage> {
  Widget _cardList(String title, subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Screenutil.size(28),
            color: Color(0xff666666),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Screenutil.size(28),
            color: Color(0xff333333),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '账单详情',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Screenutil.length(32),
                left: Screenutil.length(32),
                right: Screenutil.length(32)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: Screenutil.length(20),
              vertical: Screenutil.length(32),
            ),
            child: Column(
              children: [
                _cardList('收费项目', '公共能耗费'),
                SizedBox(height: Screenutil.length(30)),
                _cardList('收费地址', '深蓝公寓 1幢1单元306室'),
              ],
            ),
          ),
          BillCard(),
        ],
      ),
    );
  }
}
