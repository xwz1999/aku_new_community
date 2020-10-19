import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/search_bar_delegate.dart';

class HomeSearch extends StatefulWidget {
  HomeSearch({Key key}) : super(key: key);

  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xffffd000), Color(0xffffbd00)],
        ),
      ),
      padding: EdgeInsets.only(
        top: Screenutil.length(9),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
        bottom: Screenutil.length(17),
      ),
      child: InkWell(
        onTap: () {
          showSearch(context: context, delegate: searchBarDelegate());
        },
        child: Container(
          width: Screenutil.length(686),
          height: Screenutil.length(72),
          padding: EdgeInsets.only(
            top: Screenutil.length(16),
            bottom: Screenutil.length(16),
            left: Screenutil.length(24),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(Screenutil.length(36))),
          ),
          child: Row(children: [
            Icon(
              AntDesign.search1,
              color: Color(0xff999999),
              size: Screenutil.size(28),
            ),
            SizedBox(width: Screenutil.length(16)),
            Text(
              '搜索商品、活动、帖子、应用',
              style: TextStyle(
                fontSize: Screenutil.size(28),
                color: Color(0xff999999),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
