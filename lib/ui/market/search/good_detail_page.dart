import 'dart:async';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/model/user/adress_model.dart';
import 'package:aku_new_community/models/market/good_detail_model.dart';
import 'package:aku_new_community/pages/personal/address/address_list_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/market/collection/collection_func.dart';
import 'package:aku_new_community/ui/market/search/search_func.dart';
import 'package:aku_new_community/ui/market/search/submit_order_page_normal.dart';
import 'package:aku_new_community/ui/market/shop_car/shop_car_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'good_detail_bottomSheet.dart';

class GoodDetailPage extends StatefulWidget {
  final int goodId;
  final bool integralGood;
  final int integral;

  GoodDetailPage({
    Key? key,
    required this.goodId,
    this.integral = 0,
    this.integralGood = false,
  }) : super(key: key);

  @override
  _GoodDetailPageState createState() => _GoodDetailPageState();
}

class _GoodDetailPageState extends State<GoodDetailPage> {
  late EasyRefreshController _refreshController;

  late PageController _pageController;
  int _currentIndex = 0;
  late GoodDetailModel? _goodDetail;
  bool _onload = true;
  late ScrollController _sliverListController;
  AddressModel? _addressModel;
  List _imageList = [];

  DateTime _deadline = DateTime(2022, 4, 17, 0, 0, 0, 0, 0).toUtc();

  int get days => _deadline.difference(DateTime.now().toUtc()).inDays;

  int get hours =>
      _deadline.difference(DateTime.now().toUtc()).inHours - days * 24;

  int get mins =>
      _deadline.difference(DateTime.now().toUtc()).inMinutes -
      days * 1440 -
      hours * 60;

  int get seconds => (_deadline.difference(DateTime.now().toUtc()).inSeconds -
      days * 86400 -
      hours * 3600 -
      mins * 60);

  Timer? _timer;

  @override
  void initState() {
    final appProvider = Provider.of<AppProvider>(Get.context!);
    super.initState();
    _pageController = PageController();
    _sliverListController = ScrollController();
    _refreshController = EasyRefreshController();
    if (appProvider.addressModel != null) {
      _addressModel = appProvider.addressModel!;
    } else {
      _addressModel = null;
    }
    if (widget.integralGood) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _pageController.dispose();
    _sliverListController.dispose();
    _timer?.cancel();
    _timer == null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '',
      titleSpacing: 0,
      bgColor: Color(0xFFF9F9F9),
      bodyColor: Color(0xFFF9F9F9),
      bottomNavi: _onload ? SizedBox() : _bottomButton(),
      body: Stack(
        children: [
          EasyRefresh(
              firstRefresh: true,
              header: MaterialHeader(),
              controller: _refreshController,
              onRefresh: () async {
                _goodDetail = await SearchFunc.getGoodDetail(widget.goodId);
                _imageList = await SearchFunc.getGoodDetailImage(widget.goodId);
                if (_goodDetail != GoodDetailModel.fail()) {
                  _onload = false;
                }
                setState(() {});
              },
              child: _onload ? SizedBox() : _buildBody(context)),
          Positioned(
            top: (kToolbarHeight + 16).w,
            left: 24.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(52.w)),
                        color: Color(0x80000000)),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        R.ASSETS_ICONS_ICON_BACK_PNG,
                        width: 52.w,
                        height: 52.w,
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _imageView(_goodDetail!.jcookImageVoList ?? []),
        widget.integralGood ? _integralExchange() : 20.hb,
        widget.integralGood ? _integralGoodInfo() : _goodInfo(),
        20.hb,
        _address(context),
        20.hb,
        _getDetailImage(),
      ],
    );
  }

  Widget _integralExchange() {
    return Container(
      width: double.infinity,
      height: 152.w,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.images.goodDetailIntegralBack.path))),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
      child: Row(
        children: [
          Assets.icons.intergral.image(width: 40.w, height: 40.w),
          8.w.widthBox,
          '${widget.integral}'.text.size(40.sp).color(Colors.white).make(),
          Spacer(),
          BeeDivider.vertical(
            indent: 20.w,
            endIndent: 20.w,
          ),
          24.wb,
          Column(
            children: [
              SizedBox(
                width: 272.w,
                child: Text(
                  '限时兑换',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              8.hb,
              Row(
                children: [
                  '距结束'.text.size(24.sp).color(Colors.white).make(),
                  16.wb,
                  _timerContainer(days),
                  8.wb,
                  '天'.text.size(24.sp).white.make(),
                  8.wb,
                  _timerContainer(hours),
                  8.wb,
                  ':'.text.white.size(24.sp).make(),
                  8.wb,
                  _timerContainer(mins),
                  8.wb,
                  ':'.text.white.size(24.sp).make(),
                  8.wb,
                  _timerContainer(seconds),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _timerContainer(int num) {
    return Container(
      width: 27.w,
      height: 27.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white.withOpacity(0.5)])),
      child: num.text.size(20.sp).color(Color(0xFFE52E2E)).make(),
    );
  }

  _integralGoodInfo() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      // height: 256.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 100.w,
            width: double.infinity,
            child: Text(
              (_goodDetail!.skuName),
              style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: ktextPrimary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _getIcon(_goodDetail!.kind),
          24.hb,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              16.wb,
              '原价：¥'.text.color(Color(0xFFBBBBBB)).size(24.sp).make(),
              Text(
                (_goodDetail!.sellPrice).toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 24.sp,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2,
                    decorationStyle: TextDecorationStyle.solid,
                    color: Color(0xFFBBBBBB)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _goodInfo() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 256.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              16.wb,
              '¥'.text.color(Color(0xFFE52E2E)).size(28.sp).make(),
              Text(
                (_goodDetail!.sellPrice).toStringAsFixed(2),
                style: TextStyle(fontSize: 40.sp, color: Color(0xFFE52E2E)),
              ),
              Spacer(),
              '已售：'.text.color(Color(0xFFBBBBBB)).size(24.sp).make(),
              Text(
                (_goodDetail!.sellNum ?? 0).toString(),
                style: TextStyle(fontSize: 24.sp, color: Color(0xFFBBBBBB)),
              ),
              16.wb,
            ],
          ),
          10.hb,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 80.w,
            width: double.infinity,
            child: Text(
              (_goodDetail!.skuName),
              style: TextStyle(fontSize: 28.sp, color: ktextPrimary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _getIcon(_goodDetail!.kind),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              16.wb,
              '原价：'.text.color(Color(0xFFBBBBBB)).size(24.sp).make(),
              Text(
                (_goodDetail!.discountPrice)?.toStringAsFixed(2) ?? '0.0',
                style: TextStyle(fontSize: 24.sp, color: Color(0xFFBBBBBB)),
              ),
              50.wb,
              '折扣：'.text.color(Color(0xFFBBBBBB)).size(24.sp).make(),
              Text(
                ((_goodDetail!.discountPrice) ?? 0.0) > (_goodDetail!.sellPrice)
                    ? _getDiscount(_goodDetail!.sellPrice.toDouble(),
                        _goodDetail!.discountPrice?.toDouble() ?? 0.0)
                    : '暂无折扣',
                style: TextStyle(fontSize: 24.sp, color: Color(0xFFBBBBBB)),
              ),
              16.wb,
            ],
          ),
        ],
      ),
    );
  }

  _address(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 184.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              //跳转到地址界面，点击地址然后返回地址
              var result = await Get.to(() => AddressListPage(
                    canBack: true,
                  ));
              if (result != null) {
                _addressModel = result;
              }
              setState(() {});
            },
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      16.wb,
                      '送至'.text.color(Color(0xFFBBBBBB)).size(28.sp).make(),
                      20.wb,
                      Image.asset(
                        R.ASSETS_ICONS_ICON_GOOD_LOCATION_PNG,
                        width: 30.w,
                        height: 30.w,
                      ),
                      Container(
                        width: 430.w,
                        child: Text(
                          _addressModel == null
                              ? '请先选择地址'
                              : (_addressModel!.locationName ?? '') +
                                  (_addressModel!.addressDetail ?? ''),
                          style:
                              TextStyle(fontSize: 24.sp, color: ktextPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        CupertinoIcons.chevron_forward,
                        size: 32.w,
                        color: Color(0xFF999999),
                      ),
                      16.wb,
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      120.wb,
                      _goodDetail!.stockStatus == 1
                          ? '有货'
                              .text
                              .color(Color(0xFFE52E2E))
                              .size(28.sp)
                              .make()
                          : '无货'
                              .text
                              .color(Color(0xFFE52E2E))
                              .size(28.sp)
                              .make(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          20.hb,
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return GoodDetailBottomSheet(goodDetail: _goodDetail!);
                  });
            },
            child: Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  16.wb,
                  '参数'.text.color(Color(0xFFBBBBBB)).size(28.sp).make(),
                  48.wb,
                  Text(
                    '品牌、规格',
                    style: TextStyle(fontSize: 24.sp, color: ktextPrimary),
                  ),
                  Spacer(),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    size: 32.w,
                    color: Color(0xFF999999),
                  ),
                  16.wb,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getDetailImage() {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
          color: Colors.white),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              16.wb,
              Container(
                width: 8.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: Color(0xFFE52E2E),
                  borderRadius: BorderRadius.all(Radius.circular(4.w)),
                ),
              ),
              2.wb,
              Text(
                '商品详情',
                style: TextStyle(fontSize: 28.sp, color: ktextPrimary),
              ),
              Spacer(),
            ],
          ),
          10.hb,
          ..._imageList.map((e) => _image(_getRightUrl(e) ?? ''))
        ],
      ),
    );
  }

  _image(String url) {
    print(url);
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onLongPress: () {
          //保存图片
        },
        child: FadeInImage.assetNetwork(
          placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
          image: 'https://' + url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  ///获取的地址//img30.360buyimg.com/sku/jfs/t1/144443/40/4086/433571/5f22204bEd3a409dc/3090e34cf8c4187c.jpg
  ///多两个斜杠
  _getRightUrl(String url) {
    return url.substring(2);
  }

  Widget _getIcon(int type) {
    if (type == 1) {
      return Container(
        margin: EdgeInsets.only(left: 15.w),
        width: 86.w,
        height: 26.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4.w),
          ),
          gradient: LinearGradient(
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            colors: <Color>[Color(0xFFEC5329), Color(0xFFF58123)],
          ),
        ),
        child: Text(
          '京东自营',
          style: TextStyle(fontSize: 18.sp, color: kForeGroundColor),
        ),
      );
    } else if (type == 2) {
      return Container(
        alignment: Alignment.center,
        width: 86.w,
        height: 30.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4.w),
          ),
          gradient: LinearGradient(
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            colors: <Color>[Color(0xFFF59B1C), Color(0xFFF5AF16)],
          ),
        ),
        child: Text(
          '京东POP',
          style: TextStyle(fontSize: 18.sp, color: kForeGroundColor),
        ),
      );
    } else
      return SizedBox();
  }

  _bottomButton() {
    return Container(
      width: double.infinity,
      height: 100.w,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color(0x4D000000),
            offset: Offset(0.0, -1), //阴影xy轴偏移量
            blurRadius: 0, //阴影模糊程度
            spreadRadius: 0 //阴影扩散程度
            )
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          40.wb,
          GestureDetector(
            onTap: () async {
              await CollectionFunc.collection(_goodDetail!.id);
              _refreshController.callRefresh();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  _goodDetail!.isCollection == 0
                      ? R.ASSETS_ICONS_ICON_GOOD_FAVOR_PNG
                      : R.ASSETS_ICONS_SHOP_FAVORFILL_PNG,
                  width: 48.w,
                  height: 48.w,
                ),
                Text(
                  '加入收藏',
                  style: TextStyle(fontSize: 20.sp, color: ktextPrimary),
                ),
              ],
            ),
          ),
          40.wb,
          GestureDetector(
            onTap: () async {
              //跳转到购物车界面
              Get.to(() => ShopCarPage());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  R.ASSETS_ICONS_ICON_GOOD_CAR_PNG,
                  width: 48.w,
                  height: 48.w,
                ),
                Text(
                  '购物车',
                  style: TextStyle(fontSize: 20.sp, color: ktextPrimary),
                ),
              ],
            ),
          ),
          40.wb,
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  await SearchFunc.addGoodsCar(_goodDetail!.id);
                },
                child: Container(
                  width: 230.w,
                  height: 84.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(84.w)),
                      border: Border.all(color: Color(0xFFE52E2E), width: 2.w)
                      // border: Border(top:BorderSide(color: Color(0xFFE52E2E),width: 2.w),
                      // left: BorderSide(color: Color(0xFFE52E2E),width: 2.w),bottom: BorderSide(color: Color(0xFFE52E2E),width: 2.w))
                      ),
                  alignment: Alignment.center,
                  child: Text(
                    '加入购物车',
                    style: TextStyle(fontSize: 32.sp, color: Color(0xFFE52E2E)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_goodDetail!.stockStatus == 0) {
                    BotToast.showText(text: '商品库存不足');
                  } else {
                    Get.to(() => SubmitOrderNormalPage(
                          goodModel: _goodDetail!,
                          integralGood: widget.integralGood,
                          integral: widget.integral,
                        ));
                  }
                },
                child: Container(
                  width: 230.w,
                  height: 84.w,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(84.w)),
                    color: Color(0xFFE52E2E),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '立即购买',
                    style: TextStyle(fontSize: 32.sp, color: Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _imageView(List<JcookImageVoList> imgList) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 725.w,
          child: PageView.builder(
              itemCount: imgList.length,
              onPageChanged: (value) {
                _pageController.jumpToPage(value);
                _currentIndex = value;
                setState(() {});
              },
              controller: _pageController,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  height: 725.w,
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                      image: imgList[index].url),
                );
              }),
        ),
        Positioned(
          bottom: 24.w,
          right: 5.w,
          child: Container(
            alignment: Alignment.center,
            width: 69.w,
            height: 39.w,
            decoration: BoxDecoration(
                color: Color(0x80000000),
                borderRadius: BorderRadius.circular(40.w)),
            child: '${_currentIndex + 1}/${imgList.length}'
                .text
                .size(24.sp)
                .color(Colors.white)
                .make(),
          ),
        ),
      ],
    );
  }

  _getDiscount(double sellPrice, double discountPrice) {
    String count = '';
    count = ((sellPrice / discountPrice) * 10).toStringAsFixed(1);

    return count + '折';
  }

  _getSpecifications() {}
}
