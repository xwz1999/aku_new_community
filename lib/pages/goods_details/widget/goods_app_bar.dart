import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/market/market_cart_page/market_cart_page.dart';
import 'package:akuCommunity/utils/headers.dart';

class GoodsAppBar extends StatefulWidget {
  final String shareImg;
  final String title;
  GoodsAppBar({Key key, this.shareImg, this.title}) : super(key: key);

  @override
  _GoodsAppBarState createState() => _GoodsAppBarState();
}

class _GoodsAppBarState extends State<GoodsAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(AntDesign.left, size: 40.sp),
        onPressed: () {
          Get.back();
        },
      ),
      title: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 15.w,
        ),
        decoration: BoxDecoration(
          color: Color(0xfff3f3f3),
          borderRadius: BorderRadius.all(Radius.circular(34)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Color(0xfff3f3f3), offset: Offset(1, 1)),
          ],
        ),
        child: InkWell(
          onTap: () {},
          child: Container(
            child: Row(children: [
              Icon(
                AntDesign.search1,
                size: BaseStyle.fontSize30,
                color: BaseStyle.color999999,
              ),
              SizedBox(width: 5),
              Text(
                '搜索宝贝',
                style: TextStyle(
                  fontSize: BaseStyle.fontSize28,
                  color: BaseStyle.color999999,
                ),
              )
            ]),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            SimpleLineIcons.share,
            size: 40.sp,
            color: Color(0xff666666),
          ),
          onPressed: () {
            shareToWeChat(WeChatShareWebPageModel(
              'https://mobile.baidu.com/item?docid=27505288',
              thumbnail: WeChatImage.network(widget.shareImg),
              title: widget.title,
              description: '前往小蜜蜂智慧社区查看吧',
            ));
          },
        ),
        IconButton(
          icon: Icon(
            AntDesign.shoppingcart,
            size: 40.sp,
            color: Color(0xff666666),
          ),
          onPressed: () {
            MarketCartPage().to();
          },
        ),
      ],
    );
  }
}
