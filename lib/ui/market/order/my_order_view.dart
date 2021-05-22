import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/market/order/my_order_list_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/ui/market/order/my_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class MyOrderView extends StatefulWidget {
  final int index;
  MyOrderView({Key? key, required this.index}) : super(key: key);

  @override
  _MyOrderViewState createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
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
    return BeeListView(
        path: API.market.myOrderList,
        controller: _refreshController,
        extraParams: {
          "orderStart":widget.index+1
        },
        convert: (models) {
          return models.tableList!
              .map((e) => MyOrderListModel.fromJson(e))
              .toList();
        },
        builder: (items) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 24.w,horizontal: 32.w),
              itemBuilder: (context, index) {
                return MyOrderCard(
                  model: items[index],
                  callRefresh: () {
                    _refreshController.callRefresh();
                  },
                );
              },
              separatorBuilder: (_, __) {
                return 24.w.heightBox;
              },
              itemCount: items.length);
        });
  }
}
