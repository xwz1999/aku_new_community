import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_stack/image_stack.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class PropertyActivityCard extends StatelessWidget {
  final Function fun;
  PropertyActivityCard({Key key, this.fun}) : super(key: key);

  final List<String> images = [
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1151143562,4115642159&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2551412680,857245643&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3604827221,1047385274&fm=26&gp=0.jpg",
  ];

  final List<Map<String, dynamic>> _listView = [
    {
      'imagePath':
          'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3786472598,2225627644&fm=26&gp=0.jpg',
      'title': '宁化社区第一届煎蛋比赛报名开始',
      'subtitleFirst': '活动室二楼',
      'subtitleSecond': '06月17日 12:00至06月27日18:30',
      'peopleNum': '37',
      'isOver': false,
      'isVote': false,
      'isVoteOver': false,
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600339523640&di=be179b5e314f9e198c000e7726affef6&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2F7e3e6709c93d70cf7371f1f3f1dcd100bba12b40.jpg',
      'title': '美嘉社区第三届六一亲子活动开始啦',
      'subtitleFirst': '中央活动区',
      'subtitleSecond': '04月17日 13:00至04月23日18:30',
      'peopleNum': '37',
      'isOver': false,
      'isVote': false,
      'isVoteOver': false
    },
  ];

  TextStyle _textStyleTitle() {
    return TextStyle(fontSize: 28.sp, color: Color(0xff4a4b51));
  }

  TextStyle _textStyleTag() {
    return TextStyle(fontSize: 24.sp, color: Color(0xff999999));
  }

  TextStyle _textStyleSubtitle() {
    return TextStyle(fontSize: 24.sp, color: Color(0xff4a4b51));
  }

  Container _activityCard(String imagePath, title, subtitleFirst,
      subtitleSecond, peopleNum, bool isOver, isVote, isVoteOver, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.only(
        top: index == 0 ? 0 : 32.w,
        left: 32.w,
        right: 32.w,
      ),
      padding: EdgeInsets.only(
          top: 12.w,
          left: 10.w,
          right: 22.w,
          bottom: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  child: CachedImageWrapper(
                    url: imagePath,
                    width: 160.w,
                    height: 120.w,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 6.w),
                    child: Text(
                      title,
                      style: _textStyleTitle(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8.w),
                    child: RichText(
                      text: TextSpan(
                        text: '地点:',
                        style: _textStyleTag(),
                        children: [
                          TextSpan(
                              text: subtitleFirst, style: _textStyleSubtitle()),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '活动时间:',
                      style: _textStyleTag(),
                      children: [
                        TextSpan(
                            text: subtitleSecond, style: _textStyleSubtitle()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 40.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 80.w),
                    child: ImageStack(
                      imageList: images,
                      imageRadius: 44.sp,
                      imageCount: 3,
                      imageBorderWidth: 1,
                      totalCount: 3,
                    ),
                  ),
                  SizedBox(width: 26.w),
                  Text(
                    '$peopleNum人已参加',
                    style: _textStyleSubtitle(),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  fun(imagePath, title, isOver, isVote, isVoteOver, images);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 44.w,
                  width: 120.w,
                  padding: EdgeInsets.symmetric(
                    vertical: 7.w,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffffc40c),
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                  ),
                  child: Text(
                    '去参与',
                    style: _textStyleSubtitle(),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _listView
            .asMap()
            .keys
            .map((index) => _activityCard(
                  _listView[index]['imagePath'],
                  _listView[index]['title'],
                  _listView[index]['subtitleFirst'],
                  _listView[index]['subtitleSecond'],
                  _listView[index]['peopleNum'],
                  _listView[index]['isOver'],
                  _listView[index]['isVote'],
                  _listView[index]['isVoteOver'],
                  index,
                ))
            .toList(),
      ),
    );
  }
}
