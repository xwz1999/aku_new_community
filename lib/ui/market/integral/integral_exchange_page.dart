import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/ui/market/integral/integral_sku_model.dart';
import 'package:aku_new_community/ui/market/search/good_detail_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class IntegralExchangePage extends StatefulWidget {
  const IntegralExchangePage({Key? key}) : super(key: key);

  @override
  _IntegralExchangePageState createState() => _IntegralExchangePageState();
}

class _IntegralExchangePageState extends State<IntegralExchangePage> {
  List<IntegralSkuModel> _models = IntegralSkuModel.examples;

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '积分商城',
      body: SafeArea(
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
              })),
    );
  }

  Widget _card(IntegralSkuModel model) {
    return GestureDetector(
      onTap: () {
        Get.to(() => GoodDetailPage(
              goodId: model.goodId,
              integral: model.integral,
              integralGood: true,
            ));
      },
      child: Column(
        children: [
          Container(
              color: Color(0xFFF9F9F),
              child: Image.network(model.imgPath, width: 332.w, height: 332.w)),
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
              '${model.integral}'.text.size(24.sp).color(Colors.red).make(),
              Spacer(),
              '已售${model.sold}份'
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
