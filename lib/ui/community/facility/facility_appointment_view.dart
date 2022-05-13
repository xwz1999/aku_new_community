import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/models/facility/facility_appointment_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/community/facility/facility_appointment_card.dart';
import 'package:aku_new_community/utils/headers.dart';

enum FacilityAppointmentType {
  MY,
  HISTORY,
}

GlobalKey<_FacilityAppointmentViewState> childKey = GlobalKey();

class FacilityAppointmentView extends StatefulWidget {
  final FacilityAppointmentType type;

  FacilityAppointmentView({Key? key, required this.type}) : super(key: key);

  @override
  _FacilityAppointmentViewState createState() =>
      _FacilityAppointmentViewState();
}

class _FacilityAppointmentViewState extends State<FacilityAppointmentView> {
  EasyRefreshController _refreshController = EasyRefreshController();

  int get _facilityType {
    switch (widget.type) {
      case FacilityAppointmentType.MY:
        return 1;
      case FacilityAppointmentType.HISTORY:
        return 2;
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void callRefresh() {
    return _refreshController.callRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return BeeListView(
      path: SAASAPI.facilities.list,
      controller: _refreshController,
      convert: (model) =>
          model.rows.map((e) => FacilityAppointmentModel.fromJson(e)).toList(),
      extraParams: {'facilitiesType': _facilityType},
      builder: (items) {
        return ListView.separated(
          padding: EdgeInsets.all(32.w),
          itemBuilder: (context, index) {
            return FacilityAppointmentCard(
              model: items[index],
              onUpdate: () {
                _refreshController.callRefresh();
              },
            );
          },
          separatorBuilder: (_, __) => 32.hb,
          itemCount: items.length,
        );
      },
    );
  }
}
