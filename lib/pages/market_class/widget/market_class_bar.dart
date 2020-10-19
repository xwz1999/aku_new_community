import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/search_bar_delegate.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class MarketClassBar extends StatelessWidget {
  Widget _inkWellSearch(BuildContext context) {
    return InkWell(
      onTap: () {
        showSearch(context: context, delegate: searchBarDelegate());
      },
      child: Container(
        margin: EdgeInsets.only(right: Screenutil.length(32)),
        padding: EdgeInsets.only(
            left: Screenutil.length(40),
            top: Screenutil.length(15),
            bottom: Screenutil.length(15)),
        decoration: BoxDecoration(
          color: Color(0xfff3f3f3),
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        child: Row(children: [
          Icon(
            AntDesign.search1,
            size: Screenutil.size(28),
            color: Color(0xff999999),
          ),
          SizedBox(width: 5),
          Text(
            '搜索商品、活动、帖子、应用',
            style: TextStyle(
              fontSize: Screenutil.size(28),
              color: Color(0xff999999),
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Color(0xffffffff),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(AntDesign.left, size: Screenutil.size(40)),
        ),
        centerTitle: true,
        title: _inkWellSearch(context),
      ),
    );
  }
}
