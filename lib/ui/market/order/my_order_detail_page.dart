import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/models/market/goods_item.dart';
import 'package:aku_community/models/market/order/my_order_list_model.dart';
import 'package:aku_community/ui/market/goods/goods_card.dart';
import 'package:aku_community/ui/market/order/my_order_func.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class MyOrderDetailPage extends StatefulWidget {
  final MyOrderListModel model;
  MyOrderDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _MyOrderDetailPageState createState() => _MyOrderDetailPageState();
}

class _MyOrderDetailPageState extends State<MyOrderDetailPage> {
  late EasyRefreshController _refreshController;
  late List<GoodsItem> _topGoods;
  bool _onload = true;
  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '订单详情',
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          _topGoods = await MyOrderFunc.getHotTops();
          _onload = false;
          setState(() {});
        },
        child: _onload
            ? Container()
            : ListView(
                padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
                children: <Widget>[
                  _statusInfo(),
                  ..._refunReason(widget.model.backReason ?? '',
                      widget.model.backDateString),
                  ..._evaluationContent(widget.model.evaluationReason ?? '',
                      widget.model.evaluateDateString),
                  _goodsInfoWidget(),
                  _orderInfo(),
                  _extraWidget(_topGoods),
                ].sepWidget(
                  separate: 24.w.heightBox,
                ),
              ),
      ),
    );
  }

  Widget _statusInfo() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFB4702).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16.w),
                ),
                child: Icon(
                  _icondata,
                  size: 32.w,
                  color: Color(0xFFFB4702),
                ),
              ),
              20.w.widthBox,
              widget.model.statusString.text
                  .size(32.sp)
                  .bold
                  .color(ktextPrimary)
                  .make(),
            ],
          ),
          20.w.heightBox,
          '2020-05-14 14:22:11'
              .text
              .size(28.sp)
              .bold
              .color(ktextPrimary.withOpacity(0.8))
              .make()
        ],
      ),
    );
  }

  _refunReason(String text, String date) {
    return widget.model.backReason == null
        ? []
        : [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.w)),
              padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      '退换理由'.text.size(32.sp).bold.color(ktextPrimary).make(),
                    ],
                  ),
                  20.w.heightBox,
                  text.text.size(28.sp).color(ktextSubColor).make(),
                  20.w.heightBox,
                  date.text
                      .size(24.sp)
                      .bold
                      .color(ktextPrimary.withOpacity(0.8))
                      .make()
                ],
              ),
            )
          ];
  }

  _evaluationContent(String text, String date) {
    return widget.model.evaluationReason == null
        ? []
        : [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.w)),
              padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      '评价内容'.text.size(32.sp).bold.color(ktextPrimary).make(),
                    ],
                  ),
                  20.w.heightBox,
                  text.text.size(28.sp).color(ktextSubColor).make(),
                  20.w.heightBox,
                  date.text
                      .size(24.sp)
                      .bold
                      .color(ktextPrimary.withOpacity(0.8))
                      .make()
                ],
              ),
            )
          ];
  }

  IconData get _icondata {
    switch (widget.model.status) {
      case 1:
      case 2:
        return CupertinoIcons.stopwatch;
      case 3:
      case 4:
      case 6:
        return CupertinoIcons.checkmark_alt;
      case 8:
        return CupertinoIcons.stopwatch;
      case 9:
        return CupertinoIcons.checkmark_alt;
      case 10:
        return CupertinoIcons.multiply;
      default:
        return CupertinoIcons.multiply_circle;
    }
  }

  Widget _orderInfo() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
      child: Column(
        children: [
          Row(
            children: [
              '订单信息'.text.size(32.sp).bold.color(ktextPrimary).make(),
            ],
          ),
          24.w.heightBox,
          ...<Widget>[
            _rowTile('订单编号', widget.model.code),
            _rowTile('创建时间', widget.model.createDateString),
            ...widget.model.sendDate == null
                ? []
                : [_rowTile('发货时间', widget.model.sendDateString)],
            ...widget.model.arrivalDate == null
                ? []
                : [_rowTile('到货时间', widget.model.arrivalDateString)],
          ].sepWidget(
            separate: 20.w.heightBox,
          )
        ],
      ),
    );
  }

  Widget _rowTile(
    String title,
    String content,
  ) {
    return Row(
      children: [
        // (160 + 24).w.widthBox,
        title.text.size(24.sp).color(ktextSubColor).make(),
        Spacer(),
        content.text.size(24.sp).color(ktextPrimary).make(),
      ],
    );
  }

  Widget _goodsInfoWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
      padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.model.goodsName.text
                  .size(32.sp)
                  .bold
                  .color(ktextPrimary)
                  .make(),
              Spacer(),
              // widget.model.statusString.text
              //     .size(30.sp)
              //     .bold
              //     .color(widget.model.statusColor)
              //     .make(),
            ],
          ),
          16.w.heightBox,
          BeeDivider.horizontal(),
          24.w.heightBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                clipBehavior: Clip.antiAlias,
                child: FadeInImage.assetNetwork(
                    width: 160.w,
                    height: 160.w,
                    fit: BoxFit.cover,
                    placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                    image:
                        API.image(ImgModel.first(widget.model.goodsImgList))),
              ),
              24.w.widthBox,
              SizedBox(
                height: 160.w,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.model.goodsName.text
                            .size(28.sp)
                            .color(ktextPrimary)
                            .maxLines(2)
                            .overflow(TextOverflow.ellipsis)
                            .bold
                            .make(),
                        Spacer(),
                        '¥${widget.model.sellingPrice}'
                            .text
                            .size(28.sp)
                            .bold
                            .color(Color(0xFFE60E0E))
                            .make(),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        ('${widget.model.levelOneCategory}|${widget.model.levelTwoCategory}')
                            .text
                            .size(24.sp)
                            .color(ktextSubColor)
                            .make()
                      ],
                    ),
                    // 12.w.heightBox,
                    // Row(
                    //   children: [
                    //     ('${widget.model.levelTwoCategory}')
                    //         .text
                    //         .size(24.sp)
                    //         .color(ktextSubColor)
                    //         .make()
                    //   ],
                    // ),
                  ],
                ),
              ).expand()
            ],
          ),
        ],
      ),
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
              '其他热门（${models.length}）'
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
}
