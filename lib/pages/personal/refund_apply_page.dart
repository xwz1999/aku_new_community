import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:get/get.dart';
import 'widget/refund_shop_card.dart';
import 'widget/refund_tile_card.dart';

class RefundApplyPage extends StatefulWidget {
  final Bundle bundle;
  RefundApplyPage({Key key, this.bundle}) : super(key: key);

  @override
  _RefundApplyPageState createState() => _RefundApplyPageState();
}

class _RefundApplyPageState extends State<RefundApplyPage> {
  TextEditingController _refundContent = new TextEditingController();

  String hintText = '选填';

  Container _containerContentList(List<Map<String, dynamic>> listContent) {
    return Container(
      child: Column(
        children: listContent
            .map((item) => RefundShopCard(
                  imagePath: item['imagePath'],
                  content: item['content'],
                  specs: item['specs'],
                ))
            .toList(),
      ),
    );
  }

  Container _containerRefundPrice(double payPrice) {
    return Container(
      padding: EdgeInsets.only(
        top: 22.w,
        left: 32.w,
        right: 32.w,
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(bottom: 26.w),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '退款金额',
              style: TextStyle(
                fontSize: BaseStyle.fontSize34,
                color: ktextPrimary,
              ),
            ),
            Text(
              '￥$payPrice',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: BaseStyle.fontSize32,
                color: BaseStyle.colorff8500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _containerRefundTextField() {
    return Container(
      padding: EdgeInsets.only(
        top: 22.w,
        left: 32.w,
        right: 32.w,
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(bottom: 26.w),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '退款说明',
              style: TextStyle(
                fontSize: BaseStyle.fontSize34,
                color: ktextPrimary,
              ),
            ),
            SizedBox(height: 23.w),
            TextFormField(
              cursorColor: Color(0xffffc40c),
              style: TextStyle(
                fontSize: BaseStyle.fontSize34,
              ),
              controller: _refundContent,
              onChanged: (String value) {},
              maxLines: 1,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(
                  top: 0.w,
                  bottom: 0.w,
                ),
                hintText: hintText,
                border: InputBorder.none, //去掉输入框的下滑线
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(
                  color: BaseStyle.color999999,
                  fontSize: BaseStyle.fontSize28,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _inkWellBottom() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        color: BaseStyle.colorffc40c,
        padding: EdgeInsets.symmetric(
          vertical: 26.5.w,
        ),
        child: Text(
          '提交',
          style: TextStyle(
            fontSize: BaseStyle.fontSize32,
            color: ktextPrimary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _statusHeight = MediaQuery.of(context).padding.top;
    List<Map<String, dynamic>> _listTile = [
      {'title': '退款原因', 'subtitle': '请选择', 'fun': null, 'isRight': true},
      {'title': '退款方式', 'subtitle': '物业上门取件', 'fun': null, 'isRight': false}
    ];
    return BeeScaffold(
      title: '申请退款',
      leading: IconButton(
        icon: Icon(AntDesign.left, size: 40.sp),
        onPressed: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              _statusHeight,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 24.w),
                    _containerContentList(
                      widget.bundle.getMap('details')['listContent'],
                    ),
                    SizedBox(height: 24.w),
                    RefundTileCard(
                        listTile:
                            widget.bundle.getMap('details')['isRefundGood']
                                ? _listTile
                                : _listTile.take(1).toList()),
                    _containerRefundPrice(
                        widget.bundle.getMap('details')['payPrice']),
                    SizedBox(height: 24.w),
                    _containerRefundTextField(),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: 98.w,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [Expanded(child: _inkWellBottom())]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
