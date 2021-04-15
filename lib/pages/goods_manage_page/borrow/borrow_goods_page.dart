import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/common/img_model.dart';
import 'package:akuCommunity/model/manager/article_borrow_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:akuCommunity/const/resource.dart';

class BorrowGoodsPage extends StatefulWidget {
  BorrowGoodsPage({Key key}) : super(key: key);

  @override
  _BorrowGoodsPageState createState() => _BorrowGoodsPageState();
}

class _BorrowGoodsPageState extends State<BorrowGoodsPage> {
  EasyRefreshController _easyRefreshController;
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
            return ListView.separated(
                itemBuilder: (context, index) {
                  return _goodsCard(items[index]);
                },
                separatorBuilder: (_, __) {
                  return 16.w.heightBox;
                },
                itemCount: items.length);
          }),
      bottomNavi: Row(
        children: [
          '已选择'.richText.color(ktextPrimary).size(28.sp).withTextSpanChildren([
            '0'.textSpan.size(32.sp).color(ktextPrimary).bold.make(),
            '项'.textSpan.size(28.sp).color(ktextPrimary).make(),
          ]).make(),
          Spacer(),
          MaterialButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(37.w)),
            color: kPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
            onPressed: () {},
            child: '选好了'.text.black.size(32.sp).bold.make(),
          ),
        ],
      )
          .pSymmetric(v: 20.w, h: 10.w)
          .box
          .width(double.infinity)
          .padding(
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom))
          .make(),
    );
  }

  Widget _goodsCard(ArticleBorrowModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160.w,
          height: 120.w,
          child: ClipRRect(
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: API.image(ImgModel.first(model.imgUrls)),
            ),
          ),
        ),
        20.w.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  width: 20.w,
                  height: 20.w,
                ),
                4.w.widthBox,
                '物品名称:'.text.color(ktextSubColor).size(28.sp).make(),
                '${model.name}'.text.color(ktextPrimary).size(30.sp).make(),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  width: 20.w,
                  height: 20.w,
                ),
                4.w.widthBox,
                '物品名称:'.text.color(ktextSubColor).size(28.sp).make(),
                '${model.quantity}'.text.color(ktextPrimary).size(30.sp).make(),
              ],
            ),
          ],
        ).expand(),
      ],
    )
        .box
        .color(Colors.white)
        .padding(EdgeInsets.symmetric(vertical: 12.w, horizontal: 10.w))
        .withRounded(value: 6.w)
        .make();
  }
}
