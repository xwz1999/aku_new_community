// import 'package:aku_community/base/base_style.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/ui/market/widget/animated_home_background.dart';
import 'package:aku_community/ui/search/bee_search.dart';
import 'package:aku_community/widget/home/home_sliver_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/market/display_category_model.dart';
import 'package:aku_community/models/market/goods_item.dart';
import 'package:aku_community/models/market/market_category_model.dart';
import 'package:aku_community/ui/market/category/category_card.dart';
import 'package:aku_community/ui/market/category/category_page.dart';
import 'package:aku_community/ui/market/goods/goods_card.dart';
import 'package:aku_community/ui/market/order/my_order_page.dart';
import 'package:aku_community/ui/market/search/search_goods_page.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/base_list_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/provider/app_provider.dart';

// import 'package:aku_community/ui/market/goods/goods_detail_page.dart';

// import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';

class MarketPage extends StatefulWidget {
  MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>
    with AutomaticKeepAliveClientMixin , TickerProviderStateMixin{
  List<MarketCategoryModel> _marketModels = [];
  List<GoodsItem> _hotItems = [];
  late EasyRefreshController _refreshController;
  late ScrollController _sliverListController;
  GlobalKey<HomeSliverAppBarState> _sliverAppBarGlobalKey = GlobalKey();
  GlobalKey<AnimatedHomeBackgroundState> _animatedBackgroundState = GlobalKey();
  int _pageNum = 1;
  int _size = 4;
  int _pageCount = 0;
  double MessageHeight = 0;
  double bannerHeight = 0;
  double buttonsHeight = 200.w;

  double tabBarHeight = 60.w;
  late TabController _tabController;

  Future updateMarketInfo() async {
    BaseListModel baseListModel =
        await NetUtil().getList(API.market.hotTop, params: {
      "pageNum": _pageNum,
      "size": _size,
    });
    if (baseListModel.tableList!.isNotEmpty) {
      _hotItems = (baseListModel.tableList as List)
          .map((e) => GoodsItem.fromJson(e))
          .toList();
    }
    _pageCount = baseListModel.pageCount!;
  }

  Future loadMarketInfo() async {
    BaseListModel baseListModel =
        await NetUtil().getList(API.market.hotTop, params: {
      "pageNum": _pageNum,
      "size": _size,
    });
    if (baseListModel.tableList!.isNotEmpty) {
      _hotItems.addAll((baseListModel.tableList as List)
          .map((e) => GoodsItem.fromJson(e))
          .toList());
    }
    _pageCount = baseListModel.pageCount!;
  }

  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
    _sliverListController = ScrollController();
    _tabController = TabController(
        initialIndex: 0, length: 3, vsync: this);
    Future.delayed(Duration(milliseconds: 0), () async {
      _marketModels = await DisplayCategoryModel.top8;
      await updateMarketInfo();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _sliverListController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mediaWidth = MediaQuery.of(context).size.width;

    MessageHeight = 76;

    return Scaffold(
      // leading: IconButton(
      //   icon: Icon(CupertinoIcons.search),
      //   onPressed: () {
      //     Get.to(() => SearchGoodsPage());
      //   },
      // ),
      // title: '商城',
      // actions: [
      //   MaterialButton(
      //     minWidth: 108.w,
      //     padding: EdgeInsets.zero,
      //     onPressed: () async {
      //       // Get.to(() => SecondHandPage());
      //       Get.to(() => MyOrderPage());
      //     },
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.max,
      //       children: [
      //         Image.asset(
      //           R.ASSETS_ICONS_SECOND_HAND_PNG,
      //           width: 48.w,
      //           height: 48.w,
      //         ),
      //         4.hb,
      //         // '二手'.text.size(20.sp).black.make(),
      //         '订单'.text.size(20.sp).black.make(),
      //       ],
      //     ),
      //   ),
      //   MaterialButton(
      //     minWidth: 108.w,
      //     padding: EdgeInsets.zero,
      //     onPressed: () async {
      //       final cancel = BotToast.showLoading();
      //       List<MarketCategoryModel> models =
      //           await DisplayCategoryModel.fetchCategory(0);
      //       cancel();
      //       Get.to(() => CategoryPage(models: models));
      //     },
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.max,
      //       children: [
      //         Image.asset(
      //           R.ASSETS_ICONS_CATEGORY_PNG,
      //           width: 48.w,
      //           height: 48.w,
      //         ),
      //         4.hb,
      //         '分类'.text.size(20.sp).black.make(),
      //       ],
      //     ),
      //   ),
      // ],
      body:EasyRefresh(
        firstRefresh: true,
        enableControlFinishLoad: false,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        controller: _refreshController,
        onRefresh: () async {
          _pageNum = 1;
          await updateMarketInfo();
          setState(() {});
        },
        onLoad: () async {
          _pageNum++;
          await loadMarketInfo();
          if (_pageCount <= _pageNum) {
            _refreshController.finishLoad(noMore: false);
          }
          setState(() {});
        },
        child:  _buildBody(context),

      ),



    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomScrollView(
      controller: _sliverListController,
      slivers: <Widget>[
        HomeSliverAppBar(
            key: _sliverAppBarGlobalKey,
            actions: _actionsWidget(),
            title: _buildTitle(),
            backgroundColor: Colors.white,
            expandedHeight:
                bannerHeight +
                buttonsHeight+600.w,
            flexibleSpace: _flexibleSpaceBar(context),

            bottom:  PreferredSize(
              preferredSize: Size.fromHeight(tabBarHeight),
              child: _goodsTitle()

              // Container(
              //   color: Colors.green,
              //   height: tabBarHeight,
              //   width: 200.w,
              //   // alignment: Alignment.center,
              //   // color: AppColor.frenchColor,
              //   // child: HomePageTabbar(
              //   //   promotionList: _promotionList,
              //   //   timerJump: (index) {
              //   //     _tabIndex = index;
              //   //     _homeCountdownController.indexChange(index);
              //   //     // 定时任务回调
              //   //     _tabController.animateTo(index);
              //   //     _getPromotionGoodsList(_promotionList[index].id);
              //   //   },
              //   //   clickItem: (index) {
              //   //     _homeCountdownController.indexChange(index);
              //   //     _getPromotionGoodsList(_promotionList[index].id);
              //   //   },
              //   //   tabController: _tabController,
              //   // ),
              // ),
            )),
        SliverPadding(
          padding: EdgeInsets.all(10.w),
        ),
        buildSliverGrid(),

        // EasyRefresh(
        //   firstRefresh: false,
        //   enableControlFinishLoad: false,
        //   header: MaterialHeader(),
        //   footer: MaterialFooter(),
        //   controller: _refreshController,
        //   onRefresh: () async {
        //     _pageNum = 1;
        //     await updateMarketInfo();
        //     setState(() {});
        //   },
        //   onLoad: () async {
        //     _pageNum++;
        //     await loadMarketInfo();
        //     if (_pageCount <= _pageNum) {
        //       _refreshController.finishLoad(noMore: false);
        //     }
        //     setState(() {});
        //   },
        //   child: WaterfallFlow.builder(
        //     gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       mainAxisSpacing: 20.w,
        //       crossAxisSpacing: 20.w,
        //     ),
        //     padding: EdgeInsets.all(32.w),
        //     itemBuilder: (context, index) {
        //       final item = _hotItems[index];
        //       return GoodsCard(item: item);
        //     },
        //     itemCount: _hotItems.length,
        //   ),
        // ),
      ],
    );
  }

  SliverGrid buildSliverGrid() {
    return SliverGrid(
        // child: WaterfallFlow.builder(
        //   gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 20.w,
        //     crossAxisSpacing: 20.w,
        //   ),
        //   padding: EdgeInsets.all(32.w),
        //   itemBuilder: (context, index) {
        //     final item = _hotItems[index];
        //     return GoodsCard(item: item);
        //   },
        //   itemCount: _hotItems.length,
        // ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20.w,
            crossAxisSpacing: 20.w,
      ),
      ///子Item构建器
      delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          ///每一个子Item的样式
              //return GoodsCard(item:  _hotItems[index]);
              return Container(
                width: 200.w,
                  height: 200.w,
                color: Colors.blue,
              );
        },
        ///子Item的个数
        childCount: 20,//_hotItems.length,
      ),
    );
  }

  _actionsWidget() {
    return <Widget>[
      GestureDetector(
        onTap: () {
          //Get.to(() => BeeSearch()); 购物车
        },
        child: Image.asset(R.ASSETS_ICONS_SHOP_CAR_PNG,
            height: 40.w, width: 40.w),
      ),
      Padding(
        padding: const EdgeInsets.only( left: 12),
        child: GestureDetector(
          onTap: () {
            //Get.to(() => BeeSearch()); 订单
          },
          child: Image.asset(R.ASSETS_ICONS_SHOP_ORDER_PNG,
              height: 40.w, width: 40.w),
        ),
      ),
    ];
  }

  Widget _buildTitle() {
    final appProvider = Provider.of<AppProvider>(context);
    double iconSize = 18.w;
    MaterialButton ges = MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 74.w,
        shape: StadiumBorder(),
        elevation: 0,
        minWidth: double.infinity,
        color: Colors.white,
        onPressed: () {
          Get.to(() => BeeSearch());
        },
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 32.w,
              color: Color(0xFF666666),
            ),
            10.wb,
            '请输入关键字'.text.size(28.sp).color(ktextSubColor).make().expand(),
          ],
        ),
      );

    return Container(
      height: kToolbarHeight,
      // child: ges,
      //color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Container(
            height: 40.w,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (appProvider.location != null)
                        Padding(
                          padding:EdgeInsets.only(right: 5.w),
                          child: Image.asset(
                            R.ASSETS_ICONS_SHOP_LOCATION_PNG,
                            width: 48.w,
                            height: 48.w,
                            //color: Colors.white,
                          ),
                        ),
                      Text(
                        appProvider.location?['city']==null?'':appProvider.location?['city'] as String? ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28.sp,
                          color: Colors.white,
                        ),
                        //textAlign: TextAlign.center,
                      ),
                    ]),
                // Expanded(
                //   child: ges,
                // )
              ],
            ),
            // child: ges,
          ),

          // 20.hb,
          //ges,
        ],
      ),
    );
  }

  FlexibleSpaceBar _flexibleSpaceBar(context) {

    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Container(
        //头部整个背景颜色
          height: double.infinity,
          color:  Color(0xFFF9F9F9),
          // color: Colors.white,
          child: Stack(
            children: <Widget>[
              AnimatedHomeBackground(
                key: _animatedBackgroundState,
                height: 530.w,
                backgroundColor: Colors.white ,
              ),
              Column(
                children: <Widget>[
                  // Container(
                  //   color: Colors.blue,
                  //   width: 300,
                  //   height: 300,
                  // ),


                  // HomeWeatherWidget(
                  //   backgroundColor: Colors.white.withAlpha(0),
                  //   homeWeatherModel: _homeWeatherModel,
                  // ),
                  // _bannerView(),
                  // _buildGoodsCards(),
                  // kingCoinListModelList != null
                  //     ? _buttonTitle(context)
                  //     : SizedBox(),
                  // _activityImageTitle(),
                  // _activityImageRow(),
                  // _activityT4Image(),
                  // HomeCountdownWidget(
                  //   height: timeHeight,
                  //   controller: _homeCountdownController,
                  //   promotionList: _promotionList,
                  // ),

                ],
              ),
            ],
          )),
    );
  }











  _goodsTitle(){
    return Container(
      height: 90.w,
      alignment: Alignment.centerLeft,
      color:  Color(0xFFF9F9F9),
      width: MediaQuery.of(context).size.width,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60.w,
        child: TabBar(
            onTap: (index) {
              // _presenter.fetchList(_category.id, 0, _sortType);
              setState(() {});
            },
            isScrollable: true,
            labelPadding: EdgeInsets.zero,
            controller: _tabController,
            labelColor: Color(0xFFF9F9F9),
            indicatorPadding: EdgeInsets.symmetric(horizontal: 40.w),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black54,
            labelStyle: TextStyle(color: Colors.black54),
            indicatorColor: Color(0xFFE52E2E),
            tabs: _tabItems()),
      ),
    );
  }
  List<Widget> _tabItems() {
    return [_tabItem(0,'综合推荐'),_tabItem(1,'销量'),_tabItem(2,'价格')];
  }

  _tabItem(int index,String text) {
    bool isChoose = index == _tabController.index;
    // Color textColor = index == _tabController.index
    //     ? getCurrentThemeColor()
    //     : Colors.black.withOpacity(0.9);
    return Tab(
      child: Container(
        alignment: Alignment.center,
        width: 150.w,
        // color: Colors.white,
        color: Color(0xFFF9F9F9),
       padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  fontWeight: isChoose?FontWeight.bold:FontWeight.normal,
                  fontSize: isChoose?32.sp:28.sp,
                  color: isChoose?Color(0xFF000000):Color(0xFF666666)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
