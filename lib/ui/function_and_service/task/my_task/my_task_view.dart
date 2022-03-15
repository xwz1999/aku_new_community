import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/models/task/my_task_list_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'my_task_card.dart';

class MyTaskView extends StatefulWidget {
  final EasyRefreshController refreshController;
  final int type;
  const MyTaskView(
      {Key? key, required this.refreshController, required this.type})
      : super(key: key);

  @override
  _MyTaskViewState createState() => _MyTaskViewState();
}

class _MyTaskViewState extends State<MyTaskView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeListView(
        path: SARSAPI.task.list,
        controller: widget.refreshController,
        extraParams: {
          'taskModel': 2,
          'type': widget.type + 1,
        },
        convert: (json) =>
            json.rows.map((e) => MyTaskListModel.fromJson(e)).toList(),
        builder: (models) {
          return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
              itemBuilder: (context, index) {
                return MyTaskCard(
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
