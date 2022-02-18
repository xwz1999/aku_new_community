import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/ui/service/hall/hall_view.dart';
import 'package:aku_new_community/ui/service/my_take_task/my_take_task_view.dart';
import 'package:aku_new_community/ui/service/my_task/my_task_view.dart';
import 'package:aku_new_community/ui/service/publish_task_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/painter/tab_indicator.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  late TabController _tabController;

  List<String> _tabs = ['大厅', '我服务的', '我发布的'];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '',
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => PublishTaskPage());
            },
            icon: Icon(
              Icons.add_circle_outline,
              size: 40.w,
              color: Colors.black,
            ))
      ],
      appBarBottom: PreferredSize(
          preferredSize: Size.fromHeight(88.w),
          child: Row(
            children: [
              ..._tabs
                  .mapIndexed(
                      (currentValue, index) => _tabCard(currentValue, index))
                  .toList(),
            ],
          )),
      body: SafeArea(
          child: TabBarView(controller: _tabController, children: [
        HallView(),
        MyTakeTaskView(),
        MyTaskView(),
      ])),
    );
  }

  Widget _tabCard(String title, int index) {
    var select = index == _tabController.index;
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
        setState(() {});
      },
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title.text
                  .size(select ? 36.sp : 32.sp)
                  .fontWeight(select ? FontWeight.bold : FontWeight.normal)
                  .color(Colors.black.withOpacity(select ? 0.85 : 0.65))
                  .make(),
              8.w.heightBox,
              select ? TabIndicator() : 10.w.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
