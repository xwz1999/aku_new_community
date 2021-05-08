import 'package:aku_community/base/base_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '分类',
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.search),
          onPressed: () {},
        ),
      ],
      bgColor: Colors.white,
      appBarBottom: PreferredSize(
        child: Divider(height: 1),
        preferredSize: Size.fromHeight(1),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 203.w,
            child: ListView.builder(
              itemBuilder: (context, index) {
                bool sameIndex = index == _index;
                return Stack(
                  children: [
                    MaterialButton(
                      height: 100.w,
                      minWidth: double.infinity,
                      onPressed: () {
                        _index = index;
                        setState(() {});
                      },
                      child: Text(
                        'TEST',
                        style: TextStyle(
                          color: sameIndex ? kPrimaryColor : ktextPrimary,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      left: sameIndex ? 0 : -8.w,
                      top: sameIndex ? 20.w : 10.w,
                      bottom: sameIndex ? 20.w : 10.w,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                      child: Container(
                        color: kPrimaryColor,
                        width: 8.w,
                        height: 40.w,
                      ),
                    ),
                  ],
                );
              },
              itemCount: 10,
            ),
          ),
          VerticalDivider(
            color: Color(0xFFE8E8E8),
            width: 1,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
