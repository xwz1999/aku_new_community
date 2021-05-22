import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/models/market/order/my_order_list_model.dart';
import 'package:aku_community/ui/market/order/my_order_func.dart';
import 'package:aku_community/utils/card_bottom_button.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';

class MyOrderCard extends StatefulWidget {
  final MyOrderListModel model;
  final VoidCallback callRefresh;
  MyOrderCard({Key? key, required this.model, required this.callRefresh})
      : super(key: key);

  @override
  _MyOrderCardState createState() => _MyOrderCardState();
}

class _MyOrderCardState extends State<MyOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
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
              widget.model.statusString.text
                  .size(30.sp)
                  .bold
                  .color(widget.model.statusColor)
                  .make(),
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
              Column(
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
                  //TODO:  缺少字段 居家生活等副标题及商品规格
                  ...[
                    _rowTile('下单时间', widget.model.arrivlaTimeString),
                    _rowTile('到达地点', '人才公寓小区北侧门口'),
                    _rowTile('发货时间', widget.model.arrivlaTimeString),
                  ].sepWidget(separate: 16.w.heightBox),
                ],
              )
            ],
          ),
          _bottomWidget(),
        ],
      ),
    );
  }

  Widget _bottomWidget() {
    List<Widget> _buttons = _getBottomButton(widget.model.status);

    return _buttons.isEmpty
        ? SizedBox()
        : Row(
            children: [Spacer(), ..._buttons],
          );
  }

  List<Widget> _getBottomButton(int status) {
    switch (status) {
      case 1:
        return [
          CardBottomButton.white(
              text: '取消预约',
              onPressed: () async {
                await MyOrderFunc.cancelOrder(widget.model.id);
                widget.callRefresh();
              }),
          CardBottomButton.yellow(
              text: '确认收货',
              onPressed: () async {
                await MyOrderFunc.confirmReceive(widget.model.id);
                widget.callRefresh();
              }),
        ].sepWidget(separate: 24.w.widthBox);
      case 2:
        return <Widget>[
          // CardBottomButton.white(text: '提醒商家', onPressed: () {}),
        ].sepWidget(separate: 24.w.widthBox);
      case 3:
        return [
          // CardBottomButton.white(text: '商品投诉', onPressed: () {}),
          CardBottomButton.white(
              text: '申请退换',
              onPressed: () async {
                await MyOrderFunc.refundOrder(widget.model.id);
                widget.callRefresh();
              }),
          // CardBottomButton.yellow(text: '查看详情', onPressed: () {}),
        ].sepWidget(separate: 24.w.widthBox);
      case 4:
        return <Widget>[
          // CardBottomButton.white(text: '查看详情', onPressed: () {}),
          // CardBottomButton.yellow(text: '完成退换', onPressed: () {}),
        ].sepWidget(separate: 24.w.widthBox);
      default:
        return [];
    }
  }

  Widget _rowTile(
    String title,
    String content,
  ) {
    return Row(
      children: [
        title.text.size(24.sp).color(ktextSubColor).make(),
        Spacer(),
        content.text.size(24.sp).color(ktextPrimary).make(),
      ],
    );
  }
}
