import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_stack/image_stack.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
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
        top: Screenutil.length(20),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
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
              margin: EdgeInsets.only(bottom: Screenutil.length(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                child: CachedImageWrapper(
                  url: imagePath,
                  width: Screenutil.length(686),
                  height: Screenutil.length(210),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Screenutil.length(24)),
              margin: EdgeInsets.only(bottom: Screenutil.length(16)),
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
              padding: EdgeInsets.symmetric(horizontal: Screenutil.length(22)),
              margin: EdgeInsets.only(bottom: Screenutil.length(8)),
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
                              color: BaseStyle.color333333),
                        ),
                      ]),
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Screenutil.length(22)),
              margin: EdgeInsets.only(bottom: Screenutil.length(16)),
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
                        color: BaseStyle.color333333),
                  ),
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: Screenutil.length(24),
                right: Screenutil.length(20),
                bottom: Screenutil.length(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Screenutil.length(80)),
                    child: ImageStack(
                      imageList: memberList,
                      imageRadius: Screenutil.size(44),
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
                      height: Screenutil.length(44),
                      width: Screenutil.length(120),
                      padding: EdgeInsets.symmetric(
                        vertical: Screenutil.length(8),
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
