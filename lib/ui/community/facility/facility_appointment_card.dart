import 'package:aku_community/models/facility/facility_appointment_model.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/utils/headers.dart';

class FacilityAppointmentCard extends StatelessWidget {
  final FacilityAppointmentModel model;
  const FacilityAppointmentCard({Key? key, required this.model})
      : super(key: key);

  Widget _renderTile({
    required String path,
    required String name,
    required String subTitle,
  }) {
    return Row(
      children: [
        Image.asset(
          path,
          height: 40.w,
          width: 40.w,
        ),
        12.wb,
        Text(name),
        Spacer(),
        Text(subTitle),
      ],
    );
  }

  Widget _renderButton() {
    var showTip = model.status == 1 || model.status == 2;
    return Row(
      children: [
        if (showTip) Text('请在预约时间前30分钟内到场扫码'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                model.facilitiesName,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                model.statusValue,
                style: TextStyle(
                  color: model.statusColor,
                  fontSize: 30.sp,
                ),
              ),
            ],
          ),
          16.hb,
          BeeDivider(),
          24.hb,
          _renderTile(
            path: R.ASSETS_ICONS_APPOINTMENT_CODE_PNG,
            name: '预约编号',
            subTitle: model.code,
          ),
          _renderTile(
            path: R.ASSETS_ICONS_APPOINTMENT_ADDRESS_PNG,
            name: '设施地址',
            subTitle: model.address,
          ),
          _renderTile(
            path: R.ASSETS_ICONS_APPOINTMENT_DATE_PNG,
            name: '预约时段',
            subTitle: model.displayDate,
          ),
          24.hb,
          _renderButton(),
        ],
      ),
    );
  }
}
