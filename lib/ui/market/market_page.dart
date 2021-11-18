// import 'package:aku_community/base/base_style.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/model/community/swiper_model.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/ui/community/community_func.dart';
import 'package:aku_community/ui/home/public_infomation/public_information_detail_page.dart';
import 'package:aku_community/ui/market/widget/animated_home_background.dart';
import 'package:aku_community/ui/search/bee_search.dart';
import 'package:aku_community/widget/home/home_sliver_app_bar.dart';
import 'package:aku_community/widget/others/rectIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
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
  double MessageHeight = 76.w;
  double bannerHeight = 354.w;
  double buttonsHeight = 334.w;
  double searchHeight = 74.w;

  double tabBarHeight = 60.w;
  late TabController _tabController;

  List<SwiperModel> _swiperModels = [];

  OrderType _orderType = OrderType.NORMAL;
  IconData priceIcon = CupertinoIcons.chevron_up_chevron_down;

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

    return Scaffold(
      body:EasyRefresh(
        firstRefresh: true,
        enableControlFinishLoad: false,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        controller: _refreshController,
        onRefresh: () async {
          _pageNum = 1;
          await updateMarketInfo();
          _swiperModels = await CommunityFunc.swiper();
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
    final normalTypeButton = MaterialButton(
      onPressed: () {
        _orderType = OrderType.NORMAL;
        priceIcon = CupertinoIcons.chevron_up_chevron_down;
        setState(() {});
      },
      child: Text(
        '综合',
        style: TextStyle(
          color:
          _orderType == OrderType.NORMAL ? kBalckSubColor : ktextPrimary,
          fontSize: _orderType == OrderType.NORMAL ? 32.sp : 28.sp,
          fontWeight: _orderType == OrderType.NORMAL
              ?FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    final salesTypeButton = MaterialButton(
      onPressed: () {
        _orderType = OrderType.SALES;
        priceIcon = CupertinoIcons.chevron_up_chevron_down;
        setState(() {});
      },
      child: Text(
        '销量',
        style: TextStyle(
          color:
          _orderType == OrderType.SALES ? kBalckSubColor : ktextPrimary,
          fontSize: _orderType == OrderType.SALES ? 32.sp : 28.sp,
          fontWeight: _orderType == OrderType.SALES
              ?FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final priceButton = MaterialButton(
      onPressed: () {
        switch (_orderType) {
          case OrderType.NORMAL:
          case OrderType.SALES:
            _orderType = OrderType.PRICE_HIGH;
            priceIcon = CupertinoIcons.chevron_up;
            break;
          case OrderType.PRICE_HIGH:
            _orderType = OrderType.PRICE_LOW;
            priceIcon = CupertinoIcons.chevron_down;
            break;
          case OrderType.PRICE_LOW:
            _orderType = OrderType.PRICE_HIGH;
            priceIcon = CupertinoIcons.chevron_up;
            break;
        }
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
                  ?FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          Icon(
            priceIcon,
            size: 32.w,
            color: _orderType == OrderType.PRICE_HIGH ||
                _orderType == OrderType.PRICE_LOW
                ? kBalckSubColor
                : ktextPrimary,
          ),
        ],
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    return CustomScrollView(
      controller: _sliverListController,
      slivers: <Widget>[
        HomeSliverAppBar(
            key: _sliverAppBarGlobalKey,
            actions: _actionsWidget(),
            title: _buildTitle(),
            backgroundColor: Colors.red,
            expandedHeight:  MessageHeight+
                             bannerHeight +
                             buttonsHeight+
                             searchHeight +tabBarHeight+ScreenUtil().statusBarHeight +kToolbarHeight+280.w,
            flexibleSpace: _flexibleSpaceBar(context),

            bottom:  PreferredSize(
              preferredSize: Size.fromHeight(tabBarHeight),
              child: _goodsTitle( normalTypeButton, salesTypeButton, priceButton,)
            )),
        SliverPadding(
          padding: EdgeInsets.all(10.w),
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 20.w,right: 20.w),
          sliver: buildSliverGrid(),
        ),

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
            childAspectRatio:0.57,
      ),

      ///子Item构建器
      delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {

          ///每一个子Item的样式
              return GoodsCard(item:  _hotItems[index]);
              // return Container(
              //   width: 200.w,
              //     height: 200.w,
              //   color: Colors.blue,
              // );
        },
        ///子Item的个数
        childCount: _hotItems.length,
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
                          padding:EdgeInsets.only(right: 5.w,top: 5.w),
                          child: Image.asset(
                            R.ASSETS_ICONS_SHOP_LOCATION_PNG,
                            width: 40.w,
                            height: 40.w,
                            fit: BoxFit.fitHeight,
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
                  Container(
                    height: ScreenUtil().statusBarHeight +kToolbarHeight,
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

                ],
              ),
            ],
          )),
    );
  }


  geSearch(){
   return  Container(
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

  getNum(){
    return Container(
      margin: EdgeInsets.only(left: 18.w,right: 18.w),
      padding: EdgeInsets.only(right:8.w ),
      height: 76.w,
      width: double.infinity,
      alignment: Alignment.center,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(12),left:Radius.circular(12), ),
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
                padding: EdgeInsets.only(top: 5.w,bottom: 5.w),
                alignment: Alignment.center,
                height: 61.w,
                width: 694.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFDEEBF),
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(12),left:Radius.circular(12) ),

                ),
                child: Container(
                  height: 50.w,
                  width: 682.w,
                  decoration: BoxDecoration(
                    //color: Color(0x99F5AF16),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(12),left:Radius.circular(12)),
                    border: Border.all(width: 2.w,color: Color(0x99F5AF16)),

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      80.wb,
                      Image.asset(R.ASSETS_ICONS_SHOP_LABA_PNG,width: 36.w,height: 34.w,),
                      20.wb,
                      Text('今日上新1231件',style: TextStyle(color: Color(0xFFD0564B),fontSize: 24.sp,height: 1.05),),
                    ],
                  ),
                ),
              )

          ),
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
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(50),left: Radius.circular(24))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SKU总数：237809',style: TextStyle(color: Colors.white,fontSize: 24.sp),),
                    Text('入驻品牌数：237809',style: TextStyle(color: Colors.white,fontSize: 24.sp),)
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
            return getSwiperImage(_swiperModels[index]);
          },

          pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              builder: SwiperCustomPagination(
                  builder: (BuildContext context, SwiperPluginConfig config) {
                    return RectIndicator(
                      position: config.activeIndex,
                      count: _swiperModels.length,
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
            Get.to(() =>
                PublicInformationDetailPage(id: _swiperModels[index].newsId!));
          },
          itemCount: _swiperModels.length,
        ),
      ),
    );
  }

  Widget getSwiperImage(SwiperModel swiperModel) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
      ),
      child:
      FadeInImage.assetNetwork(
        placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
        image: API.image(ImgModel.first(swiperModel.voResourcesImgList)),
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
      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child:

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buttonTitleRow(

                    ),
                    _buttonTitleRow(

                    ),
                    _buttonTitleRow(

                    ),
                    _buttonTitleRow(

                    ),
                    _buttonTitleRow(

                    ),



                  ],
                ),
              ),
            ],
          ),
          28.hb,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buttonTitleRow(

                    ),
                    _buttonTitleRow(

                    ),
                    _buttonTitleRow(

                    ),
                    _buttonTitleRow(

                    ),
                    _buttonTitleRow(

                    ),



                  ],
                ),
              ),
            ],
          ),
        ],
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

  Widget getkingCoin() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
      width: double.infinity,
      height: buttonsHeight,
      child:_buttonTitleRow(),
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
                child: Image.asset(R.ASSETS_IMAGES_PLACEHOLDER_WEBP,width: 88.w,height: 88.w,),
                // FadeInImage.assetNetwork(
                //   placeholder:  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                //   image: Api.getImgUrl(kingCoin.url),)
            ),
            Container(
              margin: EdgeInsets.only(top: 6.w),
              child: Text(
                '数码产品',
                style: TextStyle(

                    fontSize: 28.sp,
                    color: Color(0xFF333333)),
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


  _recommend(){
    return Container(
        height: 184.w,
        margin: EdgeInsets.only(left: 20.w,right: 20.w),
        padding: EdgeInsets.only(top: 8.w,left: 16.w,right: 16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
    ),
    child:
    Column(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96.w,
              height: 96.w,
              child: Image.asset(R.ASSETS_IMAGES_PLACEHOLDER_WEBP,width: 96.w,height: 96.w,),
              // FadeInImage.assetNetwork(
              //   placeholder:  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              //   image: Api.getImgUrl(kingCoin.url),)
            ),
            20.wb,
            Container(
              width: 96.w,
              height: 96.w,
              child: Image.asset(R.ASSETS_IMAGES_PLACEHOLDER_WEBP,width: 96.w,height: 96.w,),
              // FadeInImage.assetNetwork(
              //   placeholder:  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              //   image: Api.getImgUrl(kingCoin.url),)
            ),
            20.wb,
            Container(
              width: 96.w,
              height: 96.w,
              child: Image.asset(R.ASSETS_IMAGES_PLACEHOLDER_WEBP,width: 96.w,height: 96.w,),
              // FadeInImage.assetNetwork(
              //   placeholder:  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              //   image: Api.getImgUrl(kingCoin.url),)
            ),
            20.wb,
            Container(
              width: 96.w,
              height: 96.w,
              child: Image.asset(R.ASSETS_IMAGES_PLACEHOLDER_WEBP,width: 96.w,height: 96.w,),
              // FadeInImage.assetNetwork(
              //   placeholder:  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              //   image: Api.getImgUrl(kingCoin.url),)
            ),
            20.wb,
            Container(
              width: 96.w,
              height: 96.w,
              child: Image.asset(R.ASSETS_IMAGES_PLACEHOLDER_WEBP,width: 96.w,height: 96.w,),
              // FadeInImage.assetNetwork(
              //   placeholder:  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              //   image: Api.getImgUrl(kingCoin.url),)
            ),
            20.wb,
            Container(
              width: 96.w,
              height: 96.w,
              child: Image.asset(R.ASSETS_IMAGES_PLACEHOLDER_WEBP,width: 96.w,height: 96.w,),
              // FadeInImage.assetNetwork(
              //   placeholder:  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              //   image: Api.getImgUrl(kingCoin.url),)
            ),
          ],
        ).expand(),
      ],
    )
    );
  }







  _goodsTitle(Widget normalTypeButton,Widget salesTypeButton,Widget priceButton,){
    return Container(
      height: 90.w,
      alignment: Alignment.centerLeft,
      color:  Color(0xFFF9F9F9),
      width: MediaQuery.of(context).size.width,
      child:
      Container(
        alignment: Alignment.centerLeft,
        height: 60.w,
        child:Row(
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
