import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/widget/expandable_text.dart';
import 'package:akuCommunity/widget/image_grid.dart';

class GoodsCommentsCard extends StatefulWidget {
  final String imagePath,
      name,
      subtitle,
      content,
      addTime,
      addContent,
      viewNum,
      usefulNum;
  final List<String> contentImageList, addContentImageList;
  GoodsCommentsCard(
      {Key key,
      this.imagePath,
      this.name,
      this.subtitle,
      this.content,
      this.addTime,
      this.addContent,
      this.viewNum,
      this.usefulNum,
      this.contentImageList,
      this.addContentImageList})
      : super(key: key);

  @override
  _GoodsCommentsCardState createState() => _GoodsCommentsCardState();
}

class _GoodsCommentsCardState extends State<GoodsCommentsCard> {
  Container _cardHeader(String imagePath, name, subtitle) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: Screenutil.length(12)),
            child: ClipOval(
              child: CachedImageWrapper(
                url: imagePath,
                width: Screenutil.length(50),
                height: Screenutil.length(50),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: BaseStyle.fontSize24,
                  color: BaseStyle.color333333,
                ),
              ),
              SizedBox(height: Screenutil.length(4)),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: BaseStyle.fontSize18,
                  color: BaseStyle.color999999,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _cardContent(
    String content,
    List<String> contentImageList,
  ) {
    return Container(
      margin: EdgeInsets.only(top: Screenutil.length(15)),
      padding: EdgeInsets.only(bottom: Screenutil.length(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Screenutil.length(20)),
            child: ExpandableText(
              text: content,
              maxLines: 3,
              style: TextStyle(
                fontSize: BaseStyle.fontSize24,
                color: BaseStyle.color333333,
              ),
              expand: false,
            ),
          ),
          ImageGrid(contentImageList),
        ],
      ),
    );
  }

  Container _cardFooter(String viewNum) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '浏览${viewNum}次',
            style: TextStyle(
              fontSize: BaseStyle.fontSize22,
              color: BaseStyle.color999999,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Feather.triangle,
                  size: BaseStyle.fontSize22,
                  color: BaseStyle.color333333,
                ),
                SizedBox(width: Screenutil.length(10)),
                Text(
                  '有用',
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize22,
                    color: BaseStyle.color333333,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(32),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
      ),
      padding: EdgeInsets.only(bottom: Screenutil.length(32)),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffd8d8d8), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(widget.imagePath, widget.name, widget.subtitle),
          _cardContent(widget.content, widget.contentImageList),
          _cardFooter(widget.viewNum),
        ],
      ),
    );
  }
}
