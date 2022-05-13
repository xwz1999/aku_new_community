import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/models/facility/facility_type_detail_model.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/community/facility/facility_order_date_list_page.dart';
import 'package:aku_new_community/ui/community/facility/facility_type_detail_page.dart';
import 'package:aku_new_community/ui/profile/house/pick_my_house_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/picker/bee_date_picker.dart';
import '../../../constants/saas_api.dart';
import '../../../models/facility/facility_type_model.dart';
import '../../../widget/picker/bee_day_picker.dart';
import '../../manager/advice/advice_house_page.dart';

class FacilityPreorderPage extends StatefulWidget {
  final FacilityTypeModel facilityModel;
  final FacilityTypeDetailModel typeModel;

  FacilityPreorderPage({Key? key, required this.facilityModel,required this.typeModel}) : super(key: key);

  @override
  _FacilityPreorderPageState createState() => _FacilityPreorderPageState();
}

class _FacilityPreorderPageState extends State<FacilityPreorderPage> {
  DateTime? startDate;
  DateTime? endDate;

  bool get canTap => startDate != null && endDate != null;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
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
            onTap: () => Get.to(() => AdviceHousePage()),
            title: Text(S.of(context)!.tempPlotName),
            subtitle: Text(userProvider.defaultHouse!.addressName),
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
            onTap: () async {await Get.to(() =>
                  FacilityTypeDetailPage(facilityModel: widget.facilityModel));
              setState(() {});
            },
            title: Text(S.of(context)!.tempPlotName),
            subtitle: Text(widget.typeModel.name),
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
                    DateTime? date = await BeeDayPicker.pick(DateTime.now());
                    BeeDayPicker.pick(DateTime.now());
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
                            format: 'yyyy/MM/dd',
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
                      startDate == null
                          ? DateTime.now().add(Duration(minutes: 90))
                          : startDate!.add(Duration(minutes: 30)),
                      min: startDate == null
                          ? DateTime.now().add(Duration(minutes: 60))
                          : startDate!.add(Duration(minutes: 30)),
                      max: startDate == null
                          ? DateTime.now().add(Duration(days: 2))
                          : (startDate!).add(Duration(days: 2)),
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
                // if (dateDifferenceIsTrue) {
                final cancel = BotToast.showLoading();
                var model = await NetUtil().post(
                  SAASAPI.facilities.insert,
                  params: {
                    'estateId': userProvider.defaultHouse!.id,
                    'type':widget.facilityModel.type,
                    'facilitiesCategoryId':widget.facilityModel.id,
                    'facilitiesManageId':widget.typeModel.id,
                    'appointmentDate':1,
                    'appointmentPeriodList':1,
                  },
                );
                cancel();
                if (model.success == true) {
                  BotToast.showText(text: '预约成功');
                  Get.back(result: true);
                } else if (model.msg == '该时段已被预约') {
                  await Get.dialog(_hasBeenOrder());
                } else {
                  BotToast.showText(text: '预约失败');
                }
                // } else {
                //   BotToast.showText(text: '预约时间必须为半小时的整数倍');
                // }
              }
            : null,
        child: Text('确认提交'),
      ),
    );
  }

  bool get dateDifferenceIsTrue {
    if (startDate != null && endDate != null) {
      int _diff = endDate!.difference(startDate!).inMinutes;
      if (_diff < 30) {
        return false;
      } else if (_diff % 30 != 0) {
        return false;
      }
      return true;
    }
    return false;
  }

  Widget _hasBeenOrder() {
    return CupertinoAlertDialog(
      title: '此设施已被预约'
          .text
          .size(32.sp)
          .bold
          .color(ktextPrimary)
          .isIntrinsic
          .make(),
      content: '是否查看此设施已被预约时段？'
          .text
          .size(28.sp)
          .color(ktextPrimary)
          .isIntrinsic
          .make(),
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child:
                '取消'.text.size(30.sp).color(ktextPrimary).isIntrinsic.make()),
        CupertinoActionSheetAction(
            onPressed: () {
              Get.off(
                  () => FacilityOrderDateListPage(facilitiesId: widget.typeModel.id));
            },
            child:
                '查看'.text.size(30.sp).color(kPrimaryColor).isIntrinsic.make()),
      ],
    );
  }
}
