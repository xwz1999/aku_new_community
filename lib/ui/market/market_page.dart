import 'package:aku_community/models/market/display_category_model.dart';
import 'package:aku_community/models/market/market_category_model.dart';
import 'package:aku_community/ui/market/category/category_card.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:aku_community/ui/market/category/category_page.dart';
import 'package:aku_community/ui/market/search/search_goods_page.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';

class MarketPage extends StatefulWidget {
  MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController _tabController;
  List<MarketCategoryModel> _marketModels = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    DisplayCategoryModel.top8.then((value) {
      _marketModels = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mediaWidth = MediaQuery.of(context).size.width;
    return BeeScaffold(
      leading: IconButton(
        icon: Icon(CupertinoIcons.search),
        onPressed: () {
          Get.to(() => SearchGoodsPage());
        },
      ),
      title: '商城',
      actions: [
        MaterialButton(
          minWidth: 108.w,
          padding: EdgeInsets.zero,
          onPressed: () async {
            final cancel = BotToast.showLoading();
            List<MarketCategoryModel> models =
                await DisplayCategoryModel.fetchCategory(0);
            cancel();
            Get.to(() => CategoryPage(models: models));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.grid_view,
                color: Color(0xFF333333),
                size: 48.w,
              ),
              4.hb,
              '分类'.text.size(20.sp).black.make(),
            ],
          ),
        ),
      ],
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              //AppBar top Widget height
              //bottom height: 48
              // flexibleSpace的高为 (设备宽 - 边距)/4*2 + 外边距 + bottom高
              expandedHeight: (mediaWidth - 32.w * 2) / 4 * 2 + 16.w * 2 + 48,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Color(0xFFF9F9F9),
                  padding: EdgeInsets.only(
                    top: 16.w,
                    left: 32.w,
                    right: 32.w,
                    bottom: 16.w + 48, //底部边距需要加上bottom高
                  ),
                  child: Material(
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(8.w),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1,
                      ),
                      shrinkWrap: true,
                      children: _marketModels
                          .map((e) => CategoryCard(model: e))
                          .toList(),
                    ),
                  ),
                ),
              ),
              pinned: true,
              toolbarHeight: 0,
              bottom: PreferredSize(
                child: Material(
                  color: Color(0xFFF9F9F9),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: BeeTabBar(
                      scrollable: true,
                      controller: _tabController,
                      tabs: ['社区商城', '二手市场'],
                    ),
                  ),
                ),
                preferredSize: Size.fromHeight(48),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            SizedBox(),
            SizedBox(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
