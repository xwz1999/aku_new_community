// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:akuCommunity/extensions/page_router.dart';
import 'package:akuCommunity/pages/market/market_cart_page/market_cart_page.dart';
import 'package:akuCommunity/provider/cart.dart';
import 'package:akuCommunity/widget/goods_specs_sheet.dart';

class GoodsDetailsBottomBar extends StatefulWidget {
  final String itemid, itemtitle, itemprice, itempic;
  GoodsDetailsBottomBar(
      {Key key, this.itemid, this.itemtitle, this.itemprice, this.itempic})
      : super(key: key);

  @override
  _GoodsDetailsBottomBarState createState() => _GoodsDetailsBottomBarState();
}

class _GoodsDetailsBottomBarState extends State<GoodsDetailsBottomBar> {
  int count = 1;
  bool _isCollected = false;
  void _showModelBotoomSheet(String type) {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return GoodsSpecsSheet(
          itemid: widget.itemid,
          itemtitle: widget.itemtitle,
          itempic: widget.itempic,
          itemprice: widget.itemprice,
          type: type,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvidde>(builder: (context, model, child) {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          left: 35.w,
          right: 35.w,
          top: 13.w,
          bottom: 47.w,
        ),
        child: Row(
          children: [
            InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _isCollected
                      ? Icon(
                          AntDesign.star,
                          color: Colors.red,
                          size: 38.sp,
                        )
                      : Icon(
                          AntDesign.staro,
                          color: Color(0xff000000),
                          size: ScreenUtil().setSp(38),
                        ),
                  SizedBox(height: 2),
                  Text(
                    '收藏',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        color: Color(0xff999999)),
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  _isCollected = !_isCollected;
                });
              },
            ),
            SizedBox(width: 46.w),
            InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    AntDesign.shoppingcart,
                    color: Color(0xff000000),
                    size: ScreenUtil().setSp(38),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '购物车',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        color: Color(0xff999999)),
                  )
                ],
              ),
              onTap: () {
                MarketCartPage().to();
              },
            ),
            SizedBox(width: 53.w),
            InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff36373b),
                    borderRadius: BorderRadius.all(Radius.circular(33)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color(0xff36373b).withOpacity(0.3),
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 12.w,
                  ),
                  child: Text(
                    '加入购物车',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                onTap: () {
                  _showModelBotoomSheet('加入购物车');
                }

                // () {
                //   _showModelBotoomSheet();
                //   // await model.save(widget.itemid, widget.itemtitle, count,
                //   //     widget.itemprice, widget.itempic);
                // } //_showModelBotoomSheet,
                ),
            SizedBox(width: 24.w),
            InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffc40c),
                    borderRadius: BorderRadius.all(Radius.circular(33)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color(0xffffc40c),
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 55.w,
                    vertical: 12.w,
                  ),
                  child: Text(
                    '立即购买',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Color(0xff333333),
                    ),
                  ),
                ),
                onTap: () {
                  _showModelBotoomSheet('立即购买');
                } //_showModelBotoomSheet,
                ),
          ],
        ),
      );
    });
  }
}
