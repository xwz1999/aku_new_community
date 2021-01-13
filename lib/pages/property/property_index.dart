import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/widget/single_ad_space.dart';
import 'package:akuCommunity/widget/grid_button.dart';
import 'package:akuCommunity/widget/container_comment.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/widget/circle_trend.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'widget/property_card.dart';
import 'widget/property_bar.dart';
import 'widget/property_activity_card.dart';

class PropertyIndex extends StatefulWidget {
  PropertyIndex({Key key}) : super(key: key);

  @override
  _PropertyIndexState createState() => _PropertyIndexState();
}

class _PropertyIndexState extends State<PropertyIndex>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  List<Map<String, dynamic>> _listView = [
    {
      'title': '今天',
      'contentList': <Map<String, dynamic>>[
        {
          'subtitle': '小区环境秩序管理局物业执法简讯',
          'imagePath':
              'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=486282784,967147496&fm=26&gp=0.jpg'
        },
        {
          'subtitle': '小区健身房已经修缮完毕',
          'imagePath':
              'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600342657805&di=e47b51d9359495ee90488f7244afa85b&imgtype=0&src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%2Fimages%2F20190122%2F14340317774_1200x800.jpg'
        }
      ]
    },
    {
      'title': '118月',
      'contentList': <Map<String, dynamic>>[
        {
          'subtitle': '小区有了狗狗专用便桶',
          'imagePath':
              'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600342731226&di=2223958ede406daa9fa85f3ea908e601&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180505%2F570fe33aab56409fa62f0626ab78f4cd.jpeg'
        },
      ]
    },
    {
      'title': '217月',
      'contentList': <Map<String, dynamic>>[
        {
          'subtitle': '小区开展保安员业务培训暨消防技能演练',
          'imagePath':
              'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600342893169&di=9f2fcf7e3b967ac99f0a2b22e59869d8&imgtype=0&src=http%3A%2F%2Fwww.nbbaxh.net%2FUploadFiles%2Fcontent%2F2018731649142.jpg'
        },
      ]
    },
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController _controller;

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

  void activityRouter() {
    Navigator.pushNamed(context, PageName.activities_page.toString(),
        arguments: Bundle()..putBool('isVote', false));
  }

  void activityDetailsRouter(String imagePath, title, bool isOver, isVote,
      isVoteOver, List<String> memberList) {
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

  void noticeRouter(String theme, imagePath) {
    Navigator.pushNamed(context, PageName.notice_page.toString(),
        arguments: Bundle()
          ..putMap('details', {'title': theme, 'imagePath': imagePath}));
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeScaffold(
      title: '物业',
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(),
        footer: ClassicFooter(),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullUp: true,
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverToBoxAdapter(
              child: SingleAdSpace(
                imagePath: 'assets/example/guanggao5.png',
                radius: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: ContainerComment(
                radius: 8,
                customWidget: GridButton(
                  gridList: AssetsImage.propertyGridList,
                  count: 4,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: PropertyCard(),
            ),
            PropertyBar(
              title: '社区活动',
              subtitle: '精彩往期',
              more: '更多活动',
              fun: activityRouter,
            ),
            SliverToBoxAdapter(
              child: PropertyActivityCard(fun: activityDetailsRouter),
            ),
            PropertyBar(
              title: '社区公告',
              subtitle: '看看小区最近发生什么?',
            ),
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => CircleTrend(
                  title: _listView[index]['title'],
                  contentList: _listView[index]['contentList'],
                  fun: noticeRouter,
                ),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
