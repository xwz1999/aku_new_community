import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:power_logger/power_logger.dart';
import 'package:velocity_x/src/extensions/num_ext.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/saas_model/work_order/work_order_list_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import '../work_order_card.dart';

class AllOrderView extends StatefulWidget {
  final EasyRefreshController refreshController;
  final int index;
  const AllOrderView(
      {Key? key, required this.refreshController, required this.index})
      : super(key: key);

  @override
  _AllOrderViewState createState() => _AllOrderViewState();
}

class _AllOrderViewState extends State<AllOrderView>
    with SingleTickerProviderStateMixin {
  int _page = 1;
  int _size = 10;
  List<WorkOrderListModel> _models = [];
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        firstRefresh: true,
        controller: widget.refreshController,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {
          _page = 1;
          try {
            var base = await NetUtil().getList(SAASAPI.workOrder.list, params: {
              'pageNum': _page,
              'size': _size,
              'status': widget.index == 0 ? null : widget.index,
            });
            _models =
                base.rows.map((e) => WorkOrderListModel.fromJson(e)).toList();
          } catch (e) {
            LoggerData.addData(e.toString());
          }
          setState(() {});
        },
        onLoad: () async {
          _page++;
          var base = await NetUtil().getList(SAASAPI.workOrder.list, params: {
            'pageNum': _page,
            'size': _size,
            'status': widget.index == 0 ? null : widget.index,
          });
          if (_models.length < base.total) {
            _models.addAll(
                base.rows.map((e) => WorkOrderListModel.fromJson(e)).toList());
            setState(() {});
          } else {
            widget.refreshController.finishLoad(noMore: true);
          }
        },
        child: _models.isEmpty
            ? Container()
            : ListView.separated(
                padding: EdgeInsets.all(24.w),
                itemBuilder: (context, index) {
                  return WorkOrderCard(
                    model: _models[index],
                    refresh: widget.refreshController.callRefresh,
                  );
                },
                separatorBuilder: (context, index) {
                  return 24.w.heightBox;
                },
                itemCount: _models.length));
    ;
  }
}
