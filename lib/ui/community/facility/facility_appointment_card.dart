import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/facility/facility_appointment_model.dart';
import 'package:aku_new_community/ui/common/qr_scan.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/saas_api.dart';

class FacilityAppointmentCard extends StatelessWidget {
  final FacilityAppointmentModel model;
  final VoidCallback onUpdate;

  const FacilityAppointmentCard(
      {Key? key, required this.model, required this.onUpdate})
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
        Text(
          name,
          style: TextStyle(
            color: ktextSubColor,
          ),
        ),
        Spacer(),
        Text(subTitle),
      ],
    );
  }

  Widget _renderButton() {
    var showTip = model.status == 1 || model.status == 2;
    late Widget button;
    switch (model.status) {
      case 1:
        //1.未签到(预约时间前30分钟显示扫码签到，之前为取消预约)，
        if (model.reserveStartDt == null) button = SizedBox();
        int diffTime =
            model.reserveStartDt!.difference(DateTime.now()).inMinutes;
        bool inTime = diffTime >= 0 && diffTime <= 30;
        if (inTime)
          button = _FacilityButton(
            onPressed: () async {
              var result = await BeeQR.scan();
              if (result != null) {
                final cancel = BotToast.showLoading();
                await NetUtil().get(
                  SAASAPI.facilities.signIn,
                  params: {'appointmentCode': result},
                  showMessage: true,
                );
                cancel();
                onUpdate();
              }
            },
            text: '扫码签到',
          );
        else
          button = _FacilityButton(
            onPressed: () async {
              bool? result = await Get.dialog(
                CupertinoAlertDialog(
                  title: Text('取消预约'),
                  content: Text('您确定要取消预约吗？'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('先等等'),
                      onPressed: () => Get.back(),
                    ),
                    CupertinoDialogAction(
                      child: Text('取消预约'),
                      onPressed: () => Get.back(result: true),
                    ),
                  ],
                ),
              );
              if (result == true) {
                final cancel = BotToast.showLoading();
                await NetUtil().get(
                  SAASAPI.facilities.cancel,
                  params: {'facilitiesAppointmentId': model.id},
                  showMessage: true,
                );
                cancel();
                onUpdate();
              }
            },
            text: '取消预约',
          );
        break;
      case 2:
        button = _FacilityButton(
          onPressed: () async {
            final cancel = BotToast.showLoading();
            await NetUtil().get(
              SAASAPI.facilities.useStop,
              params: {'facilitiesAppointmentId': model.id},
              showMessage: true,
            );
            cancel();
            onUpdate();
          },
          text: '使用结束',
        );
        break;

      default:
        button = SizedBox();
    }
    return Row(
      children: [
        if (showTip)
          Text(
            '请在预约时间前30分钟内到场扫码',
            style: TextStyle(
              color: ktextSubColor,
              fontSize: 24.sp,
            ),
          ),
        Spacer(),
        button,
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
                model.address,
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

class _FacilityButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final String text;
  final bool outline;

  const _FacilityButton({
    Key? key,
    this.color = kPrimaryColor,
    required this.onPressed,
    required this.text,
    this.outline = false,
    this.textColor = ktextPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: outline ? null : color,
      shape: StadiumBorder(),
      elevation: 0,
      height: 60.w,
      minWidth: 168.w,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 26.sp,
        ),
      ),
    );
  }
}
