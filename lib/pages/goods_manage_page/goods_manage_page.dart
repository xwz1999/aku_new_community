import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/model/manager/article_borrow_model.dart';
import 'package:aku_community/pages/goods_manage_page/borrow/borrow_goods_page.dart';
import 'package:aku_community/pages/goods_manage_page/mine_goods_page/mine_goods_page.dart';
import 'package:aku_community/pages/goods_manage_page/retrun/return_goods_detail_page.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';

class GoodsManagePage extends StatefulWidget {
  final bool isBorrow;
  GoodsManagePage({Key key, this.isBorrow = true}) : super(key: key);

  @override
  _GoodsManagePageState createState() => _GoodsManagePageState();
}

class _GoodsManagePageState extends State<GoodsManagePage> {
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  Container _goodsCard(ArticleBorrowModel model) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.w,
        left: 32.w,
        right: 32.w,
      ),
      padding: EdgeInsets.only(
        top: 12.w,
        left: 10.w,
        right: 10.w,
        bottom: 17.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6.w)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120.w,
            width: 160.w,
            margin: EdgeInsets.only(right: 20.w),
            child: ClipRRect(
              child: FadeInImage.assetNetwork(
                placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                image: API.image(ImgModel.first(model.imgUrls)),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '物品名称：${model.name}',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xff4a4b51),
                ),
              ),
              SizedBox(height: 20.w),
              Text(
                '数量剩余：${model.quantity}',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '借还管理',
      actions: [
        MaterialButton(
          onPressed: () {
            Get.to(() => MineGoodsPage());
          },
          child: '我的借还物品'.text.black.size(28.sp).make(),
          padding: EdgeInsets.symmetric(horizontal: 32.w),
        ),
      ],
      body: BeeListView(
          path: API.manager.articleBorrow,
          controller: _easyRefreshController,
          convert: (models) {
            return models.tableList
                .map((e) => ArticleBorrowModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return _goodsCard(items[index]);
                },
                separatorBuilder: (_, __) {
                  return 16.w.heightBox;
                },
                itemCount: items.length);
          }),
      bottomNavi: BottomButton(
        child: '扫一扫'.text.black.size(32.sp).bold.make(),
        onPressed: widget.isBorrow
            ? () {
                Get.to(() => BorrowGoodsPage());
              }
            : () {
                Get.to(() => ReturnGoodsDetailPage());
              },
      ),
    );
  }
}
