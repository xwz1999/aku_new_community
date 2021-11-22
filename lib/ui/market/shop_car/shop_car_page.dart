import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/market/shop_car/shop_car_list_model.dart';
import 'package:aku_community/ui/market/shop_car/shop_car_func.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/buttons/bee_check_radio.dart';
import 'package:aku_community/widget/buttons/end_button.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopCarPage extends StatefulWidget {
  const ShopCarPage({Key? key}) : super(key: key);

  @override
  _ShopCarPageState createState() => _ShopCarPageState();
}

class _ShopCarPageState extends State<ShopCarPage> {
  bool _editStatus = false;
  List<TextEditingController> _controllers = [];
  List<ShopCarListModel> _models = [];

  //选中的model下表
  List<int> _selectIndex = [];

  bool get _allSelect =>
      _selectIndex.length == _models.length && _selectIndex.length != 0;

  double get total {
    var num = 0.0;
    _selectIndex.forEach((element) {
      num += _models[element].sellPrice;
    });
    return num;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF9F9F9),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Material(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    CupertinoIcons.back,
                    size: 48.w,
                  ),
                ),
              ),
            ),
            '购物车'.text.size(32.sp).black.bold.make(),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                _editStatus = !_editStatus;
              },
              child: (_editStatus ? '完成' : '管理')
                  .text
                  .size(32.sp)
                  .black
                  .bold
                  .make())
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                10.widthBox,
                '共${_models.length}件商品'.text.size(28.sp).black.make(),
              ],
            ),
            16.heightBox,
            Expanded(
              child: EasyRefresh(
                firstRefresh: true,
                header: MaterialHeader(),
                onRefresh: () async {
                  var base = await NetUtil().get(API.market.shopCarList);
                  if (base.status ?? false) {
                    _models = (base.data as List)
                        .map((e) => ShopCarListModel.fromJson(e))
                        .toList();
                  }
                  _models.add(ShopCarListModel(
                      id: 0,
                      skuName: '123',
                      mainPhoto: '',
                      status: 1,
                      shopStatus: 1,
                      sellPrice: 20.00,
                      discountPrice: 10,
                      unit: '个',
                      kind: 1,
                      weight: 3,
                      num: 2));
                  _models.forEach((element) {
                    _controllers.add(
                        TextEditingController(text: element.num.toString()));
                  });
                  if (mounted) {
                    setState(() {});
                    ;
                  }
                },
                child: _models.isEmpty
                    ? _emptyWidget()
                    : ListView(
                        shrinkWrap: true,
                        children: _models
                            .mapIndexed((e, index) => _goodCard(e, index))
                            .toList()),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 100.w,
        color: Colors.white,
        child: Row(
          children: [
            10.widthBox,
            GestureDetector(
              onTap: () {
                if (_allSelect) {
                  _selectIndex.clear();
                } else {
                  _selectIndex.clear();
                  _selectIndex
                      .addAll(List.generate(_models.length, (index) => index));
                }
                setState(() {});
              },
              child: Container(
                width: 44.w,
                height: 44.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.w),
                    border: Border.all(color: Color(0xFFBBBBBB))),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: _allSelect ? 1 : 0,
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.w),
                      color: Color(0xFFE52E2E),
                    ),
                  ),
                ),
              ),
            ),
            8.w.widthBox,
            Spacer(),
            Offstage(
              offstage: _editStatus,
              child: '合计：'
                  .richText
                  .withTextSpanChildren([
                    '¥${total}'
                        .textSpan
                        .color(ktextSubColor)
                        .size(28.sp)
                        .make(),
                  ])
                  .black
                  .size(28.sp)
                  .make(),
            ),
            20.widthBox,
            EndButton(
                onPressed: _editStatus ? _delete : _settleEnd,
                text: (_editStatus ? '删除' : '结算')
                    .text
                    .size(32.sp)
                    .color(Colors.white)
                    .make()),
            10.widthBox,
          ],
        ),
      ),
    );
  }

  Future _settleEnd() async {}

  Future _delete() async {}

  Widget _goodCard(ShopCarListModel model, int index) {
    var top = RichText(
      text: TextSpan(children: [
        WidgetSpan(
          child: _getKindWd(model.kind),
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
      child: '规格：${model.weight}kg/${model.unit}'
          .text
          .size(24.sp)
          .color(Color(0xFFBBBBBB))
          .make(),
    );
    var bottom = Row(
      children: [
        '¥'
            .richText
            .withTextSpanChildren([
              model.sellPrice
                  .toInt()
                  .toString()
                  .textSpan
                  .size(40.sp)
                  .color(Color(0xFFE52E2E))
                  .make(),
              '.${_getPointBehind(model.sellPrice)}'
                  .textSpan
                  .size(28.sp)
                  .color(Color(0xFFE52E2E))
                  .make()
            ])
            .color(Color(0xFFE52E2E))
            .size(28.sp)
            .make(),
        Spacer(),
        _getBottomSuffix(model.goodStatus, model.id, index)
      ],
    );
    return Container(
      alignment: Alignment.center,
      height: 260.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (_selectIndex.contains(model.id)) {
                _selectIndex.remove(index);
              } else {
                _selectIndex.add(index);
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: double.infinity,
              alignment: Alignment.center,
              child: BeeCheckRadio(
                value: model.id,
                groupValue: _selectIndex,
                backColor: Colors.white,
                indent: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    color: Color(0xFFE52E2E),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 220.w,
            height: 220.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: NetworkImage(API.image(model.mainPhoto)))),
            child: _getGoodsStatusImg(model.goodStatus),
          ),
          16.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              top,
              8.heightBox,
              mid,
              Spacer(),
              bottom,
              10.heightBox,
            ],
          ).expand(),
          16.widthBox,
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
            child: '京东自营'.text.size(18.sp).color(Colors.white).make());
      case 2:
        return Container(
            width: 90.w,
            height: 26.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFEC5329), Color(0xFFF58123)])),
            child: '其他'.text.size(18.sp).color(Colors.white).make());
      default:
        return SizedBox();
    }
  }

  Widget? _getGoodsStatusImg(GoodStatus status) {
    switch (status) {
      case GoodStatus.onSell:
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFF000000).withOpacity(0.5),
          alignment: Alignment.center,
          child: Text(
            '已下架',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
                color: Colors.white),
          ),
        );
      case GoodStatus.unSell:
        return null;
    }
  }

  Widget _getBottomSuffix(GoodStatus status, int id, int index) {
    switch (status) {
      case GoodStatus.onSell:
        return Container(
          width: 108.w + 64.w,
          height: 40.w,
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  int num = int.parse(_controllers[index].text);
                  var result = await changeNum(id, num - 1);
                  if (result) {
                    _controllers[index].text = (num - 1).toString();
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (text) async {
                    var result = await changeNum(id, int.parse(text));
                    if (!result) {
                      // _controllers[index].text=
                    }

                    setState(() {});
                  },
                  controller: _controllers[index],
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
                  var result = await changeNum(
                      id, int.parse(_controllers[index].text) + 1);
                  if (result) {
                    _controllers[index].text =
                        (int.parse(_controllers[index].text) + 1).toString();
                  }
                  setState(() {});
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
        return '商品已下架'.text.size(24.sp).color(Color(0x80000000)).make();
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
          '暂时没有加购商品'.text.size(28.sp).color(Color(0xFFBBBBBB)).make()
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
