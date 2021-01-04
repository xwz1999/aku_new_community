import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_stack/image_stack.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class CommunityCard extends StatefulWidget {
  final String imagePath, title, subtitle, timeZone;
  final List<String> headList;
  final bool isOver;
  final int peopleNum;
  final Function fun;
  CommunityCard(
      {Key key,
      this.imagePath,
      this.title,
      this.subtitle,
      this.timeZone,
      this.headList,
      this.isOver,
      this.peopleNum,
      this.fun})
      : super(key: key);

  @override
  _CommunityCardState createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  Container _cardHeader(String imagePath, title, subtitle, timeZone) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.w),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: CachedImageWrapper(
                url: imagePath,
                width: 160.w,
                height: 120.w,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 480.w,
                margin: EdgeInsets.only(bottom: 6.w),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: BaseStyle.fontSize28,
                      color: BaseStyle.color4a4b51),
                ),
              ),
              Container(
                width: 480.w,
                margin: EdgeInsets.only(bottom: 8.w),
                child: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: BaseStyle.fontSize24,
                      color: BaseStyle.color999999),
                ),
              ),
              Container(
                width: 480.w,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(children: <InlineSpan>[
                    TextSpan(
                      text: '参与时间: ',
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize24,
                          color: BaseStyle.color999999),
                    ),
                    TextSpan(
                      text: timeZone,
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize24,
                          color: BaseStyle.color4a4b51),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _cardFooter(String imagePath,title,
      List<String> headList, bool isOver, int peopleNum, Function fun) {
    return Container(
      margin: EdgeInsets.only(top: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 80.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 26.w),
                  child: ImageStack(
                    imageList: headList,
                    imageRadius: 44.sp,
                    imageCount: 3,
                    imageBorderWidth: 1,
                    totalCount: 3,
                  ),
                ),
                Text(
                  '$peopleNum人已参加',
                  style: TextStyle(
                      fontSize: BaseStyle.fontSize22,
                      color: BaseStyle.color333333),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              fun(imagePath,title);
            },
            child: Container(
              alignment: Alignment.center,
              height: 44.w,
              width: 120.w,
              padding: EdgeInsets.symmetric(
                vertical: 7.w,
              ),
              decoration: BoxDecoration(
                color: isOver ? BaseStyle.colorababab : BaseStyle.colorffc40c,
                borderRadius: BorderRadius.all(Radius.circular(22)),
              ),
              child: Text(
                isOver ? '已结束' : '去参与',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: BaseStyle.fontSize22,
                    color: BaseStyle.color4a4b51),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
        top: 24.w,
        left: 32.w,
        right: 32.w,
      ),
      padding: EdgeInsets.only(
        top: 12.w,
        left: 10.w,
        right: 16.w,
        bottom: 20.w,
      ),
      child: Column(
        children: [
          _cardHeader(
            widget.imagePath,
            widget.title,
            widget.subtitle,
            widget.timeZone,
          ),
          _cardFooter(
            widget.imagePath,
            widget.title,
            widget.headList,
            widget.isOver,
            widget.peopleNum,
            widget.fun,
          )
        ],
      ),
    );
  }
}
