import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/community/community_topic_model.dart';
import 'package:akuCommunity/model/community/event_item_model.dart';
import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/ui/community/community_views/add_new_event_page.dart';
import 'package:akuCommunity/ui/community/community_views/topic/topic_sliver_header.dart';
import 'package:akuCommunity/ui/community/community_views/widgets/chat_card.dart';
import 'package:akuCommunity/utils/login_util.dart';

class TopicDetailPage extends StatefulWidget {
  final CommunityTopicModel model;

  TopicDetailPage({Key key, this.model}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'event_add',
        onPressed: () async {
          if (LoginUtil.isNotLogin) return;
          bool result = await Get.to(AddNewEventPage());
        },
        child: Icon(Icons.add),
      ),
      body: BeeListView(
        convert: (model) {
          return model.tableList
              .map((e) => EventItemModel.fromJson(e))
              .toList();
        },
        path: API.community.eventByTopicId,
        extraParams: {'gambitId': widget.model.id},
        controller: _refreshController,
        builder: (items) {
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: TopicSliverHeader(
                  id: widget.model.id,
                  title: widget.model.summary,
                  imgPath: widget.model.firstImg,
                  subTitle: widget.model.content,
                ),
                pinned: true,
                floating: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = items[index] as EventItemModel;
                    return ChatCard(
                      model: item,
                      onDelete: () {
                        _refreshController.callRefresh();
                      },
                    );
                  },
                  childCount: items.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
