import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/community/my_event_item_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/my_event_card.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MyCommunityView extends StatefulWidget {
  MyCommunityView({Key? key}) : super(key: key);

  @override
  MyCommunityViewState createState() => MyCommunityViewState();
}

class MyCommunityViewState extends State<MyCommunityView>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController = EasyRefreshController();

  refresh() {
    _refreshController.callRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeListView<MyEventItemModel>(
      path: API.community.myEvent,
      controller: _refreshController,
      convert: (model) {
        return model.tableList!
            .map((e) => MyEventItemModel.fromJson(e))
            .toList();
      },
      builder: (items) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          itemBuilder: (context, index) {
            final MyEventItemModel model = items[index];
            MyEventItemModel? preModel;
            if (index >= 1) preModel = items[index - 1];
            return MyEventCard(model: model, preModel: preModel);
          },
          separatorBuilder: (_, __) => 8.hb,
          itemCount: items.length,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
