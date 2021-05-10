import 'package:aku_community/ui/market/goods/goods_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/market/goods_item.dart';
import 'package:aku_community/models/market/market_category_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';

class GoodsTabListView extends StatefulWidget {
  final MarketCategoryModel model;
  GoodsTabListView({Key? key, required this.model}) : super(key: key);

  @override
  _GoodsTabListViewState createState() => _GoodsTabListViewState();
}

class _GoodsTabListViewState extends State<GoodsTabListView>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeListView<GoodsItem>(
      path: API.market.list,
      controller: _refreshController,
      extraParams: {'categoryId': widget.model.id},
      convert: (model) =>
          model.tableList?.map((e) => GoodsItem.fromJson(e)).toList() ?? [],
      builder: (items) {
        return WaterfallFlow.builder(
          gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final GoodsItem item = items[index];
            return MaterialButton(
              onPressed: () {
                Get.to(() => GoodsDetailPage(id: widget.model.id));
              },
              child: Text(item.title),
            );
          },
          itemCount: items.length,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
