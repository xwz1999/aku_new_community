import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/goods_out_model.dart';
import 'package:akuCommunity/pages/goods_deto_page/deto_create_page/deto_create_page.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:akuCommunity/widget/bottom_button.dart';
import 'widget/goods_info_card.dart';

class GoodsDetoPage extends StatefulWidget {
  GoodsDetoPage({Key key}) : super(key: key);

  @override
  _GoodsDetoPageState createState() => _GoodsDetoPageState();
}

class _GoodsDetoPageState extends State<GoodsDetoPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '物品出户',
      body: Padding(
        padding: EdgeInsets.only(bottom: 98.w),
        child: BeeListView(
          controller: _refreshController,
          path: API.manager.articleOut,
          convert: (model) {
            return model.tableList
                .map((e) => GoodsOutModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return GoodsInfoCard();
              },
              itemCount: items.length,
            );
          },
        ),
      ),
      bottomNavi: BottomButton(
        title: '新增',
        fun: () {
          DetoCreatePage().to();
        },
      ),
    );
  }
}
