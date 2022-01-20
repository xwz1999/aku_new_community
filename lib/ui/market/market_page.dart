// import 'package:aku_new_community/base/base_style.dart';

import 'dart:ui' as ui;

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/model/good/market_swiper_model.dart';
import 'package:aku_new_community/models/market/goods_popular_model.dart';
import 'package:aku_new_community/models/market/market_all_category_model.dart';
import 'package:aku_new_community/models/market/market_category_model.dart';
import 'package:aku_new_community/models/market/market_statistics_model.dart';
import 'package:aku_new_community/models/market/order/goods_home_model.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/community/community_func.dart';
import 'package:aku_new_community/ui/market/integral/integral_exchange_page.dart';
import 'package:aku_new_community/ui/market/integral/integral_sku_model.dart';
import 'package:aku_new_community/ui/market/search/good_detail_page.dart';
import 'package:aku_new_community/ui/market/search/search_goods_page.dart';
import 'package:aku_new_community/ui/market/shop_car/shop_car_page.dart';
import 'package:aku_new_community/ui/market/widget/animated_home_background.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/home/home_sliver_app_bar.dart';
import 'package:aku_new_community/widget/others/rectIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'category/new_category_page.dart';
import 'market_home_goods_card.dart';
import 'order/order_page.dart';

class MarketPage extends StatefulWidget {
  MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late EasyRefreshController _refreshController;
  late ScrollController _sliverListController;
  late ScrollController _horListController;
  GlobalKey<HomeSliverAppBarState> _sliverAppBarGlobalKey = GlobalKey();
  GlobalKey<AnimatedHomeBackgroundState> _animatedBackgroundState = GlobalKey();
  int _pageNum = 1;
  int _size = 10;
  int _pageCount = 0;
  double MessageHeight = 76.w;
  double bannerHeight = 354.w;
  double buttonsHeight = 334.w;
  double searchHeight = 74.w;
  MarketStatisticsModel? _statistics;

  double tabBarHeight = 40.w;
  late TabController _tabController;
  List<MarketSwiperModel> _marketSwiperModels = [];

  List<MarketAllCategoryModel> _categoryModels = [];

  OrderType _orderType = OrderType.NORMAL;
  String priceIcon = R.ASSETS_ICONS_ICON_PRICE_NORMAL_PNG;

  List<MarketCategoryModel> _goodsClassificationList = [];

  List<GoodsHomeModel> _goodsHomeModelList = [];

  List<GoodsPopularModel> _goodsPopularModelList = [];

  List<IntegralSkuModel> get _integralModelList => IntegralSkuModel.examples;

  int? orderBySalesVolume;
  int? orderByPrice;

  Future updateMarketInfo() async {
    _pageNum = 1;
    BaseListModel baseListModel = await NetUtil().getList(
      SARSAPI.market.good.recommend,
      params: {
        'pageNum': _pageNum,
        'size': _size,
        'orderBySalesVolume': orderBySalesVolume,
        'orderByPrice': orderByPrice,
      },
    );
    if (baseListModel.tableList!.isNotEmpty) {
      _goodsHomeModelList = (baseListModel.tableList as List)
          .map((e) => GoodsHomeModel.fromJson(e))
          .toList();
    }
    _pageCount = baseListModel.pageCount!;
  }

  Future loadMarketInfo() async {
    BaseListModel baseListModel = await NetUtil().getList(
      SARSAPI.market.good.recommend,
      params: {
        'pageNum': _pageNum,
        'size': _size,
        'orderBySalesVolume': orderBySalesVolume,
        'orderByPrice': orderByPrice,
      },
    );
    if (baseListModel.tableList!.isNotEmpty) {
      _goodsHomeModelList.addAll((baseListModel.tableList as List)
          .map((e) => GoodsHomeModel.fromJson(e))
          .toList());
    }
    _pageCount = baseListModel.pageCount!;
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _goodsClassificationList
          .add(MarketCategoryModel(id: 0, name: '', imgUrls: []));
    }
    for (int i = 0; i < 6; i++) {
      _goodsPopularModelList.add(
          GoodsPopularModel(id: 0, skuName: '', mainPhoto: '', viewsNum: 0));
    }
    _sliverListController = ScrollController();
    _horListController = ScrollController();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    _refreshController = EasyRefreshController();

    ///动态appbar导致 refresh组件刷新判出现问题 首次刷新手动触发
    Future.delayed(Duration(milliseconds: 0), () async {
      await _refresh();
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

    return Scaffold(
      body: EasyRefresh.custom(
        firstRefresh: false,
        enableControlFinishLoad: false,
        header: BallPulseHeader(
            backgroundColor: Colors.red.withOpacity(0.8), color: Colors.white),
        footer: MaterialFooter(),
        topBouncing: false,
        scrollController: _sliverListController,
        controller: _refreshController,
        onRefresh: () async {
          _refresh();
        },
        onLoad: () async {
          _pageNum++;
          await loadMarketInfo();
          if (_pageCount <= _pageNum) {
            _refreshController.finishLoad(noMore: false);
          }
          setState(() {});
        },
        slivers: _buildBody(context),
      ),
    );
  }

  _refresh() async {
    await updateMarketInfo();
    //_swiperModels = await CommunityFunc.swiper();
    _marketSwiperModels = await CommunityFunc.marketSwiper();
    _statistics = await CommunityFunc.getMarketStatistics();

    _categoryModels = await CommunityFunc.getCategory();

    var list = await CommunityFunc.getGoodsClassificationList(0); //0获取根目录下的分类

    _goodsClassificationList.replaceRange(0, list.length, list);

    _goodsPopularModelList = await CommunityFunc.getGoodsPopularModel(6);

    setState(() {});
  }

  List<Widget> _buildBody(BuildContext context) {
    final normalTypeButton = MaterialButton(
      onPressed: () async {
        _orderType = OrderType.NORMAL;
        priceIcon = R.ASSETS_ICONS_ICON_PRICE_NORMAL_PNG;
        orderBySalesVolume = null;
        orderByPrice = null;
        await updateMarketInfo();
        setState(() {});
      },
      child: Text(
        '综合',
        style: TextStyle(
          color: _orderType == OrderType.NORMAL ? kBalckSubColor : ktextPrimary,
          fontSize: _orderType == OrderType.NORMAL ? 32.sp : 28.sp,
          fontWeight: _orderType == OrderType.NORMAL
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    final salesTypeButton = MaterialButton(
      onPressed: () async {
        _orderType = OrderType.SALES;
        orderBySalesVolume = 2;
        orderByPrice = null;
        priceIcon = R.ASSETS_ICONS_ICON_PRICE_NORMAL_PNG;
        await updateMarketInfo();
        setState(() {});
      },
      child: Text(
        '销量',
        style: TextStyle(
          color: _orderType == OrderType.SALES ? kBalckSubColor : ktextPrimary,
          fontSize: _orderType == OrderType.SALES ? 32.sp : 28.sp,
          fontWeight: _orderType == OrderType.SALES
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final priceButton = MaterialButton(
      onPressed: () async {
        switch (_orderType) {
          case OrderType.NORMAL:
          case OrderType.SALES:
            _orderType = OrderType.PRICE_HIGH;
            orderByPrice = 1;
            orderBySalesVolume = null;
            priceIcon = R.ASSETS_ICONS_ICON_PRICE_TOP_PNG;
            break;
          case OrderType.PRICE_HIGH:
            _orderType = OrderType.PRICE_LOW;
            orderByPrice = 2;
            orderBySalesVolume = null;
            priceIcon = R.ASSETS_ICONS_ICON_PRICE_BOTTOM_PNG;
            break;
          case OrderType.PRICE_LOW:
            _orderType = OrderType.PRICE_HIGH;
            orderByPrice = 1;
            orderBySalesVolume = null;
            priceIcon = R.ASSETS_ICONS_ICON_PRICE_TOP_PNG;
            break;
        }
        await updateMarketInfo();
        setState(() {});
      },
      child: Row(
        children: [
          Text(
            '价格',
            style: TextStyle(
              color: _orderType == OrderType.PRICE_HIGH ||
                      _orderType == OrderType.PRICE_LOW
                  ? kBalckSubColor
                  : ktextPrimary,
              fontSize: _orderType == OrderType.PRICE_HIGH ||
                      _orderType == OrderType.PRICE_LOW
                  ? 32.sp
                  : 28.sp,
              fontWeight: _orderType == OrderType.PRICE_HIGH ||
                      _orderType == OrderType.PRICE_LOW
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          Image.asset(
            priceIcon,
            width: 32.w,
            height: 32.w,
          )
        ],
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    return <Widget>[
      HomeSliverAppBar(
          key: _sliverAppBarGlobalKey,
          actions: _actionsWidget(),
          title: _buildTitle(),
          backgroundColor: Colors.red,
          expandedHeight: MessageHeight +
              bannerHeight +
              buttonsHeight +
              searchHeight +
              tabBarHeight +
              ScreenUtil().statusBarHeight +
              kToolbarHeight +
              280.w +
              172 * 2.w,
          flexibleSpace: _flexibleSpaceBar(context),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(tabBarHeight),
              child: _goodsTitle(
                normalTypeButton,
                salesTypeButton,
                priceButton,
              ))),
      SliverPadding(
        padding: EdgeInsets.all(10.w),
      ),
      SliverPadding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        sliver: buildSliverGrid(),
      ),
    ];
  }

  SliverGrid buildSliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.w,
        crossAxisSpacing: 20.w,
        childAspectRatio: 0.57,
      ),

      ///子Item构建器
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          ///每一个子Item的样式
          return MarketHomeGoodsCard(item: _goodsHomeModelList[index]);
          // return Container(
          //   width: 200.w,
          //     height: 200.w,
          //   color: Colors.blue,
          // );
        },

        ///子Item的个数
        childCount: _goodsHomeModelList.length,
      ),
    );
  }

  _actionsWidget() {
    return <Widget>[
      GestureDetector(
        onTap: () {
          Get.to(() => ShopCarPage()); // 购物车
        },
        child:
            Image.asset(R.ASSETS_ICONS_SHOP_CAR_PNG, height: 40.w, width: 40.w),
      ),
      Padding(
        padding: EdgeInsets.only(left: 32.w, right: 32.w),
        child: GestureDetector(
          onTap: () {
            Get.to(() => OrderPage(
                  initIndex: 0,
                ));
          },
          child: Image.asset(R.ASSETS_ICONS_SHOP_ORDER_PNG,
              height: 40.w, width: 40.w),
        ),
      ),
    ];
  }

  Widget _buildTitle() {
    final appProvider = Provider.of<AppProvider>(context);

    return Container(
      height: kToolbarHeight,
      // child: ges,
      //color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40.w,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  if (appProvider.location != null)
                    Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 5.w),
                      child: Image.asset(
                        R.ASSETS_ICONS_SHOP_LOCATION_PNG,
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.fitHeight,
                        //color: Colors.white,
                      ),
                    ),
                  Text(
                    appProvider.location?['city'] == null
                        ? ''
                        : appProvider.location?['city'] as String? ?? '',
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
          color: Color(0xFFF9F9F9),
          // color: Colors.white,
          child: Stack(
            children: <Widget>[
              AnimatedHomeBackground(
                key: _animatedBackgroundState,
                height: 530.w,
                backgroundColor: Colors.white,
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: ScreenUtil().statusBarHeight + kToolbarHeight,
                  ),
                  geSearch(),
                  20.hb,
                  getNum(),
                  20.hb,
                  HomeSwiper(),
                  20.hb,
                  _buttonTitle(),
                  20.hb,
                  _recommend(),
                  20.hb,
                  _integralMarket(),
                ],
              ),
            ],
          )),
    );
  }

//积分商城
  Widget _integralMarket() {
    return Container(
      width: 720.w,
      height: 172 * 2.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.w),
      ),
      child: Column(
        children: [
          Row(
            children: [
              '积分商城'.richText.size(28.sp).italic.bold.black.make(),
              8.wb,
              Text(
                '限时兑换',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    foreground: Paint()
                      ..shader = ui.Gradient.linear(
                          Offset(150, 690), Offset(150, 695), [
                        Color(0xFFF94B4B),
                        Color(0xFFF7B86F),
                      ])),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => IntegralExchangePage());
                },
                child: Row(
                  children: [
                    '查看更多'
                        .text
                        .size(24.sp)
                        .color(Colors.black.withOpacity(0.45))
                        .make(),
                    4.wb,
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 20.w,
                      color: Colors.black.withOpacity(0.45),
                    )
                  ],
                ),
              )
            ],
          ),
          18.hb,
          Flexible(
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                controller: _horListController,
                itemBuilder: (context, index) {
                  return _horizontalListCard(_integralModelList[index]);
                },
                separatorBuilder: (_, __) {
                  return 24.wb;
                },
                itemCount: 4),
          ),
        ],
      ),
    );
  }

  Widget _horizontalListCard(IntegralSkuModel model) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 148.w,
        child: Column(
          children: [
            Image.network(
              model.imgPath,
              width: 148.w,
              height: 148.w,
            ),
            '${model.skuName}'
                .text
                .size(24.sp)
                .color(Colors.black.withOpacity(0.65))
                .maxLines(2)
                .overflow(TextOverflow.ellipsis)
                .make(),
            10.hb,
            Row(
              children: [
                Assets.icons.intergral.image(width: 24.w, height: 24.w),
                4.wb,
                '${model.integral}'.text.size(24.sp).color(Colors.red).make()
              ],
            )
          ],
        ),
      ),
    );
  }

  geSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 74.w,
        shape: StadiumBorder(),
        elevation: 0,
        minWidth: double.infinity,
        color: Color(0xFFF3F3F3),
        onPressed: () {
          Get.to(() => SearchGoodsPage());
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
      ),
    );
  }

  getNum() {
    return Container(
      margin: EdgeInsets.only(left: 18.w, right: 18.w),
      padding: EdgeInsets.only(right: 8.w),
      height: 76.w,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(12),
          left: Radius.circular(12),
        ),
        gradient: LinearGradient(
          begin: FractionalOffset.centerRight,
          end: FractionalOffset.centerLeft,
          colors: <Color>[Color(0xFFAD2222), Color(0xFFCD392B)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              bottom: 5,
              right: 0,
              top: 5,
              child: Container(
                padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                alignment: Alignment.center,
                height: 61.w,
                width: 694.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFDEEBF),
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(12), left: Radius.circular(12)),
                ),
                child: Container(
                  height: 50.w,
                  width: 682.w,
                  decoration: BoxDecoration(
                    //color: Color(0x99F5AF16),
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(12), left: Radius.circular(12)),
                    border: Border.all(width: 2.w, color: Color(0x99F5AF16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      80.wb,
                      Image.asset(
                        R.ASSETS_ICONS_SHOP_LABA_PNG,
                        width: 36.w,
                        height: 34.w,
                      ),
                      20.wb,
                      Text(
                        '今日上新${_statistics?.newProductsTodayNum ?? 0}件',
                        style: TextStyle(
                            color: Color(0xFFD0564B),
                            fontSize: 24.sp,
                            height: 1.05),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              left: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.only(left: 10.w),
                height: 76.w,
                width: 258.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                      colors: <Color>[Color(0xFFAD2222), Color(0xFFCD392B)],
                    ),
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(50), left: Radius.circular(24))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SKU总数：${_statistics?.skuTotal ?? 0}',
                      style: TextStyle(color: Colors.white, fontSize: 24.sp),
                    ),
                    Text(
                      '入驻品牌数：${_statistics?.settledBrandsNum ?? 0}',
                      style: TextStyle(color: Colors.white, fontSize: 24.sp),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget HomeSwiper() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: bannerHeight,
      child: AspectRatio(
        aspectRatio: 355 / 177,
        child: Swiper(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            return getSwiperImage(_marketSwiperModels[index]);
          },

          pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              builder: SwiperCustomPagination(
                  builder: (BuildContext context, SwiperPluginConfig config) {
                return RectIndicator(
                  position: config.activeIndex,
                  count: _marketSwiperModels.length,
                  activeColor: Color(0x99FFFFFF),
                  color: Color(0xD9FFFFFF),
                  //未选中 指示器颜色，选中的颜色key为Color
                  width: 4,
                  //指示器宽度
                  activeWidth: 14,
                  //选中的指示器宽度
                  radius: 4,
                  //指示器圆角角度
                  height: 4,
                ); //指示器高度
              })),
          scrollDirection: Axis.horizontal,
          // control: new SwiperControl(),
          autoplay: true,
          onTap: (index) {
            if (_marketSwiperModels[index].jcookGoodsId != null) {
              Get.to(
                () => GoodDetailPage(
                    goodId: _marketSwiperModels[index].jcookGoodsId!),
              );
            }
          },
          itemCount: _marketSwiperModels.length,
        ),
      ),
    );
  }

  Widget getSwiperImage(MarketSwiperModel swiperModel) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
      ),
      child: FadeInImage.assetNetwork(
        placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
        image: API.image(swiperModel.imgList!.isNotEmpty
            ? swiperModel.imgList!.first.url
            : ''),
        fit: BoxFit.fill,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }

  _buttonTitle() {
    Container titles = Container(
      key: UniqueKey(),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (context, index) {
          if (index == 9) {
            return _buildAllTile();
          } else {
            return _buildTile(_goodsClassificationList[index], index);
          }
        },
        itemCount: 10,
        shrinkWrap: true,
      ),
    );
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      height: buttonsHeight,
      width: MediaQuery.of(context).size.width,
      child: titles,
    );
  }

  _buildTile(MarketCategoryModel item, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewCategoryPage(
              models: _categoryModels,
              index: index,
            ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInImage.assetNetwork(
            placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            width: 88.w,
            height: 88.w,
            image: item.imgUrls.isNotEmpty ? item.imgUrls.first : '',
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                height: 88.w,
                width: 88.w,
              );
            },
          ),
          8.hb,
          Text(
            (item.name ?? '').replaceAll('、', ''),
            style: TextStyle(fontSize: 28.sp, color: ktextPrimary),
          )
        ],
      ),
    );
  }

  _buildAllTile() {
    return GestureDetector(
      onTap: () async {
        Get.to(() => NewCategoryPage(
              models: _categoryModels,
              index: 0,
            ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            R.ASSETS_ICONS_TEST_KINGCION_PNG,
            height: 88.w,
            width: 88.w,
          ),
          8.hb,
          Text(
            '全部分类',
            style: TextStyle(fontSize: 28.sp, color: ktextPrimary),
          )
        ],
      ),
    );
  }

  Widget getkingCoin() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
      width: double.infinity,
      height: buttonsHeight,
      child: _buttonTitleRow(),
    );
  }

  _buttonTitleRow({onPressed}) {
    return Expanded(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Container(
              width: 88.w,
              height: 88.w,
              child: Image.asset(
                R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                width: 88.w,
                height: 88.w,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6.w),
              child: Text(
                '数码产品',
                style: TextStyle(fontSize: 28.sp, color: Color(0xFF333333)),
              ),
            )
          ],
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
      ),
    );
  }

  _recommend() {
    return Container(
        height: 184.w,
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        padding: EdgeInsets.only(top: 8.w, left: 16.w, right: 16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '爆款推荐',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                      color: ktextPrimary),
                ),
              ],
            ),
            GridView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => GoodDetailPage(
                              goodId: _goodsPopularModelList[index].id!),
                        );
                      },
                      child: Container(
                        width: 96.w,
                        height: 96.w,
                        key: UniqueKey(),
                        child: FadeInImage.assetNetwork(
                          placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                          image: _goodsPopularModelList.isEmpty
                              ? ''
                              : _goodsPopularModelList[index].mainPhoto ?? '',
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                              height: 96.w,
                              width: 96.w,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: 6,
              shrinkWrap: true,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ..._goodsPopularModelList.map((e) => Row(
            //       children: [
            //         Container(
            //           width: 96.w,
            //           height: 96.w,
            //           child:FadeInImage.assetNetwork(
            //             placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            //             image: e.mainPhoto??'',
            //             imageErrorBuilder: (context, error, stackTrace) {
            //               return Image.asset(R.ASSETS_IMAGES_PLACEHOLDER_WEBP,height: 96.w,
            //                 width: 96.w,);
            //             },
            //           ),
            //         ),
            //         20.wb,
            //       ],
            //     ),)
            //   ],
            // ).expand(),
          ],
        ));
  }

  _goodsTitle(
    Widget normalTypeButton,
    Widget salesTypeButton,
    Widget priceButton,
  ) {
    return Container(
      height: 90.w,
      alignment: Alignment.centerLeft,
      color: Color(0xFFF9F9F9),
      width: MediaQuery.of(context).size.width,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60.w,
        child: Row(
          children: [
            normalTypeButton,
            salesTypeButton,
            priceButton,
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
