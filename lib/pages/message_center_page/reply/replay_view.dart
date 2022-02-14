import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/models/message/reply_list_model.dart';
import 'package:aku_new_community/pages/message_center_page/reply/reply_card.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ReplayView extends StatefulWidget {
  final EasyRefreshController controller;
  const ReplayView({Key? key, required this.controller}) : super(key: key);

  @override
  _ReplayViewState createState() => _ReplayViewState();
}

class _ReplayViewState extends State<ReplayView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeListView(
        path: SARSAPI.message.allComment,
        controller: widget.controller,
        convert: (models) =>
            models.tableList!.map((e) => ReplyListModel.fromJson(e)).toList(),
        builder: (items) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return ReplyCard(model: items[index]);
              },
              separatorBuilder: (_, __) => 20.w.heightBox,
              itemCount: items.length);
        });
  }
}
