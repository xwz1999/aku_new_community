import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/screenutil.dart';

class GoodsAppBar extends StatefulWidget {
  GoodsAppBar({Key key}) : super(key: key);

  @override
  _GoodsAppBarState createState() => _GoodsAppBarState();
}

class _GoodsAppBarState extends State<GoodsAppBar> {
  List<Map<String, dynamic>> actionsList = [
    {'icon': SimpleLineIcons.share, 'size': 40, 'funtion': null},
    {'icon': AntDesign.shoppingcart, 'size': 48, 'funtion': null}
  ];

  List<Widget> _listActions() {
    return actionsList
        .map((item) => IconButton(
              icon: Icon(
                item['icon'],
                size: Screenutil.size(item['size'].toDouble()),
                color: Color(0xff666666),
              ),
              onPressed: () {},
            ))
        .toList();
  }

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
      actions: _listActions(),
    );
  }
}
