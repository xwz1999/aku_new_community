import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/routers/page_routers.dart';
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
        '申请退款',
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

  Container _containerRefundPrice(double payPrice) {
    return Container(
      padding: EdgeInsets.only(
        top: Screenutil.length(22),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(bottom: Screenutil.length(26)),
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
                color: BaseStyle.color333333,
              ),
            ),
            Text(
              '￥${payPrice}',
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
        top: Screenutil.length(22),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(bottom: Screenutil.length(26)),
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
                color: BaseStyle.color333333,
              ),
            ),
            SizedBox(height: Screenutil.length(23)),
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
                  top: Screenutil.length(0),
                  bottom: Screenutil.length(0),
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
          vertical: Screenutil.length(26.5),
        ),
        child: Text(
          '提交',
          style: TextStyle(
            fontSize: BaseStyle.fontSize32,
            color: BaseStyle.color333333,
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
    return Scaffold(
      appBar: _appBar(),
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
                    SizedBox(height: Screenutil.length(24)),
                    _containerContentList(
                      widget.bundle.getMap('details')['listContent'],
                    ),
                    SizedBox(height: Screenutil.length(24)),
                    RefundTileCard(
                        listTile:
                            widget.bundle.getMap('details')['isRefundGood']
                                ? _listTile
                                : _listTile.take(1).toList()),
                    _containerRefundPrice(
                        widget.bundle.getMap('details')['payPrice']),
                    SizedBox(height: Screenutil.length(24)),
                    _containerRefundTextField(),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: Screenutil.length(98),
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
