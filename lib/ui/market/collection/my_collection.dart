import 'package:aku_new_community/models/collection/collection_goods_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'collection_func.dart';
import 'collection_list_card.dart';

class MyCollectionPage extends StatefulWidget {
  MyCollectionPage({Key? key}) : super(key: key);

  @override
  MyCollectionPageState createState() => MyCollectionPageState();
}

class MyCollectionPageState extends State<MyCollectionPage> {
  // TextEditingController _editingController = TextEditingController();
  EasyRefreshController _refreshController = EasyRefreshController();

  // List<String> _searchHistory = [];
  String _searchText = "";
  late List<CollectionGoodsModel> _models;
  bool _onload = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () => Get.back(result: true),
                icon: Icon(
                  CupertinoIcons.chevron_back,
                  color: Colors.black,
                ),
              )
            : SizedBox(),
        titleSpacing: 0,
        bgColor: Color(0xFFF9F9F9),
        bodyColor: Color(0xFFF9F9F9),
        title: '收藏的商品',
        body: Container(
          color: Color(0xFFF2F3F4),
          child: EasyRefresh(
            firstRefresh: true,
            header: MaterialHeader(),
            controller: _refreshController,
            onRefresh: () async {
              _models = await CollectionFunc.getCollectionList();
              _onload = false;
              setState(() {});
            },
            child: _onload
                ? Container()
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    children: [
                      ..._models
                          .map((e) => CollectionListCard(
                                model: e,
                                refreshController: _refreshController,
                              ))
                          .toList()
                    ],
                  ),
          ),

          // BeeListView(
          //   path: API.market.collectionList,
          //   controller: _refreshController,
          //   extraParams: {
          //     "keyword":_searchText,
          //     },
          //   convert: (model) => model.tableList!
          //       .map((e) => CollectionGoodsModel.fromJson(e))
          //       .toList(),
          //   builder: (items) {
          //     return ListView.separated(
          //       padding: EdgeInsets.only(top: 10.w,
          //           left: 20.w, right: 20.w, bottom: 32.w),
          //       // gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          //       //   crossAxisCount: 2,
          //       //   mainAxisSpacing: 20.w,
          //       //   crossAxisSpacing: 20.w,
          //       // ),
          //       itemBuilder: (context, index) {
          //         final item = items[index];
          //         return Container(width: 100.w,height: 100.w,color: Colors.red,);
          //           CollectionListCard(
          //           model: item,); //GoodsCard(item: item);
          //       },
          //       separatorBuilder: (_, __) {
          //         return 32.w.heightBox;
          //       },
          //       itemCount: items.length,
          //     );
          //   },
          // ),
        ));
  }
}
