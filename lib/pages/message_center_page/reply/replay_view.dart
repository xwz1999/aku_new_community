import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ReplayView extends StatefulWidget {
  const ReplayView({Key? key}) : super(key: key);

  @override
  _ReplayViewState createState() => _ReplayViewState();
}

class _ReplayViewState extends State<ReplayView> {
  EasyRefreshController _refreshController = EasyRefreshController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeListView(
        path: API.host,
        controller: _refreshController,
        convert: (json) {
          return [];
        },
        builder: (items) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return Container();
              },
              separatorBuilder: (_, __) => 20.w.heightBox,
              itemCount: items.length);
        });
  }
}
