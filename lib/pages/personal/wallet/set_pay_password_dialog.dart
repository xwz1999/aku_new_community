import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/pages/personal/wallet/set_pay_password_verify_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class SetPayPasswordDialog extends StatefulWidget {
  const SetPayPasswordDialog({Key? key, }) : super(key: key);

  @override
  _SetPayPasswordDialogState createState() => _SetPayPasswordDialogState();
}

class _SetPayPasswordDialogState extends State<SetPayPasswordDialog> {
  String? _currentCode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:EdgeInsets.only(bottom: 300.w),
        child: Material(
          borderRadius: BorderRadius.circular(24.w),
          child: Container(
            width: 630.w,
            height: 480.w,
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.w)),
            child: Column(
              children: [
                96.hb,
                '请先设置支付密码'
                    .text
                    .size(32.sp)
                    .color(Colors.black.withOpacity(0.85))
                    .bold
                    .make(),
                40.hb,
                '支付密码仅用于对钱包余额支付时确认'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.45))
                    .make(),
                PinFieldAutoFill(
                  autoFocus: true,
                  currentCode: _currentCode,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  codeLength: 6,
                  onCodeChanged: (code) async {
                    if ((code?.length ?? 0) >= 6) {
                      Get.back();
                      Get.dialog(SetPayVerifyPasswordDialog(firstCode:code!,));
                    }
                    _currentCode = code;
                  },
                  decoration: UnderlineDecoration(
                      colorBuilder: FixedColorListBuilder([
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.3),
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
