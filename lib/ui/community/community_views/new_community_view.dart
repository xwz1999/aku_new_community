// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';

// Project imports:
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/community/event_item_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/ui/community/community_views/widgets/chat_card.dart';

class NewCommunityView extends StatefulWidget {
  NewCommunityView({Key key}) : super(key: key);

  @override
  NewCommunityViewState createState() => NewCommunityViewState();
}

class NewCommunityViewState extends State<NewCommunityView>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController = EasyRefreshController();

  refresh() {
    _refreshController?.callRefresh();
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeListView(
      path: API.community.newEventList,
      controller: _refreshController,
      convert: (model) {
        return model.tableList.map((e) => EventItemModel.fromJson(e)).toList();
      },
      builder: (items) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final item = items[index] as EventItemModel;
            return ChatCard(
              content: item.content,
              name: item.createName ?? '',
              topic: item.gambitTitle ?? '',
              contentImg: item.imgUrls,
              date: item.date,
              id: item.createId,
              headImg: item.headSculptureImgUrl,
              themeId: item.id,
              initLike: item.isLike == 1,
              comments: item.gambitThemeCommentVoList,
              likeNames: item.likeNames,
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
