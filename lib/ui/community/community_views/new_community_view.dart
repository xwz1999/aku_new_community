import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/community/event_item_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/ui/community/community_views/widgets/chat_card.dart';

class NewCommunityView extends StatefulWidget {
  NewCommunityView({Key? key}) : super(key: key);

  @override
  NewCommunityViewState createState() => NewCommunityViewState();
}

class NewCommunityViewState extends State<NewCommunityView>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController = EasyRefreshController();

  refresh() {
    _refreshController.callRefresh();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeListView(
      path: API.community.newEventList,
      controller: _refreshController,
      convert: (model) {
        return model.tableList!.map((e) => EventItemModel.fromJson(e)).toList();
      },
      builder: (items) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final item = items[index] as EventItemModel;
            return ChatCard(
              model: item,
              onDelete: () {
                _refreshController.callRefresh();
              },
            );
          },
          itemCount: items.length,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
