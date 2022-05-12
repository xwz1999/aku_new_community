import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/cupertino.dart';
import '../../../utils/network/net_util.dart';
import '../../../widget/buttons/bee_check_radio.dart';

class FacilityPreorderDatePicker extends StatefulWidget {
  const FacilityPreorderDatePicker({Key? key}) : super(key: key);

  @override
  State<FacilityPreorderDatePicker> createState() =>
      _FacilityPreorderDatePickerState();
}

class _FacilityPreorderDatePickerState extends State<FacilityPreorderDatePicker> {
  List<int> get _num => List.generate(48, (index) => index + 1);
  List? _models;

  @override
  void initState() async{
    var base =
    await NetUtil().get(SAASAPI.facilities.allAppointmentPeriod, params: {
      'facilitiesManageId': widget,
      'todayDate':DateTime.now(),
    });
    if (base.success) {
      _models = (base.data as List).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: _num
            .map((e) => Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child:
                        Text(e.toString() + '年', textAlign: TextAlign.center),
                  ),
                ))
            .toList());
  }

  Widget _datesList() {
    DateTime date=DateTime.now();
    return Row(
      children: [
        BeeCheckRadio(
          value: _num,
          // groupValue: SAASAPI.facilities.allAppointmentPeriod,
        ),
        Text('${date}~${date.add(Duration(minutes: 30))}'),
      ],
    );
  }
}
