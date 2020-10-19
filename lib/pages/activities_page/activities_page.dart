import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/activity_card.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class ActivitiesPage extends StatefulWidget {
  final Bundle bundle;
  ActivitiesPage({Key key, this.bundle}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  List<String> images = [
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1151143562,4115642159&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2551412680,857245643&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3604827221,1047385274&fm=26&gp=0.jpg",
  ];
  List<Map<String, dynamic>> _listView = [];

  List<Map<String, dynamic>> _listVote = [
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600058454436&di=76f6d526c4108b582c540d24bad316d8&imgtype=0&src=http%3A%2F%2Fimg003.hc360.cn%2Fm2%2FM00%2FFD%2FB9%2FwKhQclRLWoqEAosNAAAAABnzxUo896.jpg',
      'title': '为优秀点赞！2020第一届最美服务之星评选',
      'subtitleFirst': '快来为你支持的保洁员投票吧！～',
      'subtitleSecond': '06月17日 12:00至06月27日18:30',
      'isOver': false,
      'isVoteOver': true,
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600058583164&di=04000bc0e0394edb0c74f7c8fa0efcb2&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Ftranslate%2F161%2Fw1080h681%2F20180814%2FzWKK-hhtfwqr0303774.jpg',
      'title': '投票！选出你心中“乘风破浪的绿化保卫员”',
      'subtitleFirst': '建设美丽的边疆，爱护我们的家园',
      'subtitleSecond': '04月17日 13:00至04月23日18:30',
      'isOver': false,
      'isVoteOver': true,
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600058626924&di=568c1c35b47e6c8bb762f71a883c9e09&imgtype=0&src=http%3A%2F%2Fimg.soufunimg.com%2Fnews%2F2015_11%2F26%2F1448505277039.jpg',
      'title': '特别忠诚，在生死抉择的时刻，他把人民利益举过他把人民利益举过……',
      'subtitleFirst': '平凡服务者，最美保安员',
      'subtitleSecond': '04月12日 12:00至04月15日18:30',
      'isOver': true,
      'isVoteOver': false,
    }
  ];

  List<Map<String, dynamic>> _listEnter = [
    {
      'imagePath':
          'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3786472598,2225627644&fm=26&gp=0.jpg',
      'title': '宁化社区第一届煎蛋比赛报名开始',
      'subtitleFirst': '活动室二楼',
      'subtitleSecond': '06月17日 12:00至06月27日18:30',
      'isOver': false,
      'isVoteOver': true,
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600339523640&di=be179b5e314f9e198c000e7726affef6&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2F7e3e6709c93d70cf7371f1f3f1dcd100bba12b40.jpg',
      'title': '美嘉社区第三届六一亲子活动开始啦',
      'subtitleFirst': '中央活动区',
      'subtitleSecond': '04月17日 13:00至04月23日18:30',
      'isOver': false,
      'isVoteOver': true,
    },
    {
      'imagePath':
          'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=347834970,829932821&fm=26&gp=0.jpg',
      'title': '生命在与运动，华侨小区拔河比赛开始',
      'subtitleFirst': '小区外围体育馆',
      'subtitleSecond': '04月12日 12:00至04月15日18:30',
      'isOver': true,
      'isVoteOver': false,
    }
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _listView = widget.bundle.getBool('isVote') ? _listVote : _listEnter;
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

  void detailsRouter(String imagePath, title, bool isOver, isVote, isVoteOver,
      List<String> memberList) {
    Navigator.pushNamed(context, PageName.activities_details_page.toString(),
        arguments: Bundle()
          ..putMap('details', {
            'title': title,
            'imagePath': imagePath,
            'isOver': isOver,
            'isVote': isVote,
            'isVoteOver': isVoteOver,
            'memberList': memberList
          }));
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '社区活动',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: RefreshConfiguration(
        hideFooterWhenNotFull: true,
        child: SmartRefresher(
          controller: _refreshController,
          header: WaterDropHeader(),
          footer: ClassicFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          enablePullUp: true,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => ActivityCard(
                    imagePath: _listView[index]['imagePath'],
                    title: _listView[index]['title'],
                    subtitleFirst: _listView[index]['subtitleFirst'],
                    subtitleSecond: _listView[index]['subtitleSecond'],
                    memberList: images,
                    isOver: _listView[index]['isOver'],
                    isVote: widget.bundle.getBool('isVote'),
                    isVoteOver: _listView[index]['isVoteOver'],
                    fun: detailsRouter,
                  ),
                  childCount: _listView.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
