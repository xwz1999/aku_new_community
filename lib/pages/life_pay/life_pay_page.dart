// Flutter imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/life_pay_model.dart';
import 'package:akuCommunity/pages/personal/widget/order_card.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// Package imports:
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/pages/life_pay/life_pay_record_page/life_pay_record_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class LifePayPage extends StatefulWidget {
  LifePayPage({Key key}) : super(key: key);

  @override
  _LifePayPageState createState() => _LifePayPageState();
}

class _LifePayPageState extends State<LifePayPage> {
  EasyRefreshController _controller;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '生活缴费',
      actions: [
        InkWell(
          onTap: () {
            LifePayRecordPage().to();
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(32.w, 28.w, 32.w, 20.w),
            alignment: Alignment.center,
            child: '缴费记录'.text.black.size(28.sp).make(),
          ),
        ),
      ],
      // body: Stack(
      //   children: [
      //     ListView(
      //       padding: EdgeInsets.only(bottom: 130.w),
      //       children: [
      //         Container(
      //           margin: EdgeInsets.only(
      //             top: 32.w,
      //             left: 32.w,
      //             right: 32.w,
      //           ),
      //           child: RichText(
      //             text: TextSpan(
      //                 style:
      //                     TextStyle(fontSize: 28.sp, color: Color(0xff666666)),
      //                 children: <InlineSpan>[
      //                   TextSpan(
      //                     text: '深圳华茂悦峰',
      //                   ),
      //                   TextSpan(
      //                     text: '1幢-1单元-702室',
      //                     style: TextStyle(fontWeight: FontWeight.bold),
      //                   ),
      //                 ]),
      //           ),
      //         ),
      //         OrderCard(
      //             fun: LifePayInfoPage(
      //           bundle: Bundle()
      //             ..putMap('commentMap', {'title': '明细', 'isActions': false}),
      //         ).to),
      //       ],
      //     ),
      //     Positioned(
      //       bottom: 0,
      //       child: SubmitBar(title: '去缴费'),
      //     ),
      //   ],
      // ),
      body: BeeListView(
          path: API.manager.dailyPaymentList,
          controller: _controller,
          convert: (model) {
            return model.tableList
                .map((e) => LifePayMolde.fromJson(e))
                .toList();
          },
          builder: (items){
            return ListView.builder(itemBuilder: (context, index){
              // return _buildCard(items[index]);
              return OrderCard();
            },
            // itemCount: items.length,
            ) ;
          }),
    );
  }
}
