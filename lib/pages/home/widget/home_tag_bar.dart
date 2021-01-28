// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_icons/flutter_icons.dart';

// Project imports:
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/utils/headers.dart';

//TODO CLEAN BOTTOM CODES.
@Deprecated("sh*t home_tag_bar need to be cleaned.")
class HomeTagBar extends StatefulWidget {
  final String title;
  final String tag;
  final bool isShowImage, isShowTitle;
  final Function fun;
  HomeTagBar(
      {Key key,
      this.title,
      this.tag,
      this.isShowImage,
      this.isShowTitle = false,
      this.fun})
      : super(key: key);

  @override
  _HomeTagBarState createState() => _HomeTagBarState();
}

class _HomeTagBarState extends State<HomeTagBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.isShowTitle ? Colors.transparent : Colors.white,
      margin: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      padding: EdgeInsets.all(24.w),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  widget.isShowImage
                      ? Container(
                          margin: EdgeInsets.only(right: 24.w),
                          child: Image.asset(
                            AssetsImage.NOTIFICATION,
                            height: 38.w,
                            width: 38.w,
                          ),
                        )
                      : SizedBox(),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: widget.isShowImage ? 28.sp : 32.sp,
                        fontWeight: widget.isShowImage
                            ? FontWeight.normal
                            : FontWeight.w600,
                        color: Color(0xff4a4b51)),
                  ),
                ],
              ),
              widget.isShowTitle
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        widget.fun();
                      },
                      child: Row(children: [
                        Text(
                          '更多${widget.tag}',
                          style: TextStyle(
                              color: Color(0xff999999), fontSize: 20.sp),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          AntDesign.right,
                          color: Color(0xff999999),
                          size: 20.sp,
                        ),
                      ]),
                    ),
            ],
          ),
          widget.isShowImage
              ? SizedBox()
              : Positioned(
                  top: 30.w,
                  left: 0,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffc40c).withOpacity(0.4),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      width: 126.w,
                      height: 8.w),
                )
        ],
      ),
    );
  }
}
