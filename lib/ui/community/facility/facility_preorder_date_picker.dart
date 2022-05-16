import 'package:flutter/cupertino.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/models/facility/facility_type_detail_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/picker/bee_choose_date_picker.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../../utils/network/base_model.dart';
import '../../../utils/network/net_util.dart';
import '../../../widget/buttons/bee_check_radio.dart';

class FacilityPreorderDatePicker extends StatefulWidget {
  FacilityTypeDetailModel typeModel;

  FacilityPreorderDatePicker({Key? key, required this.typeModel})
      : super(key: key);

  @override
  State<FacilityPreorderDatePicker> createState() =>
      _FacilityPreorderDatePickerState();
}

class _FacilityPreorderDatePickerState
    extends State<FacilityPreorderDatePicker> {
  List<int> get _num => List.generate(
      getNum(widget.typeModel.openEndDT!) -
          getNum(widget.typeModel.openStartDT!),
      (index) => index + 1);
  DateTime? start;
  List<int> models = [];

  List<int> _selectIndex = [];

  @override
  Widget build(BuildContext context) {
    return BeeChooseDatePicker(
      height: 700.h,
      onPressed: () {
        Get.back();
      },
      body: Container(
        height: 600.h,
        child: ListView.separated(
          padding: EdgeInsets.all(32.w),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _datesList(index),
                20.hb,
                Divider(
                  height: 1.0,
                  color: Colors.black12,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => 32.hb,
          itemCount: _num.length,
        ),
      ),
    );
  }

  Widget _datesList(int index) {
    DateTime start = widget.typeModel.openStartDT!;
    () async {
      BaseModel model =
          await NetUtil().get(SAASAPI.facilities.allAppointmentPeriod, params: {
        'facilitiesManageId': widget.typeModel.id,
        'todayDate': DateTime.now(),
      });
      if (model.success) {
        models = (model.data as List<int>).toList();
      }
    };
    return GestureDetector(
      onTap: () {
        print(getNum(start)+index);
        if(!models.contains(getNum(start)+index)||start.add(Duration(minutes: 30 * index)).isAfter(DateTime.now())){
          if (_selectIndex.contains(index)) {
            _selectIndex.remove(index);
          } else {
            _selectIndex.add(index);
          }
        }
        setState(() {});
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BeeCheckRadio(
            value: index,
            groupValue: _selectIndex,
            canCheck: models.contains(getNum(start)+index),
          ),
          30.wb,
          Text(
            '${DateUtil.formatDate(start.add(Duration(minutes: 30 * index)), format: 'HH:mm')}'
            '~${DateUtil.formatDate(start.add(Duration(minutes: 30 * (index + 1))), format: 'HH:mm')}',
            style: TextStyle(
              fontSize: 30.sp,
            ),
          ),
          Spacer(),
          isPass(start.add(Duration(minutes: 30 * index)))
              ? '已过期'
                  .text
                  .size(30.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make()
              : models.contains(getNum(start)+index)
                  ? '已被他人预约'
                      .text
                      .size(30.sp)
                      .color(Colors.black.withOpacity(0.45))
                      .make()
                  : SizedBox(),
        ],
      ),
    );
  }
}

bool isPass(DateTime date){
  if(date.hour<DateTime.now().hour||(date.minute<DateTime.now().minute&&date.hour==DateTime.now().hour)){
    return true;
  }
  else{
    return false;
  }

}

int getNum(DateTime dateTime) {
  int hour, minute;
  hour = dateTime.hour;
  minute = dateTime.minute;
  if (minute > 0) {
    return hour * 2;
  }
  return hour * 2 + 1;
}
