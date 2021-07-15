import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/house_keeping/house_keeping_list_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/ui/manager/house_keeping/house_keeping_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class HouseKeepingView extends StatefulWidget {
  final int index;
  HouseKeepingView({Key? key, required this.index}) : super(key: key);

  @override
  _HouseKeepingViewState createState() => _HouseKeepingViewState();
}

class _HouseKeepingViewState extends State<HouseKeepingView>
    with AutomaticKeepAliveClientMixin {
  late EasyRefreshController _controller;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeListView(
        path: API.manager.houseKeepingList,
        controller: _controller,
        extraParams: {
          "housekeepingStatus": widget.index == 0 ? null : widget.index
        },
        convert: (models) {
          return models.tableList!
              .map((e) => HouseKeepingListModel.fromJson(e))
              .toList();
        },
        builder: (items) {
          return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              itemBuilder: (context, index) {
                return HouseKeepingCard(
                  model: items[index],
                  callRefresh: () {
                    _controller.callRefresh();
                  },
                );
              },
              separatorBuilder: (_, __) {
                return 24.w.heightBox;
              },
              itemCount: items.length);
        });
  }

  @override
  bool get wantKeepAlive => true;
}
