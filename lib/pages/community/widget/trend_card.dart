
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/expandable_text.dart';
import 'package:akuCommunity/widget/image_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TrendCard extends StatefulWidget {
  final String name;
  final String content;
  final List<String> imageUrl;
  final bool isLike;
  final Image avatar;
  TrendCard({Key key, this.name, this.content, this.imageUrl, this.isLike, this.avatar})
      : super(key: key);

  @override
  _TrendCardState createState() => _TrendCardState();
}

class _TrendCardState extends State<TrendCard> {
  bool _isLike;
  @override
  void initState() { 
    super.initState();
    _isLike=widget.isLike??false;
  }
  void _showDialog(String url) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            '是否$url\?',
            style: TextStyle(
              fontSize: 34.sp,
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 34.sp,
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '确定',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 34.sp,
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void showPub() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return _shareWidget();
        });
  }

  Widget _shareWidget() {
    return Container(
      color: Colors.white,
      height:
          300.w + MediaQuery.of(context).viewPadding.bottom,
      child: Stack(
        children: [
          Container(
            height: 160.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.back();
                    _showDialog(nameItems[index]['title']);
                  },
                  child: Container(
                    height: 160.w,
                    width: 160.w,
                    margin: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      top: 40.w,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          nameItems[index]['image'],
                          width: 65.w,
                          height: 65.w,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.w),
                          child: Text(
                            nameItems[index]['title'],
                            style: TextStyle(
                              fontSize: 26.sp,
                              color: Color(0xff333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: nameItems.length,
            ),
          ),
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 98.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 1),
                      blurRadius: 2.0,
                    )
                  ],
                ),
                child: Text(
                  '取消',
                  style: TextStyle(
                    fontSize: 38.sp,
                    color: Color(0xff333333),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> nameItems = [
    {'image': 'assets/icons/report.png', 'title': '举报'},
    {'image': 'assets/icons/shield_content.png', 'title': '屏蔽此条动态'},
    {'image': 'assets/icons/shield_user.png', 'title': '屏蔽他的动态'},
  ];

  TextStyle _textStyleName() {
    return TextStyle(
      fontSize: 36.sp,
      color: Color(0xff333333),
    );
  }

  TextStyle _textStyleContent() {
    return TextStyle(
      fontSize: 32.sp,
      color: Color(0xff333333),
    );
  }

  TextStyle _textStyleTag() {
    return TextStyle(
      fontSize: 28.sp,
      color: Color(0xff999999),
    );
  }



  Widget _columnCard(String name, String content,Image avatar) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 86.w,
                  height: 86.w,
                  child: avatar,
                ),
                SizedBox(width: 9.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        name,
                        style: _textStyleName(),
                      ),
                    ),
                    SizedBox(height: 6.w),
                    Container(
                      padding: EdgeInsets.only(left: 14.w),
                      child: ExpandableText(
                        text: content,
                        maxLines: 2,
                        style: _textStyleContent(),
                        expand: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.w),
            Padding(
              padding: EdgeInsets.only(left: 95.w),
              child: Column(
                children: [
                  ImageGrid(widget.imageUrl),
                  SizedBox(height: 20.w),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '1分钟前',
                            style: _textStyleTag(),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isLike = !_isLike;
                            });
                            
                          },
                          child: Icon(
                            _isLike ? AntDesign.heart : AntDesign.hearto,
                            color:
                                _isLike ? Color(0xffff6666) : Color(0xffd8d8d8),
                            size: 36.sp,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 35,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            AntDesign.message1,
                            color: Color(0xffd8d8d8),
                            size: 36.sp,
                          ),
                        ),
                      ),
                      // _positionedPopupMenuButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: 0,
          child: InkWell(
            onTap: showPub,
            child: Icon(
              MaterialIcons.more,
              color: Color(0xffd8d8d8),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5, //宽度
            color: Color(0xffe5e5e5), //边框颜色
          ),
        ),
      ),
      padding: EdgeInsets.only(
        top: 46.w,
        left: 32.w,
        bottom: 22.w,
        right: 32.w,
      ),
      child: _columnCard(widget.name, widget.content,widget.avatar)
    );
  }
}
