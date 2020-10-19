import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/routers/page_routers.dart';
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
        icon: Icon(AntDesign.left, size: Screenutil.size(40)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        '选择服务类型',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: BaseStyle.fontSize32,
          color: BaseStyle.color333333,
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
          Navigator.pushNamed(context, PageName.refund_apply_page.toString(),
              arguments: Bundle()
                ..putMap('details', {
                  'listContent': widget.bundle.getMap('details')['listContent'],
                  'payPrice': widget.bundle.getMap('details')['payPrice'],
                  'isRefundGood':false
                }));
        },
        'isRight': true
      },
      {
        'title': '我要退款退货',
        'subtitle': '已收到货，需要退还货物',
        'fun': () {
          Navigator.pushNamed(context, PageName.refund_apply_page.toString(),
              arguments: Bundle()
                ..putMap('details', {
                  'listContent': widget.bundle.getMap('details')['listContent'],
                  'payPrice': widget.bundle.getMap('details')['payPrice'],
                  'isRefundGood':true
                }));
        },
        'isRight': true
      }
    ];
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          SizedBox(height: Screenutil.length(24)),
          _containerContentList(
            widget.bundle.getMap('details')['listContent'],
          ),
          SizedBox(height: Screenutil.length(24)),
          RefundTileCard(listTile: _listTile)
        ],
      ),
    );
  }
}
