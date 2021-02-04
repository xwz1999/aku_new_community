import 'package:akuCommunity/model/community/community_topic_model.dart';
import 'package:akuCommunity/ui/community/community_views/topic/topic_sliver_header.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';

class TopicDetailPage extends StatefulWidget {
  final CommunityTopicModel model;

  TopicDetailPage({Key key, this.model}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: TopicSliverHeader(
              id: widget.model.id,
              title: 'TEST',
              imgPath: widget.model.firstImg,
              subTitle: widget.model.content,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: 40000.hb,
          ),
        ],
      ),
    );
  }
}
