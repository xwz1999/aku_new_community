import 'package:akuCommunity/ui/community/community_views/topic/topic_scrollable_text.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';

class TopicDetailPage extends StatefulWidget {
  final int id;
  TopicDetailPage({Key key, @required this.id}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 500.w,
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: TopicScrollableText(title: '#TEST'),
              titlePadding: EdgeInsets.zero,
              collapseMode: CollapseMode.pin,
              background: Container(color: Colors.red),
            ),
          ),
          SliverToBoxAdapter(
            child: 40000.hb,
          ),
        ],
      ),
    );
  }
}
