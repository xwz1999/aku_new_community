import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/common/img_model.dart';
import 'package:akuCommunity/model/manager/article_borrow_detail_model.dart';
import 'package:akuCommunity/pages/goods_deto_page/deto_create_page/widget/common_radio.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/animated/animated_scale.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
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
  bool get allSelect => _selectItems.length == _models.length;
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
      bottomNavi: _onload ? _empty() : _bottomButton(),
    );
  }

  Widget _allSelectButton() {
    return GestureDetector(
      onTap: () {
        if (allSelect) {
          _selectItems.clear();
        } else {
          _selectItems.clear();
          _models.forEach((element) {
            _selectItems.add(element.id);
          });
        }
        setState(() {});
      },
      child: AnimatedContainer(
        height: 40.w,
        width: 40.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: allSelect ? kPrimaryColor : Color(0xFF979797),
            width: 3.w,
          ),
          borderRadius: BorderRadius.circular(20.w),
        ),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        alignment: Alignment.center,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          opacity: allSelect ? 1 : 0,
          child: AnimatedScale(
            scale: allSelect ? 1 : 0,
            child: Container(
              height: 24.w,
              width: 24.w,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(12.w),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomButton() {
    return Row(
      children: [
        _allSelectButton(),
        16.w.widthBox,
        '全选'.text.color(ktextSubColor).size(24.sp).make(),
        Spacer(),
        '已选择 '.richText.color(ktextPrimary).size(24.sp).withTextSpanChildren([
          '${_selectItems.length}'
              .textSpan
              .size(32.sp)
              .color(ktextPrimary)
              .make(),
          ' 项'.textSpan.size(24.sp).color(ktextPrimary).make(),
        ]).make(),
        32.w.widthBox,
        MaterialButton(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(37.w)),
          color: kPrimaryColor,
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
          onPressed: () {
            Get.back(result: _selectItems);
          },
          child: '确定'.text.black.size(32.sp).bold.make(),
        ),
      ],
    )
        .pSymmetric(v: 22.w, h: 32.w)
        .box
        .color(Colors.white)
        .width(double.infinity)
        .padding(EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom))
        .make();
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
        GestureDetector(
          onTap: () {
            if (_selectItems.contains(model.id)) {
              _selectItems.remove(model.id);
            } else {
              _selectItems.add(model.id);
            }
            setState(() {});
          },
          child: Container(
            height: 232.w - 48.w,
            alignment: Alignment.center,
            child: BeeRadio(
              value: model.id,
              groupValues: _selectItems,
            ),
          ),
        ).material(color: Colors.transparent),
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
                '物品名称：'.text.color(ktextSubColor).size(28.sp).make(),
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
                '物品单号：'.text.color(ktextSubColor).size(28.sp).make(),
                '${model.code}'.text.color(ktextPrimary).size(28.sp).make(),
              ],
            ),
            12.w.heightBox,
            Row(
              children: [
                Image.asset(
                  R.ASSETS_ICONS_BORROW_STATUS_PNG,
                  width: 40.w,
                  height: 40.w,
                ),
                4.w.widthBox,
                '出借状态：'.text.color(ktextSubColor).size(28.sp).make(),
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
