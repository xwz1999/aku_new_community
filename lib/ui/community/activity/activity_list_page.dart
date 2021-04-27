import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/community/activity_item_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/ui/community/activity/activity_card.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class ActivityListPage extends StatefulWidget {
  ActivityListPage({Key? key}) : super(key: key);

  @override
  _ActivityListPageState createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '往期精彩',
      body: BeeListView<ActivityItemModel>(
        controller: _refreshController,
        path: API.community.activityList,
        convert: (model) =>
            model.tableList!.map((e) => ActivityItemModel.fromJson(e)).toList(),
        builder: (items) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
            itemBuilder: (context, index) {
              final ActivityItemModel model = items[index];
              return ActivityCard(model: model);
            },
            separatorBuilder: (_, __) => 20.hb,
            itemCount: items.length,
          );
        },
      ),
    );
  }
}
