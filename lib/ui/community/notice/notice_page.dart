import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/community/board_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/ui/community/notice/notice_card.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class NoticePage extends StatefulWidget {
  NoticePage({Key key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '社区公告',
      body: BeeListView(
        controller: _refreshController,
        path: API.community.boardList,
        convert: (model) =>
            model.tableList.map((e) => BoardItemModel.fromJson(e)).toList(),
        builder: (items) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 32.w),
            itemBuilder: (context, index) {
              final BoardItemModel model = items[index];
              BoardItemModel preModel;
              if (index >= 1) preModel = items[index - 1];
              return NoticeCard(
                model: model,
                preModel: preModel,
              );
            },
            separatorBuilder: (_, __) => 8.hb,
            itemCount: items.length,
          );
        },
      ),
    );
  }
}
