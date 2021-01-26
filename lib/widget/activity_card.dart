// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_stack/image_stack.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class ActivityCard extends StatelessWidget {
  final String imagePath, title, subtitleFirst, subtitleSecond;
  final List<String> memberList;
  final bool isOver, isVote, isVoteOver;
  final Function fun;
  ActivityCard(
      {Key key,
      this.imagePath,
      this.title,
      this.subtitleFirst,
      this.subtitleSecond,
      this.memberList,
      this.isOver,
      this.isVote,
      this.isVoteOver,
      this.fun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.w,
        left: 32.w,
        right: 32.w,
      ),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: InkWell(
        onTap: () {
          fun(imagePath, title, isOver, isVote, isVoteOver, memberList);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16.w),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                child: CachedImageWrapper(
                  url: imagePath,
                  width: 686.w,
                  height: 210.w,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              margin: EdgeInsets.only(bottom: 16.w),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: BaseStyle.fontSize28,
                    color: BaseStyle.color4a4b51),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              margin: EdgeInsets.only(bottom: 8.w),
              child: isVote
                  ? Text(
                      subtitleFirst,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize24,
                          color: BaseStyle.color999999),
                    )
                  : RichText(
                      text: TextSpan(children: <InlineSpan>[
                        TextSpan(
                          text: '地点: ',
                          style: TextStyle(
                              fontSize: BaseStyle.fontSize24,
                              color: BaseStyle.color999999),
                        ),
                        TextSpan(
                          text: subtitleFirst,
                          style: TextStyle(
                              fontSize: BaseStyle.fontSize24,
                              color: ktextPrimary),
                        ),
                      ]),
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              margin: EdgeInsets.only(bottom: 16.w),
              child: RichText(
                text: TextSpan(children: <InlineSpan>[
                  TextSpan(
                    text: isVote ? '投票时间: ' : '报名时间: ',
                    style: TextStyle(
                        fontSize: BaseStyle.fontSize24,
                        color: BaseStyle.color999999),
                  ),
                  TextSpan(
                    text: subtitleSecond,
                    style: TextStyle(
                        fontSize: BaseStyle.fontSize24,
                        color: ktextPrimary),
                  ),
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 24.w,
                right: 20.w,
                bottom: 24.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 80.w),
                    child: ImageStack(
                      imageList: memberList,
                      imageRadius: 44.sp,
                      imageCount: 3,
                      imageBorderWidth: 1,
                      totalCount: 3,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      fun(imagePath, title, isOver, isVote, isVoteOver,
                          memberList);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 44.w,
                      width: 120.w,
                      padding: EdgeInsets.symmetric(
                        vertical: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: isOver
                            ? BaseStyle.colorababab
                            : BaseStyle.colorffc40c,
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                      child: Text(
                        isOver ? '已结束' : isVote ? '去投票' : '去参与',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: BaseStyle.fontSize22,
                            color: BaseStyle.color4a4b51),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
