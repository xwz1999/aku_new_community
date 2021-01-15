import 'package:akuCommunity/pages/community/note_create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'widget/trend_card.dart';

class TopiceDetailPage extends StatefulWidget {
  final Bundle bundle;
  TopiceDetailPage({Key key, this.bundle}) : super(key: key);

  @override
  _TopiceDetailPageState createState() => _TopiceDetailPageState();
}

class _TopiceDetailPageState extends State<TopiceDetailPage> {
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

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  SliverAppBar _sliverAppBar(String imagePath) {
    return SliverAppBar(
      expandedHeight: 500.w,
      pinned: true,
      floating: true,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(AntDesign.left, size: 40.sp),
        onPressed: () {
          Get.back();
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text('教师节'),
        background: Image.asset(
          imagePath,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Positioned _positionedFloatActionButton() {
    return Positioned(
        bottom: 124.w,
        right: 32.w,
        child: FloatingActionButton(
            backgroundColor: Color(0xffffd000),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 40.sp,
            ),
            onPressed: () {
              NoteCreatePage().to();
            }));
  }

  @override
  Widget build(BuildContext context) {
    double _statusHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          RefreshConfiguration(
            hideFooterWhenNotFull: true,
            maxOverScrollExtent: 100 + _statusHeight,
            child: SmartRefresher(
              controller: _refreshController,
              header: ClassicHeader(
                height: _statusHeight + 60,
                outerBuilder: (child) {
                  return Container(
                    padding: EdgeInsets.only(top: _statusHeight),
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: child,
                    ),
                  );
                },
              ),
              footer: ClassicFooter(),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              enablePullUp: true,
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  _sliverAppBar(widget.bundle.getMap('topicMap')['imagePath']),
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => TrendCard(
                          name: '秋森',
                          content: '真的 很喜欢这个小区，保安也非常好',
                        ),
                        itemCount: 6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _positionedFloatActionButton(),
        ],
      ),
    );
  }
}
