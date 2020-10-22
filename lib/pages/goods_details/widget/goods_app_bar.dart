import 'package:akuCommunity/routers/page_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:fluwx/fluwx.dart';

class GoodsAppBar extends StatefulWidget {
  final String shareImg;
  final String title;
  GoodsAppBar({Key key, @required this.shareImg, @required this.title})
      : super(key: key);

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
        icon: Icon(AntDesign.left, size: Screenutil.size(40)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Screenutil.length(40),
          vertical: Screenutil.length(15),
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
            size: Screenutil.size(40),
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
            size: Screenutil.size(40),
            color: Color(0xff666666),
          ),
          onPressed: () {
            Navigator.pushNamed(context, PageName.market_cart_page.toString());
          },
        ),
      ],
    );
  }
}
