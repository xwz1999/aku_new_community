
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/expandable_text.dart';
import 'package:akuCommunity/widget/image_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            '是否${url}?',
            style: TextStyle(
              fontSize: Screenutil.size(34),
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: Screenutil.size(34),
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '确定',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Screenutil.size(34),
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
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
          Screenutil.length(300) + MediaQuery.of(context).viewPadding.bottom,
      child: Stack(
        children: [
          Container(
            height: Screenutil.length(160),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showDialog(nameItems[index]['title']);
                  },
                  child: Container(
                    height: Screenutil.length(160),
                    width: Screenutil.length(160),
                    margin: EdgeInsets.only(
                      left: Screenutil.length(10),
                      right: Screenutil.length(10),
                      top: Screenutil.length(40),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          nameItems[index]['image'],
                          width: Screenutil.length(65),
                          height: Screenutil.length(65),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Screenutil.length(10)),
                          child: Text(
                            nameItems[index]['title'],
                            style: TextStyle(
                              fontSize: Screenutil.size(26),
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
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: Screenutil.length(98),
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
                    fontSize: Screenutil.size(38),
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
      fontSize: Screenutil.size(36),
      color: Color(0xff333333),
    );
  }

  TextStyle _textStyleContent() {
    return TextStyle(
      fontSize: Screenutil.size(32),
      color: Color(0xff333333),
    );
  }

  TextStyle _textStyleTag() {
    return TextStyle(
      fontSize: Screenutil.size(28),
      color: Color(0xff999999),
    );
  }

  TextStyle _textStylePopup() {
    return TextStyle(
      fontSize: Screenutil.size(28),
      color: Color(0xff333333),
    );
  }

  Positioned _positionedPopupMenuButton() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: PopupMenuButton(
        color: Colors.transparent,
        padding: EdgeInsets.all(0),
        elevation: 0,
        offset: Offset(0, -53),
        child: Container(
          width: Screenutil.length(54),
          decoration: BoxDecoration(
            color: Color(0xffd8d8d8),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Icon(
            Feather.more_horizontal,
            color: Colors.white,
            size: Screenutil.size(36),
          ),
        ),
        onSelected: (String value) {
          setState(() {});
        },
        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem(
            value: "选项一的内容",
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffd8d8d8),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      print('赞');
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: Screenutil.length(68),
                      width: Screenutil.length(181),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            AntDesign.hearto,
                            size: Screenutil.size(30),
                            color: Color(0xff000000),
                          ),
                          SizedBox(width: Screenutil.length(11)),
                          Text(
                            '赞',
                            style: _textStylePopup(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1,
                    height: Screenutil.length(48),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xff979797)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('评论');
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: Screenutil.length(68),
                      width: Screenutil.length(181),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Feather.message_square,
                            size: Screenutil.size(30),
                            color: Color(0xff000000),
                          ),
                          SizedBox(width: Screenutil.length(11)),
                          Text(
                            '评论',
                            style: _textStylePopup(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
                SizedBox(width: Screenutil.length(9)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: Screenutil.length(10)),
                      child: Text(
                        name,
                        style: _textStyleName(),
                      ),
                    ),
                    SizedBox(height: Screenutil.length(6)),
                    Container(
                      padding: EdgeInsets.only(left: Screenutil.length(14)),
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
            SizedBox(height: Screenutil.length(20)),
            Padding(
              padding: EdgeInsets.only(left: Screenutil.length(95)),
              child: Column(
                children: [
                  ImageGrid(widget.imageUrl),
                  SizedBox(height: Screenutil.length(20)),
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
                            size: Screenutil.size(36),
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
                            size: Screenutil.size(36),
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
        top: Screenutil.length(46),
        left: Screenutil.length(32),
        bottom: Screenutil.length(22),
        right: Screenutil.length(32),
      ),
      child: _columnCard(widget.name, widget.content,widget.avatar)
    );
  }
}
