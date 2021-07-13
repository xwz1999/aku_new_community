import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/house_keeping/house_keeping_list_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HouseKeepingView extends StatefulWidget {
  final int index;
  HouseKeepingView({Key? key, required this.index}) : super(key: key);

  @override
  _HouseKeepingViewState createState() => _HouseKeepingViewState();
}

class _HouseKeepingViewState extends State<HouseKeepingView> {
  late EasyRefreshController _controller;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeListView(
        path: API.manager.houseKeepingList,
        controller: _controller,
        extraParams: {
          "housekeepingStatus": widget.index == 0 ? null : widget.index
        },
        convert: (models) {
          return models.tableList!.map((e) => HouseKeepingListModel.fromJson(e)).toList();
        },
        builder: (items) {
          return ListView(
            children: [
              
            ],
          );
        });
  }
}
