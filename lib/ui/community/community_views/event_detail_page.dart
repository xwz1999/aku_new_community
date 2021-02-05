import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';

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
