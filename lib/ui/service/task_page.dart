import 'package:aku_new_community/ui/service/hall/hall_view.dart';
import 'package:aku_new_community/ui/service/my_take_task/my_take_task_view.dart';
import 'package:aku_new_community/ui/service/my_task/my_task_view.dart';
import 'package:aku_new_community/ui/service/publish_task_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/painter/tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  late TabController _tabController;

  List<String> _tabs = ['大厅', '我服务的', '我发布的'];
  List<String> _types = ['跑腿', '家政', '维修', '家教', '其他'];
  List<EasyRefreshController> _refreshControllers = [];
  int _currentType = 0;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _refreshControllers = _tabs.map((e) => EasyRefreshController()).toList();
    super.initState();
  }

  @override
  void dispose() {
    _refreshControllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
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
          preferredSize: Size.fromHeight((88 + 50 + 48).w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    ..._tabs
                        .mapIndexed((currentValue, index) =>
                            _tabCard(currentValue, index))
                        .toList(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
                child: Row(
                  children: _types
                      .mapIndexed((currentValue, index) =>
                          _typeBar(currentValue, index))
                      .toList(),
                ),
              )
            ],
          )),
      body: SafeArea(
          child: TabBarView(controller: _tabController, children: [
        HallView(
          refreshController: _refreshControllers[0],
          type: _currentType,
        ),
        MyTakeTaskView(
          refreshController: _refreshControllers[1],
          type: _currentType,
        ),
        MyTaskView(
          refreshController: _refreshControllers[2],
          type: _currentType,
        ),
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

  Widget _typeBar(String text, int index) {
    return GestureDetector(
      onTap: () {
        _currentType = index;
        _refreshControllers[_tabController.index].callRefresh();
        setState(() {});
      },
      child: Material(
        color: Colors.transparent,
        child: _currentType == index
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: Color(0xFFFAC058).withOpacity(0.5),
                ),
                child: text.text
                    .size(24.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
                child: text.text
                    .size(24.sp)
                    .color(Colors.black.withOpacity(0.45))
                    .make(),
              ),
      ),
    );
  }
}
