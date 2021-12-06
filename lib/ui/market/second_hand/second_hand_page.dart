import 'package:aku_new_community/models/market/goods_item.dart';
import 'package:aku_new_community/ui/market/goods/goods_card.dart';
import 'package:aku_new_community/ui/market/second_hand/add_second_hand_goods_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class SecondHandPage extends StatefulWidget {
  SecondHandPage({Key? key}) : super(key: key);

  @override
  _SecondHandPageState createState() => _SecondHandPageState();
}

class _SecondHandPageState extends State<SecondHandPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '二手市场',
      actions: [
        IconButton(
          icon: Icon(
            CupertinoIcons.add_circled,
          ),
          onPressed: () {
            Get.to(() => AddSecondGoodsPage());
          },
        ),
      ],
      body: WaterfallFlow.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20.w,
        crossAxisSpacing: 20.w,
        padding: EdgeInsets.all(32.w),
        children: [GoodsCard(item: GoodsItem.example())],
      ),
    );
  }
}
