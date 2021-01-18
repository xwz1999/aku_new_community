import 'package:akuCommunity/pages/life_pay/life_pay_bill_page/life_pay_bill_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'widget/details_card.dart';
import '../widget/submit_bar.dart';

class LifePayInfoPage extends StatefulWidget {
  final Bundle bundle;
  LifePayInfoPage({Key key, this.bundle}) : super(key: key);

  @override
  _LifePayInfoPageState createState() => _LifePayInfoPageState();
}

class _LifePayInfoPageState extends State<LifePayInfoPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: ' ${widget.bundle.getMap('detailMap')['title']}明细',
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 130.w),
            children: [
              DetailsCard(fun: LifePayBillPage().to),
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
