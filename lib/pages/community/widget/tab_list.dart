import 'package:akuCommunity/utils/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/widget/circle_trend.dart';
import 'trend_card.dart';
import 'topic_card.dart';

class TabList extends StatefulWidget {
  final int index;
  TabList({Key key, this.index}) : super(key: key);

  @override
  _TabListState createState() => _TabListState();
}

class _TabListState extends State<TabList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Map<String, dynamic>> _circleList = [
    {
      'title': '今天',
      'contentList': <Map<String, dynamic>>[
        {
          'subtitle': '智慧社区真方便',
          'imagePath':
              'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1107708528,2478822843&fm=26&gp=0.jpg'
        },
        {
          'subtitle': '打卡成功！每天都要美美哒',
          'imagePath':
              'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1635278618,744809538&fm=26&gp=0.jpg'
        }
      ]
    },
    {
      'title': '118月',
      'contentList': <Map<String, dynamic>>[
        {
          'subtitle': '健身完毕就去吃火锅，奖励自己一回，偶尔一顿应该没什么吧！',
          'imagePath':
              'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1771079224,2955282519&fm=26&gp=0.jpg'
        },
      ]
    },
    {
      'title': '217月',
      'contentList': <Map<String, dynamic>>[
        {
          'subtitle': '头疼非常头疼',
          'imagePath':
              'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2951929786,3989144852&fm=26&gp=0.jpg'
        },
      ]
    },
  ];

  List<Map<String, dynamic>> _topicList = [
    {
      'title': '教师节到啦，你们有什么想对老师说的吗',
      'subtitle': '三尺讲台,三寸舌,三寸笔,三千桃李;十年树木,十载风,十载雨,十万栋梁。',
      'imagePath': 'assets/example/topic1.png',
      'hotNum': '197298'
    },
    {
      'title': '开展全民健身运动，全面建设小康社会',
      'subtitle': '生命在于运动，勇创辉煌',
      'imagePath': 'assets/example/topic2.png',
      'hotNum': '137128'
    },
    {
      'title': '端午品香粽，美味万家颂',
      'subtitle': '五月五过端午，包粽子赛龙舟，熏艾草挂荷包，家家户户齐欢乐',
      'imagePath': 'assets/example/topic3.png',
      'hotNum': '147128'
    }
  ];

  List<Map<String, dynamic>> _newsList = [
    {
      'name': '王管事',
      'content': '智慧社区真美丽',
      'imageUrl': <String>[
        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=129367535,2478805251&fm=26&gp=0.jpg',
        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=107966910,699677438&fm=26&gp=0.jpg',
        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3011269428,2056805718&fm=26&gp=0.jpg'
      ],
      'isLike':false
    },
    {
      'name': '马泽鹏',
      'content': '真的 很喜欢这个小区，保安也非常好',
      'imageUrl': <String>[
        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3445658157,2379681095&fm=26&gp=0.jpg',
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3539674557,3804837870&fm=26&gp=0.jpg',
      ],
      'isLike':true
    },
    {
      'name': '王管事',
      'content': '智慧城市，共和社会',
      'imageUrl': <String>[
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2446247351,2922660058&fm=26&gp=0.jpg',
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601274815221&di=3a50314a4d2c7188f6003f67d24177c2&imgtype=0&src=http%3A%2F%2Fimg1.cache.netease.com%2Fcatchpic%2F6%2F62%2F620DAF59053DF902F1D991EDBF14FD26.gif',
      ],
      'isLike':false
    },
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1500));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1500));

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(),
      footer: ClassicFooter(),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullUp: true,
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => widget.index == 0
              ? TrendCard(
                  name: _newsList[index]['name'],
                  content: _newsList[index]['content'],
                  imageUrl: _newsList[index]['imageUrl'],
                  isLike: _newsList[index]['isLike'],
                )
              : widget.index == 1
                  ? TopicCard(
                      title: _topicList[index]['title'],
                      subtitle: _topicList[index]['subtitle'],
                      imagePath: _topicList[index]['imagePath'],
                      hotNum: _topicList[index]['hotNum'],
                    )
                  : Container(
                      margin: EdgeInsets.only(top: Screenutil.length(32)),
                      child: CircleTrend(
                        title: _circleList[index]['title'],
                        contentList: _circleList[index]['contentList'],
                      ),
                    ),
          itemCount: widget.index == 0
              ? _newsList.length
              : widget.index == 1 ? _topicList.length : _circleList.length,
        ),
      ),
    );
  }
}
