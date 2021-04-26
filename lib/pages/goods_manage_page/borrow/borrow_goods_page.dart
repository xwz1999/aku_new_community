import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/common/img_model.dart';
import 'package:akuCommunity/model/manager/article_borrow_model.dart';
import 'package:akuCommunity/pages/goods_manage_page/borrow/borrow_finsh_page.dart';
import 'package:akuCommunity/pages/goods_manage_page/borrow/borrow_goods_detail_page.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class BorrowGoodsPage extends StatefulWidget {
  BorrowGoodsPage({Key key}) : super(key: key);

  @override
  _BorrowGoodsPageState createState() => _BorrowGoodsPageState();
}

class _BorrowGoodsPageState extends State<BorrowGoodsPage> {
  EasyRefreshController _easyRefreshController;
  List<int> _receiveIds = [];
  List<int> _submitIds = [];
  List<int> _counts = [];
  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _easyRefreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '全部物品',
      actions: [
        MaterialButton(
          onPressed: () {
            // Get.to(() => MineGoodsPage());
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
            if (_counts.isEmpty) {
              _counts = List.filled(items.length, 0);
            }
            return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
                itemBuilder: (context, index) {
                  return _goodsCard(items[index], index);
                },
                separatorBuilder: (_, __) {
                  return 16.w.heightBox;
                },
                itemCount: items.length);
          }),
      bottomNavi: Row(
        children: [
          '已选择 '.richText.color(ktextPrimary).size(24.sp).withTextSpanChildren([
            '${_submitIds.length}'
                .textSpan
                .size(32.sp)
                .color(ktextPrimary)
                .make(),
            ' 项'.textSpan.size(24.sp).color(ktextPrimary).make(),
          ]).make(),
          Spacer(),
          MaterialButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(37.w)),
            color: kPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
            onPressed: () async {
              BaseModel baseModel = await NetUtil().post(
                  API.manager.articleBorrowGoods,
                  params: {"ids": _submitIds},
                  showMessage: false);
              Get.to(BorrowFinshPage(
                isSuccess: baseModel.status,
                failText: baseModel.message,
              ));
            },
            child: '借出'.text.black.size(32.sp).bold.make(),
          ),
        ],
      )
          .pSymmetric(v: 22.w, h: 32.w)
          .box
          .color(Colors.white)
          .width(double.infinity)
          .padding(
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom))
          .make(),
    );
  }

  Widget _goodsCard(ArticleBorrowModel model, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 184.w,
          height: 184.w,
          child: ClipRRect(
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: API.image(ImgModel.first(model.imgUrls)),
            ),
          ),
        ),
        24.w.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  R.ASSETS_ICONS_ARTICLE_NAME_PNG,
                  width: 40.w,
                  height: 40.w,
                ),
                4.w.widthBox,
                '物品名称:'.text.color(ktextSubColor).size(28.sp).make(),
                '${model.name}'.text.color(ktextPrimary).size(28.sp).make(),
              ],
            ),
            12.w.heightBox,
            Row(
              children: [
                Image.asset(
                  R.ASSETS_ICONS_ARTICLE_COUNT_PNG,
                  width: 40.w,
                  height: 40.w,
                ),
                4.w.widthBox,
                '剩余数量:'.text.color(ktextSubColor).size(28.sp).make(),
                '${model.quantity}'.text.color(ktextPrimary).size(28.sp).make(),
              ],
            ),
          ],
        ),
        _counts[index] == 0
            ? SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      color: kPrimaryColor,
                    ),
                    child: '${_counts[index]}'
                        .text
                        .color(ktextPrimary)
                        .size(24.sp)
                        .bold
                        .make(),
                  ),
                ],
              ).expand()
      ],
    )
        .box
        .color(Colors.white)
        .height(232.w)
        .width(686.w)
        .padding(EdgeInsets.symmetric(vertical: 24.w, horizontal: 24.w))
        .withRounded(value: 6.w)
        .make()
        .onInkTap(() async {
      _receiveIds.forEach((element) {
        _submitIds.remove(element);
      });
      await Get.to(() => BorrowGoodsDetailPage(
            articleId: model.id,
            receiveIds: _receiveIds,
          )).then((value) {
        _receiveIds = value;
      });
      _counts[index] = _receiveIds.length;
      _submitIds.addAll(_receiveIds);
      setState(() {});
    });
  }
}
