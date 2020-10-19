import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/search_bar_delegate.dart';

class ApplicationsBar extends StatelessWidget {
  const ApplicationsBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            AntDesign.left,
            size: Screenutil.size(45),
            color: Color(0xff333333),
          ),
        ),
        centerTitle: true,
        title: InkWell(
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
        ),
      ),
    );
  }
}
