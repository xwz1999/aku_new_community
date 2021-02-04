import 'package:akuCommunity/model/manager/voting_detail_page.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';

class VotingDetailPage extends StatefulWidget {
  final int id;
  VotingDetailPage({Key key, this.id}) : super(key: key);

  @override
  _VotingDetailPageState createState() => _VotingDetailPageState();
}

class _VotingDetailPageState extends State<VotingDetailPage> {
  VotingDetailModel _model;
  @override
  void initState() {
    super.initState();
    ManagerFunc.voteDetail(widget.id).then((value) {
      _model = value.data;
      return true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '活动详情',
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
          vertical: 26.w,
        ),
        children: [],
      ),
    );
  }
}
