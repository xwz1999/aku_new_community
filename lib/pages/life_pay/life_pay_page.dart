import 'package:akuCommunity/pages/life_pay/life_pay_info_page/life_pay_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'widget/order_card.dart';
import 'widget/submit_bar.dart';

class LifePayPage extends StatefulWidget {
  LifePayPage({Key key}) : super(key: key);

  @override
  _LifePayPageState createState() => _LifePayPageState();
}

class _LifePayPageState extends State<LifePayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '生活缴费',
          subtitle: '缴费记录',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 130.w),
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 32.w,
                  left: 32.w,
                  right: 32.w,
                ),
                child: RichText(
                  text: TextSpan(
                      style:
                          TextStyle(fontSize: 28.sp, color: Color(0xff666666)),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '深圳华茂悦峰',
                        ),
                        TextSpan(
                          text: '1幢-1单元-702室',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ),
              OrderCard(
                  fun: LifePayInfoPage(
                bundle: Bundle()
                  ..putMap('commentMap', {'title': '明细', 'isActions': false}),
              ).to),
            ],
          ),
          Positioned(
            bottom: 0,
            child: SubmitBar(title: '去缴费'),
          ),
        ],
      ),
    );
  }
}
