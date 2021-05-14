import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/express_package/express_package_list_model.dart';
import 'package:aku_community/pages/express_packages/express_package_card.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ExpressPackageView extends StatefulWidget {
  final int index;
  ExpressPackageView({Key? key, required this.index}) : super(key: key);

  @override
  _ExpressPackageViewState createState() => _ExpressPackageViewState();
}

class _ExpressPackageViewState extends State<ExpressPackageView> {
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
    //   padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
    //   children: [ExpressPackageCard(index: widget.index)],
    // );
    return BeeListView(
        path: API.manager.expressPackageList,
        controller: _refreshController,
        convert: (models) {
          return models.tableList
                  ?.map((e) => ExpressPackageListModel.fromJson(e))
                  .toList() ??
              [];
        },
        builder: (items) {
          return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
              itemBuilder: (context, index) {
                return ExpressPackageCard(
                  index: widget.index,
                  model: items[index],
                  callFresh: () {
                    _refreshController.callRefresh();
                  },
                );
              },
              separatorBuilder: (_, __) {
                return 16.w.heightBox;
              },
              itemCount: items.length);
        });
  }
}
