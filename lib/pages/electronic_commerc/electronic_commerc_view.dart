import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/electronic_commerc/electronic_commerc_list_model.dart';
import 'package:aku_community/pages/electronic_commerc/electronic_commerc_card.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';

class ElectronicCommercView extends StatefulWidget {
  final int id;
  ElectronicCommercView({Key? key, required this.id}) : super(key: key);

  @override
  _ElectronicCommercViewState createState() => _ElectronicCommercViewState();
}

class _ElectronicCommercViewState extends State<ElectronicCommercView> {
  late EasyRefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   padding: EdgeInsets.symmetric(vertical: 24.w,horizontal: 32.w),
    //   children: [
    //     ElectronicCommercCard(index: widget.index),
    //   ],
    // );
    return BeeListView(
        path: API.manager.electronicCommercList,
        controller: _refreshController,
        extraParams: {"electronicCommerceCategoryId": widget.id},
        convert: (models) {
          return models.tableList!
              .map((e) => ElectronicCommercListModel.fromJson(e))
              .toList();
        },
        builder: (items) {
          return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 24.w),
              itemBuilder: (context, index) {
                return ElectronicCommercCard(
                  model: items[index],
                );
              },
              separatorBuilder: (_, __) {
                return 24.w.heightBox;
              },
              itemCount: items.length);
        });
  }
}
