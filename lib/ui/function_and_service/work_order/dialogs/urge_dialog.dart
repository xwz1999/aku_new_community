import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class UrgeDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const UrgeDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        children: [
          120.hb,
          '确认发送提醒？'.text.size(36.sp).black.bold.isIntrinsic.make(),
          40.hb,
          '确认后，会对服务人员发送尽快完成任务的通知'.text.size(28.sp).isIntrinsic.make(),
          150.hb,
          BeeLongButton(onPressed: onConfirm, text: '确认提醒')
        ],
      ),
    );
  }
}
