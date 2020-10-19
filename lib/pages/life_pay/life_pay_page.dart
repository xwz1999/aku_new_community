import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
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
  void detailsRouter() {
    Navigator.pushNamed(context, PageName.life_pay_info_page.toString(),
        arguments: Bundle()
          ..putMap('commentMap', {'title': '明细', 'isActions': false}));
  }

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
            padding: EdgeInsets.only(bottom: Screenutil.length(130)),
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: Screenutil.length(32),
                  left: Screenutil.length(32),
                  right: Screenutil.length(32),
                ),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: Screenutil.size(28),
                          color: Color(0xff666666)),
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
              OrderCard(fun: detailsRouter),
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
