import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/manager/visitor_list_item_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/manager/visitor/visitor_list_item.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class VisitorRecordView extends StatefulWidget {
  ///访客状态（1.已分享，2.已提交，3.已到期）
  final int type;

  VisitorRecordView({Key? key, required this.type}) : super(key: key);

  @override
  _VisitorRecordViewState createState() => _VisitorRecordViewState();
}

class _VisitorRecordViewState extends State<VisitorRecordView> {
  EasyRefreshController _refreshController = EasyRefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeListView<VisitorListItemModel>(
      controller: _refreshController,
      path: API.manager.visitorAccessList,
      extraParams: {'visitorInviteStatus': widget.type},
      convert: (model) {
        return model.rows.map((e) => VisitorListItemModel.fromJson(e)).toList();
      },
      builder: (items) {
        return ListView.separated(
          separatorBuilder: (_, __) => Divider(
            indent: 32.w,
            endIndent: 32.w,
            height: 1.w,
          ),
          itemBuilder: (context, index) {
            return VisitorListItem(model: items[index], type: widget.type);
          },
          itemCount: items.length,
        );
      },
    );
  }
}
