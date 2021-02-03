// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:akuCommunity/widget/activity_card.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

//TODO CLEAN BOTTOM CODES.
@Deprecated("sh*t activities_page need to be cleaned.")
class ActivitiesPage extends StatefulWidget {
  ActivitiesPage({Key key}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  List<String> images = [];
  List<Map<String, dynamic>> _listView = [];

  List<Map<String, dynamic>> _listVote = [];

  List<Map<String, dynamic>> _listEnter = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _listView = _listVote;
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
    Get.to(ActivitiesPage());
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '社区活动',
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
                    isVote: false,
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
