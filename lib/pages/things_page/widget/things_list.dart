import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'things_card.dart';

class ThingsList extends StatefulWidget {
  final List<Map<String, dynamic>> listCard;
  final bool isRepair;
  ThingsList({Key key, this.listCard, this.isRepair}) : super(key: key);

  @override
  _ThingsListState createState() => _ThingsListState();
}

class _ThingsListState extends State<ThingsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(),
      footer: ClassicFooter(),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullUp: true,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 98.w),
        itemBuilder: (context, index) => ThingsCard(
          time: widget.listCard[index]['time'],
          tag: widget.listCard[index]['tag'],
          content: widget.listCard[index]['content'],
          imageList: widget.listCard[index]['imageList'],
          isRepair: widget.isRepair,
        ),
        itemCount: widget.listCard.length,
      ),
    );
  }
}
