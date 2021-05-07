import 'package:aku_community/ui/market/goods/goods_card.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class GoodsListView extends StatefulWidget {
  GoodsListView({Key? key}) : super(key: key);

  @override
  _GoodsListViewState createState() => _GoodsListViewState();
}

class _GoodsListViewState extends State<GoodsListView> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: 'TEST',
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.search),
          onPressed: () {},
        )
      ],
      appBarBottom: PreferredSize(
        child: SizedBox(
          height: 220.w,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            scrollDirection: Axis.horizontal,
            children: [
              GoodsSubTypeButton(),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(220.w),
      ),
      body: WaterfallFlow(
        padding: EdgeInsets.all(32.w),
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.w,
          crossAxisSpacing: 20.w,
        ),
        children: [
          GoodsCard(),
          GoodsCard(),
          GoodsCard(),
          GoodsCard(),
          GoodsCard(),
        ],
      ),
    );
  }
}

class GoodsSubTypeButton extends StatelessWidget {
  const GoodsSubTypeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 136.w,
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            width: 100.w,
            height: 100.w,
          ),
          20.hb,
          Text(
            '健康运动',
            style: TextStyle(
              fontSize: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
