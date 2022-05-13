import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_new_community/models/facility/facility_type_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/community/facility/facility_type_card.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import '../../../constants/saas_api.dart';
import '../../../widget/tab_bar/bee_tab_bar.dart';

class PickFacilityPage extends StatefulWidget {
  PickFacilityPage({Key? key}) : super(key: key);

  @override
  _PickFacilityPageState createState() => _PickFacilityPageState();
}

class _PickFacilityPageState extends State<PickFacilityPage> with TickerProviderStateMixin{
  final EasyRefreshController _refreshController = EasyRefreshController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择设施类型',
      // actions: [
      //   IconButton(
      //     icon: Icon(CupertinoIcons.doc_text),
      //     onPressed: () async {
      //       await Get.to(() => FacilityAppointmentPage());
      //       childKey.currentState!.callRefresh();
      //     },
      //   ),
      // ],
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: ['设备分类', '设施分类'],
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(2, (index) {
          return BeeListView<FacilityTypeModel>(
            path: SAASAPI.facilities.categoryList,
            extraParams: {'type': index+1},
            controller: _refreshController,
            convert: (model) => model.rows
                .map((e) => FacilityTypeModel.fromJson(e))
                .toList(),
            builder: (items) {
              return GridView.builder(
                padding: EdgeInsets.all(30.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 30.w,
                  mainAxisSpacing: 30.w,
                ),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return FacilityTypeCard(model: items[index],);
                },
              );
            },
          );
        }).toList(),
      ),

      // BeeListView<FacilityTypeModel>(
      //   path: SAASAPI.communityIntroduction.categoryList,
      //   controller: _refreshController,
      //   convert: (model) =>
      //       model.rows.map((e) => FacilityTypeModel.fromJson(e)).toList(),
      //   builder: (items) {
      //     return ListView.separated(
      //       padding: EdgeInsets.all(32.w),
      //       itemBuilder: (context, index) {
      //         return FacilityTypeCard(model: items[index]);
      //       },
      //       separatorBuilder: (context, index) => 32.hb,
      //       itemCount: items.length,
      //     );
      //   },
      // ),
    );
  }
}
