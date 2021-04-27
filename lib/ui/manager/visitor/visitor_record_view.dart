import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/manager/visitor_list_item_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/ui/manager/visitor/visitor_list_item.dart';
import 'package:aku_community/utils/headers.dart';

class VisitorRecordView extends StatefulWidget {
  ///访客状态（1.未到，2.已到）
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
      extraParams: {'visitorStatus': widget.type},
      convert: (model) {
        return model.tableList!
            .map((e) => VisitorListItemModel.fromJson(e))
            .toList();
      },
      builder: (items) {
        return ListView.separated(
          separatorBuilder: (_, __) => Divider(
            indent: 32.w,
            endIndent: 32.w,
            height: 1.w,
          ),
          itemBuilder: (context, index) {
            return VisitorListItem(model: items[index]);
          },
          itemCount: items.length,
        );
      },
    );
  }
}
