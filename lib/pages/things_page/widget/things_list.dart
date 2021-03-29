import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:akuCommunity/utils/headers.dart';
import 'things_card.dart';

class ThingsList extends StatefulWidget {
  final List<Map<String, dynamic>> listCard;
  final bool isRepair;
  ThingsList({Key key, this.listCard, this.isRepair}) : super(key: key);

  @override
  _ThingsListState createState() => _ThingsListState();
}

class _ThingsListState extends State<ThingsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 98.w),
      itemBuilder: (context, index) => ThingsCard(
        time: widget.listCard[index]['time'],
        tag: widget.listCard[index]['tag'],
        content: widget.listCard[index]['content'],
        imageList: widget.listCard[index]['imageList'],
        isRepair: widget.isRepair,
      ),
      itemCount: widget.listCard.length,
    );
  }
}
