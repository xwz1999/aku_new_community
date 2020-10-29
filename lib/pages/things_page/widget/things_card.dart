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
                    fontSize: 32.sp,
                    color: Color(0xff333333),
                  ),
                ),
                Text(
                  tag,
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Color(0xffff8200),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.w),
            Divider(height: 0.5),
            SizedBox(height: 24.w),
            ExpandableText(
              text: content,
              maxLines: 2,
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xff333333),
              ),
              expand: false,
            ),
            SizedBox(height: 29.w),
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
        left: 32.w,
        right: 32.w,
        top: 20.w,
      ),
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
        top: 21.w,
        bottom: 24.w,
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
