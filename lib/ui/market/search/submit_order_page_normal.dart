import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/model/good/good_detail_model.dart';
import 'package:aku_new_community/model/order/create_order_model.dart';
import 'package:aku_new_community/model/user/adress_model.dart';
import 'package:aku_new_community/pages/life_pay/pay_util.dart';
import 'package:aku_new_community/pages/personal/address/address_list_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/market/order/order_page.dart';
import 'package:aku_new_community/ui/market/search/settlementGoodsDTO.dart';
import 'package:aku_new_community/ui/market/shop_car/shop_car_func.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/end_button.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SubmitOrderNormalPage extends StatefulWidget {
  final GoodDetailModel goodModel;
  final bool integralGood;
  final int? integral;

  SubmitOrderNormalPage(
      {Key? key,
      required this.goodModel,
      this.integralGood = false,
      this.integral})
      : assert(!integralGood || integral != null),
        super(key: key);

  @override
  _SubmitOrderNormalPageState createState() => _SubmitOrderNormalPageState();
}

class _SubmitOrderNormalPageState extends State<SubmitOrderNormalPage> {
  late TextEditingController _controllers;
  List<SettlementGoodsDTO> _goodsList = [];
  AddressModel? _addressModel;
  CreateOrderModel? _createOrderModel;
  double _allPrice = 0;

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(Get.context!);
    _controllers = TextEditingController(text: '1');

    _goodsList
        .add(SettlementGoodsDTO(jcookGoodsId: widget.goodModel.id, num: 1));

    if (appProvider.addressModel != null) {
      _addressModel = appProvider.addressModel!;
      createOrder(_addressModel!.id!, _goodsList);
    } else {
      _addressModel = null;
    }
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  Future<bool> createOrder(
      int addressId, List<SettlementGoodsDTO> goodsList) async {
    BaseModel model = await NetUtil().post(
      API.market.shopCarSettlement,
      params: {
        'addressId': addressId,
        'settlementGoodsDTOList': goodsList.map((v) => v.toJson()).toList()
      },
    );
    if (model.data == null) {
      _createOrderModel = null;
      setState(() {});
      return false;
    } else {
      _createOrderModel = CreateOrderModel.fromJson(model.data);
      setState(() {});
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '????????????'.text.size(32.sp).black.bold.make(),
      titleSpacing: 0,
      body: ListView(
        children: [
          20.hb,
          _address(context),
          20.hb,
          _goodCard(widget.goodModel),
          20.hb,
          if (!widget.integralGood) _priceView(),
          20.hb,
          widget.integralGood ? _integralTile() : _payWay(),
          20.hb,
        ],
      ),
      bottomNavi: widget.integralGood ? _integralBottom() : _normalBottom(),
    );
  }

  Container _integralBottom() {
    return Container(
      width: double.infinity,
      height: 120.w,
      color: Colors.white,
      child: Row(
        children: [
          if (widget.integralGood)
            Row(
              children: [
                20.w.widthBox,
                '????????????:'.text.size(32.sp).color(Colors.black).bold.make(),
                24.w.widthBox,
                Assets.icons.intergral.image(width: 40.w, height: 40.w),
                8.w.widthBox,
                widget.integral
                    .toString()
                    .text
                    .size(28.sp)
                    .color(Colors.red)
                    .make(),
              ],
            ),
          Spacer(),
          EndButton(
              onPressed: () async {
                if (_addressModel == null) {
                  BotToast.showText(text: '??????????????????');
                }
                Function cancel = BotToast.showLoading();
                BaseModel baseModel = await NetUtil()
                    .post(API.pay.jcookOrderCreateByIntegral, params: {
                  "addressId": _addressModel!.id!,
                  "settlementGoodsDTOList":
                      _goodsList.map((v) => v.toJson()).toList(),
                  "payType": 10, //???????????? ??????????????????
                  "payPrice": _allPrice,
                  'points': widget.integral,
                });
                if (baseModel.status ?? false) {
                  Get.off(() => OrderPage(initIndex: 2));
                }
                cancel();
              },
              text: '????????????'.text.size(32.sp).color(Colors.white).make()),
          10.widthBox,
        ],
      ),
    );
  }

  Container _normalBottom() {
    return Container(
      width: double.infinity,
      height: 120.w,
      color: Colors.white,
      child: Row(
        children: [
          Spacer(),
          EndButton(
              onPressed: () async {
                if (_addressModel == null) {
                  BotToast.showText(text: '??????????????????');
                }
                Function cancel = BotToast.showLoading();
                BaseModel baseModel = await NetUtil()
                    .post(API.pay.jcookOrderCreateOrder, params: {
                  "addressId": _addressModel!.id!,
                  "settlementGoodsDTOList":
                      _goodsList.map((v) => v.toJson()).toList(),
                  "payType": 1, //???????????? ??????????????????
                  "payPrice": _allPrice
                });
                if (baseModel.status ?? false) {
                  bool result = await PayUtil().callAliPay(
                      baseModel.message!, API.pay.jcookOrderCheckAlipay);
                  if (result) {
                    Get.off(() => OrderPage(initIndex: 2));
                  } else {
                    ///?????????????????????
                    Get.off(() => OrderPage(initIndex: 1));
                  }
                }
                cancel();
              },
              text: '????????????'.text.size(32.sp).color(Colors.white).make()),
          10.widthBox,
        ],
      ),
    );
  }

  Widget _integralTile() {
    return Container(
      width: 710.w,
      height: 96.w,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24.w)),
      child: Row(
        children: [
          Assets.icons.intergral.image(width: 40.w, height: 40.w),
          8.w.widthBox,
          '????????????'.text.size(28.sp).color(Color(0xFF4F4F4F)).make(),
          Spacer(),
          (UserTool.userProvider.userDetailModel!.points ?? 0)
              .text
              .size(28.sp)
              .color(Colors.red)
              .make(),
        ],
      ),
    );
  }

  _address(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 20.w, bottom: 20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 182.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
          color: Colors.white),
      child: GestureDetector(
        onTap: () async {
          //??????????????????????????????????????????????????????
          var result = await Get.to(() => AddressListPage(
                canBack: true,
              ));
          if (result != null) {
            _addressModel = result;
            createOrder(_addressModel!.id!, _goodsList);
          } else {
            _addressModel = null;
          }
          setState(() {});
        },
        child: Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                R.ASSETS_ICONS_ICON_GOOD_LOCATION_PNG,
                width: 60.w,
                height: 60.w,
              ),
              _addressModel != null
                  ? Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 4.w),
                              child: SizedBox(
                                width: 518.w,
                                child: Text(
                                  _addressModel!.locationName ?? '',
                                  style: TextStyle(
                                      fontSize: 24.sp, color: ktextPrimary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 4.w),
                              child: SizedBox(
                                width: 518.w,
                                child: Text(
                                  (_addressModel!.addressDetail ?? ''),
                                  style: TextStyle(
                                      fontSize: 32.sp, color: ktextPrimary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 4.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(_addressModel!.name ?? '',
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          color: ktextPrimary)),
                                  30.wb,
                                  Text(_addressModel!.tel ?? '',
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          color: ktextPrimary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                      '??????????????????',
                      style: TextStyle(fontSize: 32.sp, color: ktextPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
              Spacer(),
              Icon(
                CupertinoIcons.chevron_forward,
                size: 40.w,
                color: Color(0xFF999999),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _priceView() {
    double allPrice = 0;
    int allNum = 0;
    double fee = 0;
    if (_createOrderModel != null) {
      fee = _createOrderModel!.fee ?? 0;
    }

    int num = int.parse(_controllers.text);
    print(num);
    allNum += num;
    allPrice += (widget.goodModel.sellPrice! * num);

    _allPrice = allPrice + fee;

    return Container(
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 20.w, bottom: 20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 200.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              '???${allNum}???'.text.size(28.sp).color(Color(0xFFBBBBBB)).make(),
              5.wb,
              '???????????????'.text.size(28.sp).color(Color(0xFF333333)).make(),
              '??${(allPrice).toStringAsFixed(2)}'
                  .text
                  .size(28.sp)
                  .color(Color(0xFF333333))
                  .make(),
              16.wb,
            ],
          ),
          16.hb,
          _createOrderModel != null
              ? Row(
                  children: [
                    Spacer(),
                    '?????????'.text.size(28.sp).color(Color(0xFF333333)).make(),
                    ('??${_createOrderModel!.fee}')
                        .text
                        .size(28.sp)
                        .color(Color(0xFF333333))
                        .make(),
                    16.wb,
                  ],
                )
              : SizedBox(),
          16.hb,
          Row(
            children: [
              Spacer(),
              '???????????????'.text.size(32.sp).color(Color(0xFF333333)).bold.make(),
              '??${allPrice + fee}'
                  .text
                  .size(32.sp)
                  .color(Color(0xFFE52E2E))
                  .bold
                  .make(),
              16.wb,
            ],
          )
        ],
      ),
    );
  }

  _payWay() {
    return Container(
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 20.w, bottom: 20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 72.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
          color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          '????????????'.text.size(28.sp).color(Color(0xFF333333)).make(),
          Spacer(),
          Image.asset(
            R.ASSETS_ICONS_ALIPAY_ROUND_PNG,
            width: 40.w,
            height: 40.w,
          ),
          16.wb,
          '?????????'.text.size(28.sp).color(Color(0xFF333333)).make(),
        ],
      ),
    );
  }

  Widget _goodCard(GoodDetailModel model) {
    var top = RichText(
      text: TextSpan(children: [
        WidgetSpan(
          child: _getKindWd(model.kind ?? 0),
        ),
        TextSpan(
            text: model.skuName,
            style: TextStyle(fontSize: 28.sp, color: ktextPrimary)),
      ]),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
    var mid = Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w), color: Color(0xFFF2F3F4)),
      child: '?????????${model.weight}kg/${model.unit}'
          .text
          .size(24.sp)
          .color(Color(0xFFBBBBBB))
          .make(),
    );
    var bottom = Column(
      children: [
        Row(
          children: [
            92.wb,
            '????????????'.text.size(28.sp).color(Color(0xFF333333)).make(),
            Spacer(),
            _getBottomSuffix(GoodStatus.onSell, model.id!)
          ],
        ),
        48.hb,
        Row(
          children: [
            92.wb,
            '????????????'.text.size(28.sp).color(Color(0xFF333333)).make(),
            Spacer(),
            '????????????'.text.size(28.sp).color(Color(0xFFBBBBBB)).make(),
            10.wb,
          ],
        ),
      ],
    );
    int num = int.parse(_controllers.text);
    var price = Row(
      children: [
        Spacer(),
        '???${_controllers.text}???'
            .text
            .size(28.sp)
            .color(Color(0xFFBBBBBB))
            .make(),
        5.wb,
        '???????????????'.text.size(28.sp).color(Color(0xFF333333)).make(),
        '??${(num * model.sellPrice!).toStringAsFixed(2)}'
            .text
            .size(28.sp)
            .color(Color(0xFF333333))
            .make(),
        16.wb,
      ],
    );
    return Container(
      alignment: Alignment.center,
      height: 500.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: 188.w,
                    height: 188.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                      image: model.goodsDetailImageVos![0].url ?? '',
                      height: 188.w,
                      width: 188.w,
                    ),
                  ),
                  Positioned(
                      child: Container(
                          height: 188.w,
                          width: 188.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w),
                          ),
                          child: _getGoodsStatusImg(model.goodStatus) ??
                              SizedBox()))
                ],
              ),
              20.wb,
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: top,
                      width: model.sellPrice! > 9999 ? 300.w : 320.w,
                      alignment: Alignment.topCenter,
                    ),

                    10.hb,
                    mid,
                    //Spacer(),

                    10.hb,
                  ],
                ),
              ),
              Spacer(),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    8.hb,
                    '??'
                        .richText
                        .withTextSpanChildren([
                          model.sellPrice!
                              .toStringAsFixed(2)
                              .textSpan
                              .size(28.sp)
                              .color(ktextPrimary)
                              .make(),
                        ])
                        .color(ktextPrimary)
                        .size(28.sp)
                        .make(),
                    'x ${_controllers.text}'
                        .text
                        .size(24.sp)
                        .color(Color(0xFFBBBBBB))
                        .make(),
                  ],
                ),
              )
            ],
          ),
          bottom,
          Spacer(),
          if (!widget.integralGood)
            Column(
              children: [
                price,
                30.hb,
              ],
            ),
        ],
      ),
    );
  }

  String _getPointBehind(double num) {
    var str = (num - num.toInt().toDouble()).toStringAsFixed(2);
    return str.substring(str.length - 2);
  }

  Widget _getKindWd(int kind) {
    switch (kind) {
      case 1:
        return Container(
            // width: 90.w,
            // height: 26.w,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFEC5329), Color(0xFFF58123)])),
            child: '????????????'.text.size(18.sp).color(Colors.white).make());
      case 2:
        return Container(
            width: 90.w,
            height: 26.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFEC5329), Color(0xFFF58123)])),
            child: '??????POP'.text.size(18.sp).color(Colors.white).make());
      default:
        return SizedBox();
    }
  }

  Widget? _getGoodsStatusImg(GoodStatus status) {
    switch (status) {
      case GoodStatus.unSell:
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFF000000).withOpacity(0.5),
          alignment: Alignment.center,
          child: Text(
            '?????????',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
                color: Colors.white),
          ),
        );
      case GoodStatus.onSell:
        return null;
    }
  }

  Widget _getBottomSuffix(GoodStatus status, int id) {
    switch (status) {
      case GoodStatus.onSell:
        return Container(
          width: 108.w + 64.w,
          height: 40.w,
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  int num = int.parse(_controllers.text);
                  if (num > 1) {
                    _controllers.text = (num - 1).toString();
                    _goodsList[0].num = num - 1;
                    createOrder(_addressModel!.id!, _goodsList);
                  }

                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Icon(
                    CupertinoIcons.minus,
                    size: 30.w,
                  ),
                ),
              ),
              Container(
                width: 84.w,
                height: 40.w,
                decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(4.w)),
                child: TextField(
                  readOnly: true,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (text) async {
                    var result = await changeNum(id, int.parse(text));
                    if (!result) {
                      // _controllers[index].text=
                    }

                    setState(() {});
                  },
                  controller: _controllers,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  int num = int.parse(_controllers.text);
                  if (num < 10) {
                    _controllers.text =
                        (int.parse(_controllers.text) + 1).toString();
                    _goodsList[0].num = num + 1;
                    createOrder(_addressModel!.id!, _goodsList);

                    setState(() {});
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Icon(
                    CupertinoIcons.plus,
                    size: 30.w,
                  ),
                ),
              )
            ],
          ),
        );
      case GoodStatus.unSell:
        return '???????????????'.text.size(24.sp).color(Color(0x80000000)).make();
    }
  }

  Widget _emptyWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            R.ASSETS_IMAGES_SHOP_CAR_EMPTY_PNG,
            width: 400.w,
            height: 400.w,
          ),
          '????????????????????????'.text.size(28.sp).color(Color(0xFFBBBBBB)).make()
        ],
      ),
    );
  }

  Future<bool> changeNum(int jcookGoodsId, int num) async {
    var cancel = BotToast.showLoading();
    var base = await NetUtil().post(API.market.shopCarChangeNum,
        params: {'jcookGoodsId': jcookGoodsId, 'num': num});
    if (!(base.status ?? false)) {
      BotToast.showText(text: base.message ?? '');
    }
    cancel();
    return base.status ?? false;
  }
}
