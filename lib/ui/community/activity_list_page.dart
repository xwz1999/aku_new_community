// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';

// Project imports:
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/community/activity_item_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/ui/community/activity_card.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class ActivityListPage extends StatefulWidget {
  ActivityListPage({Key key}) : super(key: key);

  @override
  _ActivityListPageState createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '往期精彩',
      body: BeeListView(
        controller: _refreshController,
        path: API.community.activityList,
        convert: (model) =>
            model.tableList.map((e) => ActivityItemModel.fromJson(e)).toList(),
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
