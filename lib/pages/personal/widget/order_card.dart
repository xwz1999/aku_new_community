import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/personal/evaluate_good_page.dart';
import 'package:akuCommunity/pages/personal/look_logistics_page.dart';
import 'package:akuCommunity/pages/personal/order_details_page.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';

class OrderCard extends StatefulWidget {
  final String status;
  final double totalPrice, payPrice;
  final List<Map<String, dynamic>> listButton, listContent, listOrderDetail;
  OrderCard(
      {Key key,
      this.status,
      this.totalPrice,
      this.payPrice,
      this.listButton,
      this.listContent,
      this.listOrderDetail})
      : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Container _containerStatus(String status) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 13.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffd8d8d8), width: 0.5)),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: BaseStyle.fontSize28,
          color: ktextPrimary,
        ),
      ),
    );
  }

  Container _containerContent(
      String imagePath, content, specs, double price, int shopNum) {
    return Container(
      margin: EdgeInsets.only(top: 24.w),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                height: 179.w,
                width: 173.w,
                fit: BoxFit.fill,
              ),
              SizedBox(width: 24.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 262.w,
                    child: Text(
                      content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: BaseStyle.fontSize28,
                        color: ktextPrimary,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    specs,
                    style: TextStyle(
                      fontSize: BaseStyle.fontSize28,
                      color: BaseStyle.color999999,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 8.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '￥$price',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: BaseStyle.fontSize28,
                    color: ktextPrimary,
                  ),
                ),
                Text(
                  'x$shopNum',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    color: BaseStyle.color999999,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _containerContentList(List<Map<String, dynamic>> listContent) {
    return Container(
      child: Column(
        children: listContent
            .map((item) => _containerContent(
                  item['imagePath'],
                  item['content'],
                  item['specs'],
                  item['price'],
                  item['shopNum'],
                ))
            .toList(),
      ),
    );
  }

  Container _containerPayInfo(double totalPrice, payPrice) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '总价￥$totalPrice',
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: BaseStyle.color999999,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            '实付款￥$payPrice',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize28,
              color: ktextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  InkWell _inkWellButton(String buttonName) {
    Color buttonColor;
    switch (buttonName) {
      case '确认收货':
      case '评价':
      case '付款':
        buttonColor = BaseStyle.colorff8500;
        break;
      default:
        buttonColor = BaseStyle.color999999;
    }
    return InkWell(
      onTap: () {
        switch (buttonName) {
          case '评价':
            EvaluateGoodPage(
              bundle: Bundle()
                ..putMap('details', {
                  'listContent': widget.listContent,
                }),
            ).to;
            break;
          case '查看物流':
            LookLogisticsPage().to;
            break;
          default:
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w),
        alignment: Alignment.center,
        width: 171.w,
        height: 60.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: buttonColor, width: 1),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            fontSize: BaseStyle.fontSize28,
            color: buttonColor,
          ),
        ),
      ),
    );
  }

  Container _containerButtonList(List<Map<String, dynamic>> listButton) {
    return Container(
      margin: EdgeInsets.only(
        top: 42.w,
        right: 8.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: listButton
            .map((item) => _inkWellButton(item['buttonName']))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        OrderDetailsPage(
          bundle: Bundle()
            ..putMap('details', {
              'status': widget.status,
              'listContent': widget.listContent,
              'totalPrice': widget.totalPrice,
              'payPrice': widget.payPrice,
              'listButton': widget.listButton,
              'listOrderDetail': widget.listOrderDetail,
            }),
        ).to;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: Offset(1, 1),
                blurRadius: 10.0),
          ],
        ),
        padding: EdgeInsets.only(
          top: 18.w,
          left: 20.w,
          right: 16.w,
          bottom: 42.w,
        ),
        margin: EdgeInsets.only(
          top: 24.w,
          left: 32.w,
          right: 32.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _containerStatus(widget.status),
            _containerContentList(widget.listContent),
            _containerPayInfo(
              widget.totalPrice,
              widget.payPrice,
            ),
            widget.listButton.length != 0
                ? _containerButtonList(widget.listButton)
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
