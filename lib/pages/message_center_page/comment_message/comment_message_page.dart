import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/message/comment_message_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CommentMessagePage extends StatefulWidget {
  CommentMessagePage({Key key}) : super(key: key);

  @override
  _CommentMessagePageState createState() => _CommentMessagePageState();
}

class _CommentMessagePageState extends State<CommentMessagePage> {
  EasyRefreshController _easyRefreshController;
  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _easyRefreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '评论通知',
      body: BeeListView(
          path: API.message.commentMessageList,
          controller: _easyRefreshController,
          convert: (models) {
            return models.tableList
                .map((e) => CommentMessageModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return Container();
          }),
    );
  }
}
