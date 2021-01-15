import 'dart:ui';
import 'package:akuCommunity/base/base_style.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/expandable_text.dart';
import 'package:akuCommunity/widget/image_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:akuCommunity/extensions/num_ext.dart';

class TrendCard extends StatefulWidget {
  final String name;
  final String content;
  final List<String> imageUrl;
  final bool isLike;
  final Image avatar;
  TrendCard(
      {Key key,
      this.name,
      this.content,
      this.imageUrl,
      this.isLike,
      this.avatar})
      : super(key: key);

  @override
  _TrendCardState createState() => _TrendCardState();
}

class _TrendCardState extends State<TrendCard> {
  bool _isLike;
  @override
  void initState() {
    super.initState();
    _isLike = widget.isLike ?? false;
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

  void _showDeletDialog() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: '你确定删除吗?'.text.black.size(34.sp).isIntrinsic.make(),
            actions: <Widget>[
              CupertinoDialogAction(
                child: '取消'.text.black.size(34.sp).isIntrinsic.make(),
                onPressed: () {
                  Get.back();
                },
              ),
              CupertinoDialogAction(
                child: '确定'
                    .text
                    .color(Color(0xFFFF8200))
                    .size(34.sp)
                    .isIntrinsic
                    .make(),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        });
  }

  Widget _columnCard(String name, String content, Image avatar) {
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
                          40.wb,
                          InkWell(
                              onTap: () {
                                _showDeletDialog();
                              },
                              child: '删除'.text.black.size(28.sp).make()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Builder(
            builder: (context) {
              return InkWell(
                onTap: () => BotToast.showAttachedWidget(
                  attachedBuilder: (CancelFunc cancelFunc) {
                    return Material(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD8D8D8),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.w, horizontal: 30.w),
                        width: 363.w,
                        height: 78.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _isLike = !_isLike;
                                  cancelFunc();
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _isLike
                                          ? AntDesign.heart
                                          : AntDesign.hearto,
                                      color: _isLike
                                          ? Color(0xffff6666)
                                          : Colors.black,
                                      size: 32.w,
                                    ),
                                    10.wb,
                                    '赞'
                                        .text
                                        .color(ktextPrimary)
                                        .size(28.sp)
                                        .make(),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: VerticalDivider(
                                width: 0,
                                thickness: 1.w,
                                color: Color(0xFF979797),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.ellipses_bubble,
                                      color: Colors.black,
                                      size: 32.w,
                                    ),
                                    10.wb,
                                    '评论'
                                        .text
                                        .color(ktextPrimary)
                                        .size(28.sp)
                                        .make(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  preferDirection: PreferDirection.rightCenter,
                  targetContext: context,
                ),
                child: Icon(
                  MaterialIcons.more,
                  color: Color(0xffd8d8d8),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: PopupMenuButton<int>(
            onSelected: (value) {
              switch (value) {
                case 0:
                  BotToast.showText(text: '举报成功');
                  break;
                default:
              }
            },
            padding: EdgeInsets.zero,
            icon: Icon(
              CupertinoIcons.chevron_down,
              size: 25.w,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Container(
                    width: 150.w,
                    height: 50.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.exclamationmark_triangle,
                          size: 50.w,
                        ),
                        10.wb,
                        '举报'.text.black.size(30.sp).make()
                      ],
                    ),
                  ),
                )
              ];
            },
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
        child: _columnCard(widget.name, widget.content, widget.avatar));
  }
}
