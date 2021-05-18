import 'package:aku_community/pages/renovation_manage/renovation_manage_card.dart';
import 'package:flutter/material.dart';

class RenovationManageView extends StatefulWidget {
  final int index;
  RenovationManageView({Key? key, required this.index}) : super(key: key);

  @override
  _RenovationManageViewState createState() => _RenovationManageViewState();
}

class _RenovationManageViewState extends State<RenovationManageView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [RenovationManageCard(index: widget.index)],
    );
  }
}
