// Flutter imports:
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/article_borrow_model.dart';
import 'package:akuCommunity/pages/goods_manage_page/mine_goods_page/mine_goods_page.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/widget/buttons/bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// Package imports:
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/const/resource.dart';

class GoodsManagePage extends StatefulWidget {
  GoodsManagePage({Key key}) : super(key: key);

  @override
  _GoodsManagePageState createState() => _GoodsManagePageState();
}

class _GoodsManagePageState extends State<GoodsManagePage> {
  EasyRefreshController _easyRefreshController;

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
                    placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                    image: API.image(
                        model.imgUrls.isEmpty ? '' : model.imgUrls.first.url))),
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
        InkWell(
            onTap: () {
              MineGoodsPage().to();
            },
            child: Container(
                padding: EdgeInsets.fromLTRB(32.w, 28.w, 32.w, 20.w),
                alignment: Alignment.center,
                child: '我的借还物品'.text.black.size(28.sp).make()))
      ],
      // body: Stack(
      //   children: [
      //     Column(
      //       children: _listGoods
      //           .map((item) => _goodsCard(
      //                 item['imagePath'],
      //                 item['title'],
      //                 item['goodsNum'],
      //               ))
      //           .toList(),
      //     ),
      //     Positioned(
      //       bottom: 0,
      //       child: BottomButton(
      //         title: '扫一扫出借',
      //         fun: () {},
      //       ),
      //     ),
      //   ],
      // ),

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
        child: '扫一扫出借'.text.black.size(32.sp).bold.make(),
        onPressed: () {},
      ),
    );
  }
}
