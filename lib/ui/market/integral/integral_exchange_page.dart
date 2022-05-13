import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/market/integral_goods_list_model.dart';
import 'package:aku_new_community/ui/market/search/good_detail_page.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class IntegralExchangePage extends StatefulWidget {
  const IntegralExchangePage({Key? key}) : super(key: key);

  @override
  _IntegralExchangePageState createState() => _IntegralExchangePageState();
}

class _IntegralExchangePageState extends State<IntegralExchangePage> {
  List<IntegralGoodsListModel> _models = [];
  int _pageNum = 1;
  int _size = 10;
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  @override
  void dispose() {
    _easyRefreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '积分商城',
      body: SafeArea(
          child: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        controller: _easyRefreshController,
        onRefresh: () async {
          _pageNum = 1;
          var baseList = await NetUtil().getList(
            SAASAPI.market.integralGood.list,
            params: {'pageNum': _pageNum, 'size': _size},
          );
          _models = baseList.rows
              .map((e) => IntegralGoodsListModel.fromJson(e))
              .toList();
          setState(() {});
        },
        onLoad: () async {
          _pageNum++;
          var baseList = await NetUtil().getList(
            SAASAPI.market.integralGood.list,
            params: {'pageNum': _pageNum, 'size': _size},
          );
          if (baseList.total > _models.length) {
            _models.addAll(baseList.rows
                .map((e) => IntegralGoodsListModel.fromJson(e))
                .toList());
          } else {
            _easyRefreshController.finishLoad(noMore: true);
          }
          setState(() {});
        },
        child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
            itemCount: _models.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 332 / 480,
                mainAxisSpacing: 16.w,
                crossAxisSpacing: 24.w),
            itemBuilder: (context, index) {
              return _card(_models[index]);
            }),
      )),
    );
  }

  Widget _card(IntegralGoodsListModel model) {
    return GestureDetector(
      onTap: () {
        Get.to(() => GoodDetailPage(
              goodId: model.id,
              integral: model.points,
              integralGood: true,
            ));
      },
      child: Column(
        children: [
          Container(
              color: Color(0xFFF9F9F),
              child:
                  Image.network(model.mainPhoto, width: 332.w, height: 332.w)),
          16.w.heightBox,
          '${model.skuName}'
              .text
              .size(28.sp)
              .maxLines(2)
              .overflow(TextOverflow.ellipsis)
              .color(Color(0xFF4F4F4F))
              .make(),
          16.w.heightBox,
          Row(
            children: [
              Assets.icons.intergral.image(width: 24.w, height: 24.w),
              4.w.widthBox,
              '${model.points}'.text.size(24.sp).color(Colors.red).make(),
              Spacer(),
              '已售${model.saleNum ?? 0}份'
                  .text
                  .size(24.sp)
                  .color(Color(0xFFBDBDBD))
                  .make(),
            ],
          )
        ],
      ),
    );
  }
}
