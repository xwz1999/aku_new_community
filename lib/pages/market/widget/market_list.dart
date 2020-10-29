import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/widget/sliver_goods_card.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/goods_card_skeleton.dart';
import 'package:akuCommunity/service/net_util.dart';
import 'package:akuCommunity/service/base_model.dart';
import 'package:akuCommunity/model/aku_shop_model.dart';
import 'sliver_goods_group_card.dart';

class MarketList extends StatefulWidget {
  final bool isGroup;
  final String title;
  MarketList({Key key, this.isGroup = false, this.title}) : super(key: key);

  @override
  _MarketListState createState() => _MarketListState();
}

class _MarketListState extends State<MarketList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController _controller;

  List<AkuShopModel> _shopList = [];

  int page = 1;

  @override
  void initState() {
    super.initState();
    akuShop();
  }

  Future<void> akuShop() async {
    switch (widget.title) {
      case '居家生活':
        Future<String> loadString =
            DefaultAssetBundle.of(context).loadString("assets/json/jjsh.json");
        loadString.then((String response) {
          Map<String, dynamic> result = json.decode(response.toString());
          BaseModel model = BaseModel.fromJson(result);
          model.result.forEach((item) {
            item["count"] = 1;
            item["isCheck"] = false;
            AkuShopModel list = AkuShopModel.fromJson(item);
            setState(() {
              _shopList.add(list);
            });
          });
        });
        break;
      case '数码家电':
        Future<String> loadString =
            DefaultAssetBundle.of(context).loadString("assets/json/smjd.json");
        loadString.then((String response) {
          Map<String, dynamic> result = json.decode(response.toString());
          BaseModel model = BaseModel.fromJson(result);
          model.result.forEach((item) {
            item["count"] = 1;
            item["isCheck"] = false;
            AkuShopModel list = AkuShopModel.fromJson(item);
            setState(() {
              _shopList.add(list);
            });
          });
        });

        break;
      case '休闲副食':
        Future<String> loadString =
            DefaultAssetBundle.of(context).loadString("assets/json/xxfs.json");
        loadString.then((String response) {
          Map<String, dynamic> result = json.decode(response.toString());
          BaseModel model = BaseModel.fromJson(result);
          model.result.forEach((item) {
            item["count"] = 1;
            item["isCheck"] = false;
            AkuShopModel list = AkuShopModel.fromJson(item);
            setState(() {
              _shopList.add(list);
            });
          });
        });

        break;
      case '滋补保健':
        Future<String> loadString =
            DefaultAssetBundle.of(context).loadString("assets/json/zbbj.json");
        loadString.then((String response) {
          Map<String, dynamic> result = json.decode(response.toString());
          BaseModel model = BaseModel.fromJson(result);
          model.result.forEach((item) {
            item["count"] = 1;
            item["isCheck"] = false;
            AkuShopModel list = AkuShopModel.fromJson(item);
            setState(() {
              _shopList.add(list);
            });
          });
        });

        break;
      case '彩妆香水':
        Future<String> loadString =
            DefaultAssetBundle.of(context).loadString("assets/json/czxs.json");
        loadString.then((String response) {
          Map<String, dynamic> result = json.decode(response.toString());
          BaseModel model = BaseModel.fromJson(result);
          model.result.forEach((item) {
            item["count"] = 1;
            item["isCheck"] = false;
            AkuShopModel list = AkuShopModel.fromJson(item);
            setState(() {
              _shopList.add(list);
            });
          });
        });

        break;
      case '服饰箱包':
        Future<String> loadString =
            DefaultAssetBundle.of(context).loadString("assets/json/fsxb.json");
        loadString.then((String response) {
          Map<String, dynamic> result = json.decode(response.toString());
          BaseModel model = BaseModel.fromJson(result);
          model.result.forEach((item) {
            item["count"] = 1;
            item["isCheck"] = false;
            AkuShopModel list = AkuShopModel.fromJson(item);
            setState(() {
              _shopList.add(list);
            });
          });
        });

        break;
      case '母婴玩具':
        Future<String> loadString =
            DefaultAssetBundle.of(context).loadString("assets/json/mywj.json");
        loadString.then((String response) {
          Map<String, dynamic> result = json.decode(response.toString());
          BaseModel model = BaseModel.fromJson(result);
          model.result.forEach((item) {
            item["count"] = 1;
            item["isCheck"] = false;
            AkuShopModel list = AkuShopModel.fromJson(item);
            setState(() {
              _shopList.add(list);
            });
          });
        });

        break;
      case '饮料酒水':
        Future<String> loadString =
            DefaultAssetBundle.of(context).loadString("assets/json/yljs.json");
        loadString.then((String response) {
          Map<String, dynamic> result = json.decode(response.toString());
          BaseModel model = BaseModel.fromJson(result);
          model.result.forEach((item) {
            item["count"] = 1;
            item["isCheck"] = false;
            AkuShopModel list = AkuShopModel.fromJson(item);
            setState(() {
              _shopList.add(list);
            });
          });
        });

        break;
      default:
        Future<String> loadString =
            DefaultAssetBundle.of(context).loadString("assets/json/shop.json");
        loadString.then((String response) {
          Map<String, dynamic> result = json.decode(response.toString());
          BaseModel model = BaseModel.fromJson(result);
          model.result.forEach((item) {
            item["count"] = 1;
            item["isCheck"] = false;
            AkuShopModel list = AkuShopModel.fromJson(item);
            setState(() {
              _shopList.add(list);
            });
          });
        });

        break;
    }
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1500));
    page++;
    // akuShop(page);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      child: SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(),
        footer: ClassicFooter(),
        onLoading: _onLoading,
        enablePullUp: true,
        enablePullDown: false,
        child: CustomScrollView(
          slivers: [
            widget.isGroup
                ? SliverGoodsGroupCard()
                : SliverPadding(
                    padding: EdgeInsets.only(
                      top: 30.w,
                      left: 32.w,
                      right: 32.w,
                    ),
                    sliver: _shopList.length == 0
                        ? SliverToBoxAdapter(child: GoodsCardSkeleton())
                        : SliverGoodsCard(
                            shoplist: _shopList,
                            isShow: true,
                          )),
          ],
        ),
      ),
    );
  }
}
