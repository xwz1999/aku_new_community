import 'package:akuCommunity/pages/personal/refund_apply_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:get/get.dart';
import 'widget/refund_shop_card.dart';
import 'widget/refund_tile_card.dart';

class RefundSelectPage extends StatefulWidget {
  final Bundle bundle;
  RefundSelectPage({Key key, this.bundle}) : super(key: key);

  @override
  _RefundSelectPageState createState() => _RefundSelectPageState();
}

class _RefundSelectPageState extends State<RefundSelectPage> {
  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: BaseStyle.colorffd000,
      leading: IconButton(
        icon: Icon(AntDesign.left, size: 40.sp),
        onPressed: () {
          Get.back();
        },
      ),
      centerTitle: true,
      title: Text(
        '选择服务类型',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: BaseStyle.fontSize32,
          color: ktextPrimary,
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _listTile = [
      {
        'title': '我要退款',
        'subtitle': '没有收到货，与物业协商直接退货',
        'fun': () {
          RefundApplyPage(
            bundle: Bundle()
              ..putMap('details', {
                'listContent': widget.bundle.getMap('details')['listContent'],
                'payPrice': widget.bundle.getMap('details')['payPrice'],
                'isRefundGood': false
              }),
          ).to;
        },
        'isRight': true
      },
      {
        'title': '我要退款退货',
        'subtitle': '已收到货，需要退还货物',
        'fun': () {
          RefundApplyPage(
            bundle: Bundle()
              ..putMap('details', {
                'listContent': widget.bundle.getMap('details')['listContent'],
                'payPrice': widget.bundle.getMap('details')['payPrice'],
                'isRefundGood': true
              }),
          ).to;
        },
        'isRight': true
      }
    ];
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          SizedBox(height: 24.w),
          _containerContentList(
            widget.bundle.getMap('details')['listContent'],
          ),
          SizedBox(height: 24.w),
          RefundTileCard(listTile: _listTile)
        ],
      ),
    );
  }
}
