import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/saas_model/task/hall_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/src/extensions/num_ext.dart';

import 'hall_card.dart';

class HallView extends StatefulWidget {
  final EasyRefreshController refreshController;
  final int type;

  const HallView(
      {Key? key, required this.refreshController, required this.type})
      : super(key: key);

  @override
  _HallViewState createState() => _HallViewState();
}

class _HallViewState extends State<HallView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeListView(
        path: SAASAPI.task.list,
        controller: widget.refreshController,
        extraParams: {
          'taskModel': 1,
          'type': widget.type == 0 ? null : widget.type,
        },
        convert: (json) =>
            json.rows.map((e) => HallListModel.fromJson(e)).toList(),
        builder: (models) {
          return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
              itemBuilder: (context, index) {
                return HallCard(
                    key: ValueKey(models[index].id),
                    model: models[index],
                    refresh: () => widget.refreshController.callRefresh());
              },
              separatorBuilder: (_, __) {
                return 24.w.heightBox;
              },
              itemCount: models.length);
        });
  }
}
