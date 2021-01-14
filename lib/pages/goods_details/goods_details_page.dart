import 'dart:convert';
import 'package:akuCommunity/pages/goods_details/view_comments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:get/get.dart';
import 'widget/goods_app_bar.dart';
import 'widget/product_swiper.dart';
import 'widget/product_content.dart';
import 'widget/product_service.dart';
import 'widget/product_evaluate.dart';
import 'widget/product_detail.dart';
import 'widget/goods_details_bottom_bar.dart';

class GoodsDetailsPage extends StatefulWidget {
  final Bundle bundle;
  GoodsDetailsPage({Key key, this.bundle}) : super(key: key);

  @override
  _GoodsDetailsPageState createState() => _GoodsDetailsPageState();
}

class _GoodsDetailsPageState extends State<GoodsDetailsPage> {
  Map<String, dynamic> shopInfo = {};

  @override
  void initState() {
    super.initState();
    shopInfo = json.decode(widget.bundle.getString('shoplist'));
  }

  @override
  Widget build(BuildContext context) {
    final List<String> params = shopInfo["taobao_image"].split(',');
    return Scaffold(
      appBar: PreferredSize(
        child: GoodsAppBar(
          shareImg: params.first,
          title: shopInfo["itemtitle"],
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 100.w),
            children: [
              ProductSwiper(imageUrl: params),
              ProductContent(
                itemprice: shopInfo["itemprice"],
                itemtitle: shopInfo["itemtitle"],
                itemshorttitle: shopInfo["itemshorttitle"],
                itemdesc: shopInfo["itemdesc"],
              ),
              ProductService(),
              // ProductSpecs(),
              ProductEvaluate(
                fun: () {
                  Get.to(ViewCommentsPage());
                },
              ),
              ProductDetail(
                picDesc: shopInfo["itempic_copy"],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: GoodsDetailsBottomBar(
              itemid: shopInfo["itemid"],
              itemtitle: shopInfo["itemtitle"],
              itemprice: shopInfo["itemprice"],
              itempic: shopInfo["itempic"],
            ),
          ),
        ],
      ),
    );
  }
}
