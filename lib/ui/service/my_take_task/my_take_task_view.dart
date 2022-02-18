import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/models/task/my_take_task_list_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/service/my_take_task/my_take_task_card.dart';

class MyTakeTaskView extends StatefulWidget {
  const MyTakeTaskView({Key? key}) : super(key: key);

  @override
  _MyTakeTaskViewState createState() => _MyTakeTaskViewState();
}

class _MyTakeTaskViewState extends State<MyTakeTaskView> {
  EasyRefreshController _refreshController = EasyRefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeListView(
        path: API.manager.task.myTakeTask,
        controller: _refreshController,
        convert: (json) =>
            json.rows.map((e) => MyTakeTaskListModel.fromJson(e)).toList(),
        builder: (models) {
          return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
              itemBuilder: (context, index) {
                return MyTakeTaskCard(
                    model: models[index],
                    refresh: () => _refreshController.callRefresh());
              },
              separatorBuilder: (_, __) {
                return 24.w.heightBox;
              },
              itemCount: models.length);
        });
  }
}
