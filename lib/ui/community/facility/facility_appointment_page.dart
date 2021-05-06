import 'package:flutter/material.dart';

import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/tab_bar/bee_tab_bar.dart';

class FacilityAppointmentPage extends StatefulWidget {
  FacilityAppointmentPage({Key? key}) : super(key: key);

  @override
  _FacilityAppointmentPageState createState() =>
      _FacilityAppointmentPageState();
}

class _FacilityAppointmentPageState extends State<FacilityAppointmentPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '设施预约',
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: ['我的预约', '历史预约'],
      ),
      body: SizedBox(),
    );
  }
}