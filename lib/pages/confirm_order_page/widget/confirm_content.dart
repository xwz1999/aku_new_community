import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/routers/page_routers.dart';
// import 'package:akuCommunity/widget/cart_count.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class ConfirmContent extends StatelessWidget {
  final Map cartMap;
  ConfirmContent({Key key, this.cartMap}) : super(key: key);

  Widget _cartHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedImageWrapper(
          url: cartMap["itempic"],
          height: Screenutil.length(210),
          width: Screenutil.length(210),
        ),
        SizedBox(width: Screenutil.length(20)),
        Column(
          children: [
            Container(
              width: Screenutil.length(288),
              child: Text(
                cartMap["itemtitle"],
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: Screenutil.size(24),
                  color: Color(0xff333333),
                ),
              ),
            ),
            SizedBox(height: Screenutil.length(10)),
            Container(
              width: Screenutil.length(280),
              padding: EdgeInsets.all(Screenutil.length(10)),
              decoration: BoxDecoration(
                color: Color(0xfff0f0f0),
                borderRadius: BorderRadius.all(Radius.circular(2)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xfff0f0f0),
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Text(
                cartMap["itemtitle"],
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: Screenutil.size(20),
                  color: Color(0xff666666),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cartFooter() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Row(
        children: [
          Text(
            '共计${cartMap["count"]}件',
            style: TextStyle(
              fontSize: Screenutil.size(24),
              color: Color(0xff999999),
            ),
          ),
          SizedBox(width: Screenutil.length(10)),
          Text(
            '合计:￥${(double.parse(cartMap["itemprice"]) * cartMap["count"]).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: Screenutil.size(24),
              color: Color(0xffe60e0e),
            ),
          )
        ],
      ),
    );
  }

  Widget _cartPrice() {
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        child: Text(
          '￥${cartMap["itemprice"]}',
          style: TextStyle(
            fontSize: Screenutil.size(24),
            color: Color(0xffe60e0e),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _cartNum() {
    return Positioned(
      right: 0,
      top: Screenutil.length(38),
      child: Container(
        child: Text(
          'x${cartMap["count"]}',
          style: TextStyle(
            fontSize: Screenutil.size(20),
            color: Color(0xff999999),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.symmetric(horizontal: Screenutil.length(32)),
      padding: EdgeInsets.symmetric(
        horizontal: Screenutil.length(20),
        vertical: Screenutil.length(32),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              _cartHeader(),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: Screenutil.length(30),
                  right: Screenutil.length(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: Screenutil.length(56),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '配送方式',
                            style: TextStyle(
                                fontSize: Screenutil.size(28),
                                color: Color(0xff333333)),
                          ),
                          SizedBox(width: Screenutil.length(26)),
                          Text(
                            '普通配送',
                            style: TextStyle(
                                fontSize: Screenutil.size(28),
                                color: Color(0xff999999)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: Screenutil.length(56),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '开具发票',
                            style: TextStyle(
                                fontSize: Screenutil.size(28),
                                color: Color(0xff333333)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageName.invoice_page.toString(),
                                  arguments: Bundle()
                                    ..putString('title', '1123123123123'));
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: Screenutil.length(80),
                                  width: Screenutil.length(353),
                                  child: Text(
                                    '增值税电子普通发票-明显-企业-宁波阿库旅游有限公司',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: Screenutil.size(28),
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Screenutil.length(10)),
                                Icon(
                                  AntDesign.right,
                                  size: Screenutil.size(30),
                                  color: Color(0xff999999),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: Screenutil.length(56),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '订单备注',
                            style: TextStyle(
                                fontSize: Screenutil.size(28),
                                color: Color(0xff333333)),
                          ),
                          SizedBox(width: Screenutil.length(14)),
                          Text(
                            '选填',
                            style: TextStyle(
                                fontSize: Screenutil.size(28),
                                color: Color(0xff999999)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Screenutil.length(104)),
            ],
          ),
          _cartFooter(),
          _cartPrice(),
          _cartNum(),
        ],
      ),
    );
  }
}
