import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/community/event_item_model.dart';
import 'package:aku_community/ui/community/community_views/widgets/chat_card.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class EventDetailPage extends StatefulWidget {
  final int themeId;
  EventDetailPage({
    Key key,
    @required this.themeId,
  }) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  EventItemModel _model;
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '详情',
      body: EasyRefresh(
        controller: _refreshController,
        header: MaterialHeader(),
        firstRefresh: true,
        onRefresh: () async {
          BaseModel model = await NetUtil().get(
            API.community.getEventDetail,
            params: {'themeId': widget.themeId},
          );
          _model = EventItemModel.fromJson(model.data);
          setState(() {});
        },
        child: _model == null
            ? SizedBox()
            : ListView(
                children: [
                  ChatCard(
                    model: _model,
                    hideLine: true,
                    canTap: false,
                  ),
                ],
              ),
      ),
    );
  }
}
