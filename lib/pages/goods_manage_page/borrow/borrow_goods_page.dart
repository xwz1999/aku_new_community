import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/manager/article_borrow_model.dart';
import 'package:aku_new_community/pages/goods_manage_page/borrow/borrow_goods_detail_page.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:power_logger/power_logger.dart';
import 'package:velocity_x/velocity_x.dart';

import 'borrow_examine_page.dart';

class BorrowGoodsSubmitModel {
  List<int> selectIds;

  static BorrowGoodsSubmitModel init() => BorrowGoodsSubmitModel([]);

  BorrowGoodsSubmitModel(
    this.selectIds,
  );
}

class BorrowGoodsPage extends StatefulWidget {
  BorrowGoodsPage({Key? key}) : super(key: key);

  @override
  _BorrowGoodsPageState createState() => _BorrowGoodsPageState();
}

class _BorrowGoodsPageState extends State<BorrowGoodsPage> {
  EasyRefreshController? _easyRefreshController;
  List<BorrowGoodsSubmitModel> _receiveIds = [];
  List<ArticleBorrowModel> _borrowModels = [];
  int _page = 1;
  int _size = 10;

  List<int> get _submitIds {
    List<int> _list = [];
    _receiveIds.forEach((element) {
      _list.addAll(element.selectIds);
    });
    return _list;
  }

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
      // actions: [
      //   MaterialButton(
      //     onPressed: () {
      //       // Get.to(() => MineGoodsPage());
      //     },
      //     child: '我的借还物品'.text.black.size(28.sp).make(),
      //     padding: EdgeInsets.symmetric(horizontal: 32.w),
      //   ),
      // ],
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        controller: _easyRefreshController,
        onRefresh: () async {
          _page = 1;
          BaseListModel _listModel = await NetUtil().getList(
              API.manager.articleBorrow,
              params: {'pageNum': _page, 'size': _size});
          _borrowModels = _listModel.rows
              .map((e) => ArticleBorrowModel.fromJson(e))
              .toList();
          _receiveIds =
              _borrowModels.map((e) => BorrowGoodsSubmitModel.init()).toList();
          setState(() {});
        },
        onLoad: () async {
          _page++;
          BaseListModel _listModel = await NetUtil().getList(
              API.manager.articleBorrow,
              params: {'pageNum': _page, 'size': _size});
          _borrowModels.addAll(_listModel.rows
              .map((e) => ArticleBorrowModel.fromJson(e))
              .toList());
          _receiveIds.addAll(_listModel.rows
              .map((e) => BorrowGoodsSubmitModel.init())
              .toList());
          setState(() {});
        },
        child: _borrowModels.isEmpty
            ? Container()
            : ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
                itemBuilder: (context, index) {
                  return _goodsCard(_borrowModels[index], index);
                },
                separatorBuilder: (_, __) {
                  return 16.w.heightBox;
                },
                itemCount: _borrowModels.length),
      ),
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
              if (_submitIds.length < 1) {
                BotToast.showText(text: '请先选择您要借出的物品');
              } else {
                BaseModel baseModel = await NetUtil().post(
                    API.manager.articleBorrowGoods,
                    params: {"ids": _submitIds},
                    showMessage: false);
                Get.to(BorrowExaminePage());
              }
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
    var selectCount = _receiveIds[index].selectIds.length;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 184.w,
          height: 184.w,
          child: ClipRRect(
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: SAASAPI.image(ImgModel.first(model.imgUrls)),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  height: 184.w,
                  width: 184.w,
                );
              },
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
        selectCount == 0
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
                    child: '${_receiveIds[index].selectIds.length}'
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
      _receiveIds[index].selectIds = await Get.to(() => BorrowGoodsDetailPage(
            articleId: model.id!,
            receiveIds: _receiveIds[index].selectIds,
          ));
      setState(() {});
      LoggerData.addData(_receiveIds.last.selectIds.length);
    });
  }
}
