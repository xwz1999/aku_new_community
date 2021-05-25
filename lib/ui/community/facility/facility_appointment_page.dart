import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_community/ui/community/facility/facility_appointment_view.dart';
import 'package:aku_community/ui/community/facility/pick_facility_page.dart';
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
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.add_circled),
          onPressed: () async{
           await Get.to(() => PickFacilityPage());
            childKey.currentState!.callRefresh();
          },
        ),
      ],
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: ['我的预约', '历史预约'],
      ),
      body: TabBarView(
        children: [
          FacilityAppointmentView(
            type: FacilityAppointmentType.MY,
            key: childKey,
          ),
          FacilityAppointmentView(type: FacilityAppointmentType.HISTORY,),
        ],
        controller: _tabController,
      ),
    );
  }
}
