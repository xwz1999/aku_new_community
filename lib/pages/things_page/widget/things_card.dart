import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/expandable_text.dart';
import 'image_grid.dart';

class ThingsCard extends StatefulWidget {
  final String time, tag, content;
  final List<String> imageList;
  final bool isRepair;
  ThingsCard(
      {this.time,
      this.tag,
      this.content,
      this.imageList,
      this.isRepair,
      Key key})
      : super(key: key);

  @override
  _ThingsCardState createState() => _ThingsCardState();
}

class _ThingsCardState extends State<ThingsCard> {
  void detailRouter() {
    Navigator.pushNamed(context, PageName.things_detail_page.toString(),
        arguments: Bundle()
          ..putMap('things', {
            'isRepair':widget.isRepair,
            'content': widget.content,
            'time': widget.time,
            'imageList': widget.imageList,
          }));
  }

  InkWell _inkWellPropose(
      String time, String tag, String content, List<String> imageList) {
    return InkWell(
      onTap: detailRouter,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: Screenutil.size(32),
                    color: Color(0xff333333),
                  ),
                ),
                Text(
                  tag,
                  style: TextStyle(
                    fontSize: Screenutil.size(24),
                    color: Color(0xffff8200),
                  ),
                ),
              ],
            ),
            SizedBox(height: Screenutil.length(24)),
            Divider(height: 0.5),
            SizedBox(height: Screenutil.length(24)),
            ExpandableText(
              text: content,
              maxLines: 2,
              style: TextStyle(
                fontSize: Screenutil.size(28),
                color: Color(0xff333333),
              ),
              expand: false,
            ),
            SizedBox(height: Screenutil.length(29)),
            imageList.length != 0 ? ImageGrid(imageList):SizedBox()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      margin: EdgeInsets.only(
        left: Screenutil.length(32),
        right: Screenutil.length(32),
        top: Screenutil.length(20),
      ),
      padding: EdgeInsets.only(
        left: Screenutil.length(28),
        right: Screenutil.length(28),
        top: Screenutil.length(21),
        bottom: Screenutil.length(24),
      ),
      child: _inkWellPropose(
        widget.time,
        widget.tag,
        widget.content,
        widget.imageList,
      ),
    );
  }
}
