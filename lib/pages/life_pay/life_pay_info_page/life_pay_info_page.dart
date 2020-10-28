import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'widget/details_card.dart';
import '../widget/submit_bar.dart';

class LifePayInfoPage extends StatefulWidget {
  final Bundle bundle;
  LifePayInfoPage({Key key, this.bundle}) : super(key: key);

  @override
  _LifePayInfoPageState createState() => _LifePayInfoPageState();
}

class _LifePayInfoPageState extends State<LifePayInfoPage> {
  void billRouter() {
    Navigator.pushNamed(context, PageName.life_pay_bill_page.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title:' ${widget.bundle.getMap('detailMap')['title']}明细',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 130.w),
            children: [
              DetailsCard(fun: billRouter),
            ],
          ),
          Positioned(
            bottom: 0,
            child: SubmitBar(title: '选好了'),
          ),
        ],
      ),
    );
  }
}
