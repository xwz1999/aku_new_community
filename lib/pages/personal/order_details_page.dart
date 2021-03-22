import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:extended_text/extended_text.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/personal/refund_select_page.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class OrderDetailsPage extends StatefulWidget {
  final Bundle bundle;
  OrderDetailsPage({Key key, this.bundle}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  Container _containerHeader(String status) {
    return Container(
      width: double.infinity,
      color: Color(0xffffd000),
      padding: EdgeInsets.only(
        top: 44.w,
        bottom: 44.w,
        left: 33.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize32,
              color: ktextPrimary,
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            '还剩9小时33分自动确认',
            style: TextStyle(
              fontSize: BaseStyle.fontSize24,
              color: ktextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Container _containerAddress() {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.only(
        left: 32.w,
        top: 24.w,
        bottom: 24.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AssetsImage.LOCATION,
            height: 78.w,
            width: 78.w,
          ),
          SizedBox(width: 24.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '马泽鹏',
                    style: TextStyle(
                      fontSize: BaseStyle.fontSize28,
                      color: ktextPrimary,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    '18809801254',
                    style: TextStyle(
                      fontSize: BaseStyle.fontSize24,
                      color: BaseStyle.color999999,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.w),
              Container(
                width: 584.w,
                child: ExtendedText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '浙江省 宁波市 江北区 工程学院阿库旅游6楼606室',
                        style: TextStyle(
                            fontSize: BaseStyle.fontSize28,
                            color: BaseStyle.color999999,
                            height: 1.5),
                      )
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InkWell _inkWellRefund(
      List<Map<String, dynamic>> listContent, double payPrice) {
    return InkWell(
      onTap: () {
        RefundSelectPage(
          bundle: Bundle()
            ..putMap('details', {
              'listContent': listContent,
              'payPrice': payPrice,
            }),
        ).to;
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6.w),
        width: 134.w,
        decoration: BoxDecoration(
          border: Border.all(color: BaseStyle.color999999, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        child: Text(
          '退款',
          style: TextStyle(fontSize: BaseStyle.fontSize28, color: ktextPrimary),
        ),
      ),
    );
  }

  Container _containerContent(
    String imagePath,
    content,
    specs,
    double price,
    payPrice,
    int shopNum,
    List<Map<String, dynamic>> listContent,
  ) {
    return Container(
      child: Stack(
        children: [
          Column(
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
                        width: 252.w,
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
              SizedBox(height: 73.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 25.w),
                    child: Text(
                      '实付款￥$payPrice',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: BaseStyle.fontSize28,
                        color: BaseStyle.colorff8500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 23.w,
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
          Positioned(
            top: 103.w,
            right: 0,
            child: _inkWellRefund(listContent, payPrice),
          ),
        ],
      ),
    );
  }

  Container _containerContentList(
      List<Map<String, dynamic>> listContent, double payPrice) {
    return Container(
      color: Color(0xffffffff),
      margin: EdgeInsets.only(top: 32.w),
      padding: EdgeInsets.only(
        top: 32.w,
        left: 32.w,
        right: 32.w,
        bottom: 24.w,
      ),
      child: Column(
        children: listContent
            .map((item) => _containerContent(
                item['imagePath'],
                item['content'],
                item['specs'],
                item['price'],
                payPrice,
                item['shopNum'],
                listContent))
            .toList(),
      ),
    );
  }

  Container _containerOrderDetail(List<Map<String, dynamic>> listOrderDetail) {
    return Container(
      color: Color(0xffffffff),
      width: double.infinity,
      margin: EdgeInsets.only(top: 24.w),
      padding: EdgeInsets.only(
        top: 32.w,
        left: 31.w,
        bottom: 39.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '订单信息',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: BaseStyle.fontSize28,
                color: ktextPrimary),
          ),
          Column(
            children: listOrderDetail
                .map((item) => Container(
                      margin: EdgeInsets.only(top: 22.w),
                      child: Row(
                        children: [
                          Text(
                            item['title'],
                            style: TextStyle(
                                fontSize: BaseStyle.fontSize24,
                                color: BaseStyle.color999999),
                          ),
                          SizedBox(width: 75.w),
                          Text(
                            item['subtitle'],
                            style: TextStyle(
                                fontSize: BaseStyle.fontSize24,
                                color: BaseStyle.color999999),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  InkWell _inkWellBottom(String title, Color color, Color fontColor) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        color: color,
        padding: EdgeInsets.symmetric(
          vertical: 26.5.w,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: BaseStyle.fontSize32,
            color: fontColor,
          ),
        ),
      ),
    );
  }

  Positioned _positionedBottomBar(String status) {
    List<Map<String, dynamic>> _listBottom;
    switch (status) {
      case '等待买家付款':
        _listBottom = [
          {
            'title': '修改地址',
            'color': Color(0xff2a2a2a),
            'fontColor': Color(0xffffffff),
          },
          {
            'title': '付款',
            'color': Color(0xffffc40c),
            'fontColor': Color(0xff333333),
          },
        ];
        break;
      case '买家已付款':
        _listBottom = [
          {
            'title': '申请退款',
            'color': Color(0xffffc40c),
            'fontColor': Color(0xff333333),
          },
        ];
        break;
      case '卖家已发货':
        _listBottom = [
          {
            'title': '查看物流',
            'color': Color(0xff2a2a2a),
            'fontColor': Color(0xffffffff),
          },
          {
            'title': '确认收货',
            'color': Color(0xffffc40c),
            'fontColor': Color(0xff333333),
          },
        ];
        break;
      case '退款中':
        _listBottom = [
          {
            'title': '查看物流',
            'color': Color(0xff2a2a2a),
            'fontColor': Color(0xffffffff),
          },
        ];
        break;
      case '交易成功':
        _listBottom = [
          {
            'title': '查看物流',
            'color': Color(0xff2a2a2a),
            'fontColor': Color(0xffffffff),
          },
          {
            'title': '申请售后',
            'color': Color(0xffffc40c),
            'fontColor': Color(0xff333333),
          },
        ];
        break;
      default:
        _listBottom = [];
        break;
    }
    return Positioned(
      bottom: 0,
      child: Container(
        alignment: Alignment.center,
        height: 98.w,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: _listBottom
              .map((item) => Expanded(
                    child: _inkWellBottom(
                      item['title'],
                      item['color'],
                      item['fontColor'],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top;
    return BeeScaffold(
      leading: IconButton(
        icon: Icon(AntDesign.left, size: 40.sp),
        onPressed: () {
          Get.back();
        },
      ),
      title: '订单详情',
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              statusHeight,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _containerHeader(widget.bundle.getMap('details')['status']),
                  _containerAddress(),
                  _containerContentList(
                    widget.bundle.getMap('details')['listContent'],
                    widget.bundle.getMap('details')['payPrice'],
                  ),
                  _containerOrderDetail(
                      widget.bundle.getMap('details')['listOrderDetail']),
                ],
              ),
              _positionedBottomBar(widget.bundle.getMap('details')['status'])
            ],
          ),
        ),
      ),
    );
  }
}
