// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/widget/bee_scaffold.dart';

class EventDetailPage extends StatefulWidget {
  EventDetailPage({Key key}) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '详情',
    );
  }
}
