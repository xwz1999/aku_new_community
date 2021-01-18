import 'package:akuCommunity/pages/community/topice_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';

class TopicCard extends StatefulWidget {
  final String title, subtitle, imagePath, hotNum;
  TopicCard({Key key, this.title, this.subtitle, this.imagePath, this.hotNum})
      : super(key: key);

  @override
  _TopicCardState createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  TextStyle _textStyleTitle() {
    return TextStyle(fontSize: 28.sp, color: Color(0xff333333));
  }

  TextStyle _textStyleSubtitle() {
    return TextStyle(fontSize: 22.sp, color: Color(0xff666666));
  }

  TextStyle _textStyleHot() {
    return TextStyle(fontSize: 22.sp, color: Color(0xff333333));
  }

  void topiceDetailRouter(String subtitle, String imagePath) {
    TopiceDetailPage().to();
  }

  Row _rowTopic(String title, String subtitle, String imagePath) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imagePath,
          height: 160.w,
          width: 250.w,
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 383.w,
              height: 80.w,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: _textStyleTitle(),
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              width: 365.w,
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _textStyleSubtitle(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Positioned _positionedHot(String hotNum) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Row(
        children: [
          Icon(
            MaterialIcons.whatshot,
            color: Color(0xffd4270a),
            size: 23.sp,
          ),
          SizedBox(width: 10.w),
          Text(
            hotNum,
            style: _textStyleHot(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
        left: 32.w,
        right: 32.w,
        top: 20.w,
      ),
      padding: EdgeInsets.all(20.w),
      child: InkWell(
        onTap: () {
          topiceDetailRouter(
            widget.subtitle,
            widget.imagePath,
          );
        },
        child: Stack(
          children: [
            _rowTopic(
              widget.title,
              widget.subtitle,
              widget.imagePath,
            ),
            _positionedHot(widget.hotNum),
          ],
        ),
      ),
    );
  }
}
