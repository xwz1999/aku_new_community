// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';

// Project imports:
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/visitor_list_item_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/ui/manager/visitor/visitor_list_item.dart';
import 'package:akuCommunity/utils/headers.dart';

class VisitorRecordView extends StatefulWidget {
  ///访客状态（1.未到，2.已到）
  final int type;
  VisitorRecordView({Key key, @required this.type}) : super(key: key);

  @override
  _VisitorRecordViewState createState() => _VisitorRecordViewState();
}

class _VisitorRecordViewState extends State<VisitorRecordView> {
  EasyRefreshController _refreshController = EasyRefreshController();

 
  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeListView(
      controller: _refreshController,
      path: API.manager.visitorAccessList,
      extraParams: {'visitorStatus': widget.type},
      convert: (model) {
        return model.tableList
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