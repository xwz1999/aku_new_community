import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/community/community_topic_model.dart';
import 'package:akuCommunity/model/community/event_item_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/ui/community/community_views/topic/topic_sliver_header.dart';
import 'package:akuCommunity/ui/community/community_views/widgets/chat_card.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
        onPressed: () {},
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
                  title: 'TEST',
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
                      content: item.content,
                      name: item.createName,
                      topic: item.gambitTitle,
                      headImg: item.headSculptureImgUrl,
                      contentImg: item.imgUrls,
                      date: item.date,
                      id: item.createId,
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
