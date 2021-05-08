import 'package:aku_community/models/facility/facility_type_detail_model.dart';
import 'package:aku_community/ui/community/facility/facility_type_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/constants/app_theme.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/ui/profile/house/pick_my_house_page.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/picker/bee_date_picker.dart';

class FacilityPreorderPage extends StatefulWidget {
  final int id;
  FacilityPreorderPage({Key? key, required this.id}) : super(key: key);

  @override
  _FacilityPreorderPageState createState() => _FacilityPreorderPageState();
}

class _FacilityPreorderPageState extends State<FacilityPreorderPage> {
  FacilityTypeDetailModel? typeModel;
  DateTime? startDate;
  DateTime? endDate;

  bool get canTap => startDate != null && endDate != null && typeModel != null;
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '添加预订',
      bodyColor: Colors.white,
      systemStyle: SystemStyle.yellowBottomBar,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 32.w),
        children: [
          Text('业主房屋').pSymmetric(h: 32.w),
          ListTile(
            leading: Image.asset(
              R.ASSETS_ICONS_HOUSE_PNG,
              height: 60.w,
              width: 60.w,
            ),
            onTap: () => Get.to(() => PickMyHousePage()),
            title: Text(S.of(context)!.tempPlotName),
            subtitle: Text(appProvider.selectedHouse?.roomName ?? '选择房间'),
            trailing: Icon(CupertinoIcons.chevron_forward),
          ),
          BeeDivider(
            indent: 32.w,
            endIndent: 32.w,
          ),
          32.hb,
          Text('选择设施').pSymmetric(h: 32.w),
          ListTile(
            leading: Image.asset(
              R.ASSETS_ICONS_FACILITY_PNG,
              height: 60.w,
              width: 60.w,
            ),
            onTap: () async {
              FacilityTypeDetailModel? model =
                  await Get.to(() => FacilityTypeDetailPage(model: typeModel, id: widget.id));
              if (model != null) typeModel = model;
              setState(() {});
            },
            title: Text(S.of(context)!.tempPlotName),
            subtitle: Text(typeModel?.name ?? '选择设施'),
            trailing: Icon(CupertinoIcons.chevron_forward),
          ),
          BeeDivider(
            indent: 32.w,
            endIndent: 32.w,
          ),
          32.hb,
          Text('预约时间').pSymmetric(h: 32.w),
          SizedBox(
            height: 120.w,
            child: Row(
              children: [
                MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  height: 120.w,
                  onPressed: () async {
                    DateTime? date = await BeeDatePicker.pick(
                      DateTime.now(),
                      mode: CupertinoDatePickerMode.dateAndTime,
                      min: DateTime.now().subtract(Duration(seconds: 1)),
                      max: DateTime.now().add(Duration(days: 30)),
                    );
                    if (date != null) {
                      startDate = date;
                      setState(() {});
                    }
                  },
                  child: Text(
                    startDate == null
                        ? '请选择开始时间'
                        : DateUtil.formatDate(
                            startDate,
                            format: 'yyyy-MM-dd HH:mm',
                          ),
                    style: TextStyle(
                      color: ktextSubColor,
                    ),
                  ),
                ).expand(),
                Icon(Icons.arrow_forward),
                MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  height: 120.w,
                  onPressed: () async {
                    DateTime? date = await BeeDatePicker.pick(
                      startDate == null ? DateTime.now() : startDate!,
                      min: startDate == null
                          ? DateTime.now().subtract(Duration(seconds: 1))
                          : startDate!,
                      max: startDate == null
                          ? DateTime.now().add(Duration(days: 1))
                          : (startDate!).add(Duration(days: 1)),
                      mode: CupertinoDatePickerMode.dateAndTime,
                    );
                    if (date != null) {
                      endDate = date;
                      setState(() {});
                    }
                  },
                  child: Text(
                    endDate == null
                        ? '请选择结束时间'
                        : DateUtil.formatDate(
                            endDate,
                            format: 'yyyy-MM-dd HH:mm',
                          ),
                    style: TextStyle(
                      color: ktextSubColor,
                    ),
                  ),
                ).expand(),
              ],
            ),
          ),
          BeeDivider(
            indent: 32.w,
            endIndent: 32.w,
          ),
        ],
      ),
      bottomNavi: BottomButton(
        onPressed: canTap
            ? () async {
                final cancel = BotToast.showLoading();
                var model = await NetUtil().post(
                  API.manager.facility.add,
                  params: {
                    'estateId': appProvider.selectedHouse?.estateId ?? 0,
                    'facilitiesManageId': typeModel!.id,
                    'appointmentStartDate': NetUtil.getDate(startDate!),
                    'appointmentEndDate': NetUtil.getDate(endDate!),
                  },
                  showMessage: true,
                );
                cancel();
                if (model.status == true) Get.back(result: true);
              }
            : null,
        child: Text('确认提交'),
      ),
    );
  }
}
