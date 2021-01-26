// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class CircleTrend extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> contentList;
  final Function fun;
  CircleTrend({Key key, this.title, this.contentList, this.fun})
      : super(key: key);

  @override
  _CircleTrendState createState() => _CircleTrendState();
}

class _CircleTrendState extends State<CircleTrend> {
  TextStyle _textStyleTitle() {
    return TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 52.sp,
        color: Color(0xff333333));
  }

  TextStyle _textStyleSubtitle() {
    return TextStyle(fontSize: 32.sp, color: Color(0xff333333));
  }

  TextStyle _textStyleTag() {
    return TextStyle(fontSize: 30.sp, color: Color(0xff444444));
  }

  InkWell _contentDetails(String subtitle, imagePath, Function fun) {
    return InkWell(
      onTap: () {
        fun(subtitle, imagePath);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWrapper(
              url: imagePath,
              width: 152.w,
              height: 152.w,
            ),
            SizedBox(width: 10.w),
            Container(
              width: 384.w,
              child: Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: _textStyleSubtitle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _statusCard(
      String title, List<Map<String, dynamic>> contentList, Function fun) {
    return Container(
      margin: EdgeInsets.only(
        left: 32.w,
        right: 32.w,
        bottom: 40.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.substring(0, 2),
            style: _textStyleTitle(),
          ),
          title.substring(2) != null
              ? Text(
                  title.substring(2),
                  style: _textStyleTag(),
                )
              : SizedBox(),
          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Column(
              children: contentList
                  .map((item) => _contentDetails(
                        item['subtitle'],
                        item['imagePath'],
                        fun,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _statusCard(
        widget.title,
        widget.contentList,
        widget.fun,
      ),
    );
  }
}
