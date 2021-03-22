import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'package:akuCommunity/pages/invoice/invoice_page.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

// import 'package:akuCommunity/widget/cart_count.dart';

class ConfirmContent extends StatelessWidget {
  final Map cartMap;
  ConfirmContent({Key key, this.cartMap}) : super(key: key);

  Widget _cartHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedImageWrapper(
          url: cartMap["itempic"],
          height: 210.w,
          width: 210.w,
        ),
        SizedBox(width: 20.w),
        Column(
          children: [
            Container(
              width: 288.w,
              child: Text(
                cartMap["itemtitle"],
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xff333333),
                ),
              ),
            ),
            SizedBox(height: 10.w),
            Container(
              width: 280.w,
              padding: EdgeInsets.all(10.w),
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
                  fontSize: 20.sp,
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
              fontSize: 24.sp,
              color: Color(0xff999999),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            '合计:￥${(double.parse(cartMap["itemprice"]) * cartMap["count"]).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24.sp,
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
            fontSize: 24.sp,
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
      top: 38.w,
      child: Container(
        child: Text(
          'x${cartMap["count"]}',
          style: TextStyle(
            fontSize: 20.sp,
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
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 32.w,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              _cartHeader(),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 30.w,
                  right: 12.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 56.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '配送方式',
                            style: TextStyle(
                                fontSize: 28.sp, color: Color(0xff333333)),
                          ),
                          SizedBox(width: 26.w),
                          Text(
                            '普通配送',
                            style: TextStyle(
                                fontSize: 28.sp, color: Color(0xff999999)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 56.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '开具发票',
                            style: TextStyle(
                                fontSize: 28.sp, color: Color(0xff333333)),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(InvoicePage(
                                bundle: Bundle()
                                  ..putString('title', '1123123123123'),
                              ));
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 80.w,
                                  width: 353.w,
                                  child: Text(
                                    '增值税电子普通发票-明显-企业-宁波阿库旅游有限公司',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Icon(
                                  AntDesign.right,
                                  size: 30.sp,
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
                        top: 56.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '订单备注',
                            style: TextStyle(
                                fontSize: 28.sp, color: Color(0xff333333)),
                          ),
                          SizedBox(width: 14.w),
                          Text(
                            '选填',
                            style: TextStyle(
                                fontSize: 28.sp, color: Color(0xff999999)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 104.w),
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
