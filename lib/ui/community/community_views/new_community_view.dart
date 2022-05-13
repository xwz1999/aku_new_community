import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/models/community/all_dynamic_list_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/chat_card.dart';

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
      path: SAASAPI.community.dynamicList,
      controller: _refreshController,
      convert: (model) {
        return model.rows.map((e) => AllDynamicListModel.fromJson(e)).toList();
      },
      builder: (items) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final item = items[index] as AllDynamicListModel;
            return ChatCard(
              model: item,
              refresh: () {
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
