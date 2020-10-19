import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class TopicCard extends StatefulWidget {
  final String title, subtitle, imagePath, hotNum;
  TopicCard({Key key, this.title, this.subtitle, this.imagePath, this.hotNum})
      : super(key: key);

  @override
  _TopicCardState createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  TextStyle _textStyleTitle() {
    return TextStyle(fontSize: Screenutil.size(28), color: Color(0xff333333));
  }

  TextStyle _textStyleSubtitle() {
    return TextStyle(fontSize: Screenutil.size(22), color: Color(0xff666666));
  }

  TextStyle _textStyleHot() {
    return TextStyle(fontSize: Screenutil.size(22), color: Color(0xff333333));
  }

  void topiceDetailRouter(String subtitle, String imagePath) {
    Navigator.pushNamed(context, PageName.topice_detail_page.toString(),
        arguments: Bundle()
          ..putMap('topicMap', {'subtitle': subtitle, 'imagePath': imagePath}));
  }

  Row _rowTopic(String title, String subtitle, String imagePath) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imagePath,
          height: Screenutil.length(160),
          width: Screenutil.length(250),
        ),
        SizedBox(width: Screenutil.length(12)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Screenutil.length(383),
              height: Screenutil.length(80),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: _textStyleTitle(),
              ),
            ),
            SizedBox(width: Screenutil.length(10)),
            Container(
              width: Screenutil.length(365),
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
            size: Screenutil.size(23),
          ),
          SizedBox(width: Screenutil.length(10)),
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
        left: Screenutil.length(32),
        right: Screenutil.length(32),
        top: Screenutil.length(20),
      ),
      padding: EdgeInsets.all(Screenutil.length(20)),
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
