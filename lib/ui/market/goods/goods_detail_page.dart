import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/market/goods_detail_model.dart';
import 'package:aku_new_community/models/market/goods_item.dart';
import 'package:aku_new_community/pages/sign/login/login_page.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/market/goods/goods_card.dart';
import 'package:aku_new_community/ui/market/goods/goods_order_detail_page.dart';
import 'package:aku_new_community/ui/market/search/search_goods_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

///商品详情页面
class GoodsDetailPage extends StatefulWidget {
  ///商品ID
  final int id;

  GoodsDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  late EasyRefreshController _refreshController;
  late GoodsDetailModel _goodsModel;
  bool _onload = true;
  List<GoodsItem> _topGoods = [];
  late PageController _pageController;
  int _currentIndex = 0;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _refreshController = EasyRefreshController();
    _pageController = PageController();
    _nameController.text = userProvider.userInfoModel?.name ??
        userProvider.userInfoModel?.nickName ??
        '';
    _phoneController.text = userProvider.userInfoModel?.tel ?? '';
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      leading: BeeBackButton(),
      title: '商品详情',
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.search),
          onPressed: () {
            Get.to(() => SearchGoodsPage());
          },
        ),
      ],
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          BaseModel baseModel = await NetUtil().get(
            API.market.goodsDetail,
            params: {"goodsId": widget.id},
          );
          if (baseModel.success == true && baseModel.data != null) {
            _goodsModel = GoodsDetailModel.fromJson(baseModel.data);
          } else {
            _goodsModel = GoodsDetailModel.fail();
            BotToast.showText(text: baseModel.message ?? '未知错误');
          }
          baseModel = await NetUtil().get(API.market.suppliyerHotTop, params: {
            "supplierId": _goodsModel.supplierId,
          });
          if (baseModel.success == true && baseModel.data != null) {
            _topGoods = (baseModel.data as List)
                .map((e) => GoodsItem.fromJson(e))
                .toList();
          }
          _onload = false;
          setState(() {});
        },
        child: _onload
            ? _emptyWidget()
            : ListView(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _imageView(_goodsModel.goodsImgList),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _goodsModel.title.text
                                  .size(40.sp)
                                  .bold
                                  .color(ktextPrimary)
                                  .make()
                                  .expand(),
                              '¥${_goodsModel.sellingPrice}'
                                  .text
                                  .size(36.sp)
                                  .bold
                                  .color(Colors.red)
                                  .make(),
                              8.w.widthBox,
                              '¥${_goodsModel.markingPrice}'
                                  .text
                                  .size(18.sp)
                                  .bold
                                  .textBaseLine(TextBaseline.ideographic)
                                  .color(Colors.black)
                                  .lineThrough
                                  .make(),
                            ],
                          ),
                        ),
                        24.w.heightBox,
                        Row(
                          children: [
                            32.w.widthBox,
                            _goodsModel.categoryName.text
                                .size(24.sp)
                                .color(ktextSubColor)
                                .make(),
                            24.w.widthBox,
                            '${_goodsModel.subscribeNum}人已订阅'
                                .text
                                .size(24.sp)
                                .color(ktextPrimary)
                                .make()
                          ],
                        ),
                        24.w.heightBox,
                      ],
                    ),
                  ),
                  24.w.heightBox,
                  _goodsItemDescrible(),
                  24.w.heightBox,
                  _supplierWidget(),
                  24.w.heightBox,
                  _extraWidget(_topGoods),
                ],
              ),
        controller: _refreshController,
      ),
      bottomNavi: BottomButton(
        onPressed: () {
          if (!UserTool.userProvider.isLogin) {
            BotToast.showText(text: '请先登录！');
            Get.offAll(() => LoginPage());
            return;
          }
          Get.bottomSheet(Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24.w),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '预约后商户将通过电话联系您',
                    style: TextStyle(
                      fontSize: 28.sp,
                    ),
                  ),
                  40.hb,
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Color(0xFFEEEEEE),
                      filled: true,
                    ),
                  ),
                  32.hb,
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Color(0xFFEEEEEE),
                      filled: true,
                    ),
                  ),
                  80.hb,
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.infinity,
                    shape: StadiumBorder(),
                    color: kPrimaryColor,
                    height: 80.w,
                    onPressed: () async {
                      Get.off(() => GoodsOrderDetailPage(
                          model: _goodsModel,
                          name: _nameController.text,
                          phone: _phoneController.text));
                    },
                    child: Text('确认购买'),
                  ),
                ],
              ),
            ),
          ));
        },
        child: Text('立即购买'),
      ),
    );
  }

  Widget _imageView(List<ImgModel> imgList) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 500.w,
          child: PageView.builder(
              itemCount: imgList.length,
              onPageChanged: (value) {
                _pageController.jumpToPage(value);
                _currentIndex = value;
                setState(() {});
              },
              controller: _pageController,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  height: 500.w,
                  child: FadeInImage.assetNetwork(
                      placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                      image: API.image(imgList[index].url)),
                );
              }),
        ),
        Positioned(
          bottom: 24.w,
          right: 5.w,
          child: Container(
            alignment: Alignment.center,
            width: 69.w,
            height: 39.w,
            decoration: BoxDecoration(
                color: Color(0x80000000),
                borderRadius: BorderRadius.circular(40.w)),
            child: '${_currentIndex + 1}/${imgList.length}'
                .text
                .size(24.sp)
                .color(Colors.white)
                .make(),
          ),
        ),
      ],
    );
  }

  Widget _extraWidget(List<GoodsItem> models) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
      child: Column(
        children: [
          Row(
            children: [
              '其他（${models.length}）'
                  .text
                  .size(24.sp)
                  .color(ktextPrimary)
                  .bold
                  .make(),
            ],
          ),
          24.w.heightBox,
          SizedBox(
            height: 1000.w,
            child: WaterfallFlow.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20.w,
              crossAxisSpacing: 24.w,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                models.length,
                (index) => GoodsCard(
                  item: models[index],
                  border: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _supplierWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: API.image(
                ImgModel.first(_goodsModel.supplierImgList),
              ),
              width: 160.w,
              height: 160.w,
            ),
          ),
          20.w.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _goodsModel.supplierName.text
                  .size(28.sp)
                  .color(ktextPrimary)
                  .bold
                  .make(),
              54.w.heightBox,
              '地址：${_goodsModel.supplierAddress}'
                  .text
                  .size(24.sp)
                  .color(ktextPrimary)
                  .make()
            ],
          )
        ],
      ),
    );
  }

  Widget _goodsItemDescrible() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '商品详情'.text.size(32.sp).color(ktextPrimary).bold.make(),
          24.w.heightBox,
          _goodsModel.detail.text.size(24.sp).color(ktextPrimary).make(),
        ],
      ),
    );
  }

  Widget _emptyWidget() {
    return Container();
  }
}
