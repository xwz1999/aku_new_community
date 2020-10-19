import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
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
        fontSize: Screenutil.size(52),
        color: Color(0xff333333));
  }

  TextStyle _textStyleSubtitle() {
    return TextStyle(fontSize: Screenutil.size(32), color: Color(0xff333333));
  }

  TextStyle _textStyleTag() {
    return TextStyle(fontSize: Screenutil.size(30), color: Color(0xff444444));
  }

  InkWell _contentDetails(String subtitle, imagePath, Function fun) {
    return InkWell(
      onTap: () {
        fun(subtitle, imagePath);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Screenutil.length(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWrapper(
              url: imagePath,
              width: Screenutil.length(152),
              height: Screenutil.length(152),
            ),
            SizedBox(width: Screenutil.length(10)),
            Container(
              width: Screenutil.length(384),
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
        left: Screenutil.length(32),
        right: Screenutil.length(32),
        bottom: Screenutil.length(40),
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
            margin: EdgeInsets.only(left: Screenutil.length(30)),
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
