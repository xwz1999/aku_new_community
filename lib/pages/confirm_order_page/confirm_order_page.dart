import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'widget/confirm_address.dart';
import 'widget/confirm_content.dart';
import 'widget/confirm_bottom_bar.dart';

class ConfirmOrderPage extends StatelessWidget {
  final Bundle bundle;
  ConfirmOrderPage({Key key, this.bundle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '确认订单',
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 98.w),
            children: [
              SizedBox(height: 20.w),
              ConfirmAddress(),
              SizedBox(height: 20.w),
              ConfirmContent(cartMap: bundle.getMap('cartMap')),
            ],
          ),
          Positioned(
            bottom: 0,
            child: ConfirmBottomBar(cartMap: bundle.getMap('cartMap')),
          ),
        ],
      ),
    );
  }
}
