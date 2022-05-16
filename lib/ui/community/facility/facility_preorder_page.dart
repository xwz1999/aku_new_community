import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/models/facility/facility_type_detail_model.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/community/facility/facility_preorder_date_picker.dart';
import 'package:aku_new_community/ui/community/facility/facility_type_detail_page.dart';
import 'package:aku_new_community/ui/community/facility/facility_order_date_list_page.dart';
import 'package:aku_new_community/ui/community/facility/facility_type_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/picker/bee_date_picker.dart';
import '../../../constants/saas_api.dart';
import '../../../models/facility/facility_type_model.dart';
import '../../../widget/bee_avatar_widget.dart';
import '../../../widget/bee_image_network.dart';
import '../../../widget/others/user_tool.dart';
import '../../../widget/picker/bee_choose_date_picker.dart';
import '../../../widget/picker/bee_day_picker.dart';
import '../../manager/advice/advice_house_page.dart';

class FacilityPreorderPage extends StatefulWidget {
  final FacilityTypeModel facilityModel;
  final FacilityTypeDetailModel typeModel;

  FacilityPreorderPage(
      {Key? key, required this.facilityModel, required this.typeModel})
      : super(key: key);

  @override
  _FacilityPreorderPageState createState() => _FacilityPreorderPageState();
}

class _FacilityPreorderPageState extends State<FacilityPreorderPage> {
  List<int> dateList = [];
  DateTime? date;

  bool get canTap => dateList.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      title: '添加预约',
      systemStyle: SystemStyle.yellowBottomBar,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.w),
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            color: Colors.white,
            child: ListTile(
              leading: BeeAvatarWidget(
                width: 90.w,
                height: 90.w,
                imgs: UserTool.userProvider.userInfoModel!.imgList,
              ),
              onTap: () => Get.to(() => AdviceHousePage()),
              title: Text(
                UserTool.userProvider.userInfoModel!.name!,
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
              subtitle: Text(
                '租户  ' +
                    userProvider.defaultHouse!.communityName +
                    userProvider.defaultHouseString,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.45),
                  fontSize: 26.sp,
                ),
              ),
              trailing: Icon(
                CupertinoIcons.chevron_forward,
                size: 35.w,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
          ),
          20.hb,
          Container(
            padding: EdgeInsets.all(40.w),
            color: Colors.white,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await Get.to(() => FacilityTypeDetailPage(
                        facilityModel: widget.facilityModel));
                    setState(() {});
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 170.w,
                          child: '选择设施'
                              .text
                              .size(28.sp)
                              .color(Colors.black.withOpacity(0.50))
                              .make(),
                        ),
                        '${widget.typeModel.name}'
                            .text
                            .size(28.sp)
                            .color(Colors.black.withOpacity(0.85))
                            .make(),
                        Spacer(),
                        Icon(
                          CupertinoIcons.chevron_right,
                          size: 35.w,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                  ),
                ),
                30.hb,
                BeeDivider(),
                30.hb,
                GestureDetector(
                  onTap: () async {
                    date = await BeeDayPicker.pick(DateTime.now());
                    if (date != null) {
                      dateList =
                          await FacilityPreorderDate.choose(widget.typeModel);
                      dateList.sort();
                      setState(() {});
                    }
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 170.w,
                          child: '预约时间'
                              .text
                              .size(28.sp)
                              .color(Colors.black.withOpacity(0.50))
                              .make(),
                        ),
                        date != null
                            ? '${DateUtil.formatDate(date, format: 'yyyy/MM/dd')}  ${dateString(dateList)}'
                                .text
                                .size(28.sp)
                                .color(Colors.black.withOpacity(0.85))
                                .make()
                            : '请选择预约时段'
                                .text
                                .size(28.sp)
                                .color(Colors.black.withOpacity(0.85))
                                .make(),
                        Spacer(),
                        Icon(
                          CupertinoIcons.chevron_right,
                          size: 35.w,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavi: Padding(
        padding: EdgeInsets.only(
            left: 32.w,
            right: 32.w,
            bottom: MediaQuery.of(context).padding.bottom + 32.w),
        child: BeeLongButton(
          onPressed: canTap
              ? () async {
                  // if (dateDifferenceIsTrue) {
                  final cancel = BotToast.showLoading();
                  var model = await NetUtil().post(
                    SAASAPI.facilities.insert,
                    params: {
                      'estateId': userProvider.defaultHouse!.id,
                      'type': widget.facilityModel.type,
                      'facilitiesCategoryId': widget.facilityModel.id,
                      'facilitiesManageId': widget.typeModel.id,
                      'appointmentDate': DateUtil.formatDate(date,format: 'yyyy-MM-dd HH:mm:ss'),
                      'appointmentPeriodList': dateList,
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
          text: '确认提交',
        ),
      ),
    );
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
              Get.off(() =>
                  FacilityOrderDateListPage(facilitiesId: widget.typeModel.id));
            },
            child:
                '查看'.text.size(30.sp).color(kPrimaryColor).isIntrinsic.make()),
      ],
    );
  }
}

DateTime getDate(int dateNum) {
  DateTime startDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  return startDate.add(Duration(minutes: 30 * (dateNum - 1)));
}

String dateString(List<int> dates){
  if(dates.length==1)
    return '${DateUtil.formatDate(getDate(dates.first), format: 'HH:mm')}-${DateUtil.formatDate(getDate(dates.first).add(Duration(minutes: 30)), format: 'HH:mm')}';
  else{
    return '${DateUtil.formatDate(getDate(dates.first), format: 'HH:mm')}-${DateUtil.formatDate(getDate(dates.first).add(Duration(minutes: 30)), format: 'HH:mm')}等';
  }
}