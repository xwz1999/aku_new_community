import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/models/home/home_announce_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/community/notice/notice_card.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

@Deprecated('暂时弃用')
class NoticePage extends StatefulWidget {
  NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  EasyRefreshController _refreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '社区公告',
      body: BeeListView<HomeAnnounceModel>(
        controller: _refreshController,
        path: SARSAPI.announce.list,
        convert: (model) =>
            model.rows.map((e) => HomeAnnounceModel.fromJson(e)).toList(),
        builder: (items) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 32.w),
            itemBuilder: (context, index) {
              final HomeAnnounceModel model = items[index];
              HomeAnnounceModel? preModel;
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
