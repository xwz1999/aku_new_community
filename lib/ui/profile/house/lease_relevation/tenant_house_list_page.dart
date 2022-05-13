import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/house/lease_list_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/profile/house/lease_relevation/lease_house_card.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class TenantHouseListPage extends StatefulWidget {
  final int leaseId;

  TenantHouseListPage({Key? key, this.leaseId = 0}) : super(key: key);

  @override
  _TenantHouseListPageState createState() => _TenantHouseListPageState();
}

class _TenantHouseListPageState extends State<TenantHouseListPage> {
  late EasyRefreshController _refreshController;

  @override
  void initState() {
    _refreshController = EasyRefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '可选房屋',
      body: BeeListView(
          path: API.house.leaseList,
          controller: _refreshController,
          extraParams: {'leaseParentId': widget.leaseId},
          convert: (models) {
            return models.rows.map((e) => LeaseListModel.fromJson(e)).toList();
          },
          builder: (items) {
            return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
                itemBuilder: (context, index) {
                  return LeaseHouseCard(model: items[index]);
                },
                separatorBuilder: (_, __) {
                  return 24.w.heightBox;
                },
                itemCount: items.length);
          }),
    );
  }
}
