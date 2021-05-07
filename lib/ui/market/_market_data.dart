import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'package:aku_community/ui/market/goods/goods_card.dart';
import 'package:aku_community/ui/market/goods/goods_list_view.dart';
import 'package:aku_community/utils/headers.dart';

@Deprecated('NO NEED THIS CLASS IN FUTURE')
class MarketData {
  final String name;
  final String path;
  MarketData({
    required this.name,
    required this.path,
  });
}

@Deprecated('NO NEED THIS LIST IN FUTURE')
List<MarketData> mockableMarketData = [
  MarketData(name: '居家生活', path: R.ASSETS_ICONS_TOOL_JJSH_PNG),
  MarketData(name: '数码家电', path: R.ASSETS_ICONS_TOOL_SMJD_PNG),
  MarketData(name: '休闲副食', path: R.ASSETS_ICONS_TOOL_XXFS_PNG),
  MarketData(name: '滋补保健', path: R.ASSETS_ICONS_TOOL_ZBBJ_PNG),
  MarketData(name: '彩妆香水', path: R.ASSETS_ICONS_TOOL_CZXS_PNG),
  MarketData(name: '服饰箱包', path: R.ASSETS_ICONS_TOOL_FSXB_PNG),
  MarketData(name: '母婴玩具', path: R.ASSETS_ICONS_TOOL_MYWJ_PNG),
  MarketData(name: '饮料酒水', path: R.ASSETS_ICONS_TOOL_YLJS_PNG),
];

@Deprecated('NO NEED THIS WIDGET IN FUTURE')
class MockableMarketWidget extends StatelessWidget {
  final MarketData data;
  const MockableMarketWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Column(
        children: [
          Spacer(),
          Image.asset(
            data.path,
            height: 75.w,
            width: 75.w,
          ),
          12.hb,
          Text(
            data.name,
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xFF4A4B51),
            ),
          ),
          Spacer(),
        ],
      ),
      onPressed: () {
        Get.to(
          () => GoodsListView(),
        );
      },
    );
  }
}

@Deprecated('NO NEED THIS WIDGET IN FUTURE')
class MockableMarketList extends StatefulWidget {
  MockableMarketList({Key? key}) : super(key: key);

  @override
  _MockableMarketListState createState() => _MockableMarketListState();
}

class _MockableMarketListState extends State<MockableMarketList> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: MaterialHeader(completeDuration: Duration(milliseconds: 300)),
      onRefresh: () async {},
      child: WaterfallFlow(
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
