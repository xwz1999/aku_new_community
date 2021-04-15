import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/common/img_model.dart';
import 'package:akuCommunity/model/manager/article_borrow_detail_model.dart';
import 'package:akuCommunity/pages/goods_deto_page/deto_create_page/widget/common_radio.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akuCommunity/const/resource.dart';

class BorrowGoodsDetailPage extends StatefulWidget {
  final int articleId;
  BorrowGoodsDetailPage({Key key, this.articleId}) : super(key: key);

  @override
  _BorrowGoodsDetailPageState createState() => _BorrowGoodsDetailPageState();
}

class _BorrowGoodsDetailPageState extends State<BorrowGoodsDetailPage> {
  EasyRefreshController _easyRefreshController;
  List<ArticleBorrowDetailModel> _models;
  bool _onload = true;
  List<int> _selectItems = [];
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
      title: '选择物品',
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          List models = await getModels();
          _models =
              models.map((e) => ArticleBorrowDetailModel.fromJson(e)).toList();
          _onload = false;
          setState(() {});
        },
        child: _onload
            ? _empty()
            : ListView(
                children: [..._models.map((e) => _goodsCard(e)).toList()],
              ),
      ),
    );
  }

  Widget _empty() {
    return Container();
  }

  Future getModels() async {
    BaseModel baseModel =
        await NetUtil().get(API.manager.articleBorrowFindDetail, params: {
      "articleId": widget.articleId,
    });
    return baseModel.data as List;
  }

  Widget _goodsCard(ArticleBorrowDetailModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonRadio(
          size: 32.w,
          value: model.id,
          groupValue: _selectItems,
        ),
        24.w.widthBox,
        SizedBox(
          width: 184.w,
          height: 184.w,
          child: ClipRRect(
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: API.image(ImgModel.first(model.imgList)),
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
                '${model.borrowStatus}'
                    .text
                    .color(ktextPrimary)
                    .size(28.sp)
                    .make(),
              ],
            ),
          ],
        )
      ],
    )
        .box
        .color(Colors.white)
        .padding(EdgeInsets.symmetric(vertical: 24.w, horizontal: 24.w))
        .withRounded(value: 6.w)
        .make();
  }
}
