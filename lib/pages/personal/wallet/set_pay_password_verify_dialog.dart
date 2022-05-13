import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/pages/personal/wallet/input_pay_password_dialog.dart';
import 'package:aku_new_community/pages/sign/login/psd_verify.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';

class SetPayVerifyPasswordDialog extends StatefulWidget {
  final String firstCode;

  const SetPayVerifyPasswordDialog({Key? key, required this.firstCode})
      : super(key: key);

  @override
  _SetPayVerifyPasswordDialogState createState() =>
      _SetPayVerifyPasswordDialogState();
}

class _SetPayVerifyPasswordDialogState
    extends State<SetPayVerifyPasswordDialog> {
  String _currentCode = '';

  bool get checkVerify => widget.firstCode == _currentCode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 300.w),
        child: Material(
          borderRadius: BorderRadius.circular(24.w),
          child: Container(
            width: 630.w,
            height: 480.w,
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(24.w)),
            child: Column(
              children: [
                96.hb,
                '请再次输入支付密码'
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
                    _currentCode = code ?? '';
                    if ((code?.length ?? 0) >= 6) {
                      print(checkVerify);
                      if (!checkVerify) {
                        return;
                      }
                      var base = await NetUtil()
                          .post(SAASAPI.balance.setBalancePayPsd, params: {
                        'pwd': widget.firstCode,
                        'rePwd': _currentCode,
                      });
                      if (base.success) {
                        Get.back();
                        UserTool.userProvider.updateUserInfo();
                      } else {
                        BotToast.showText(text: base.msg);
                        Get.back();
                      }
                    }
                    setState(() {});
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
                ),
                24.hb,
                Offstage(
                  offstage: (_currentCode.isEmptyOrNull) || (checkVerify),
                  child: Row(
                    children: [
                      '密码输入不一致'
                          .text
                          .size(24.sp)
                          .isIntrinsic
                          .color(Colors.red)
                          .make(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
