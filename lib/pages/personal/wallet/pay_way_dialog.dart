import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/life_pay/pay_util.dart';
import 'package:aku_new_community/pages/personal/wallet/input_pay_password_dialog.dart';
import 'package:aku_new_community/pages/personal/wallet/set_pay_password_dialog.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/buttons/bee_check_radio.dart';
import 'package:aku_new_community/widget/buttons/bee_long_button.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';

class PayWayDialog extends StatefulWidget {
  final bool isBalance;
  final int amount;
  final bool insufficientBalance;

  const PayWayDialog(
      {Key? key,
      required this.isBalance,
      required this.amount,
      required this.insufficientBalance})
      : super(key: key);

  @override
  _PayWayDialogState createState() => _PayWayDialogState();
}

class _PayWayDialogState extends State<PayWayDialog> {
  List<int> _payType = [];

  @override
  void initState() {
    if (widget.isBalance) {
      _payType.add(1);
    } else {
      if (widget.insufficientBalance) {
        _payType.add(1);
      } else {
        _payType.add(0);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wallet = GestureDetector(
      onTap: () {
        if (widget.insufficientBalance) {
          return;
        }
        _payType.clear();
        _payType.add(0);
        setState(() {});
      },
      child: Opacity(
        opacity: widget.insufficientBalance?0.4:1,
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: [
              Assets.newIcon.walletBalance.image(width: 48.w, height: 48.w),
              8.wb,
              '钱包余额'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
              16.wb,
              Visibility(
                  visible: widget.insufficientBalance,
                  child:
                      '钱包余额不足'.text.size(24.sp).color(Colors.red).make()),
              Spacer(),
              BeeCheckRadio(
                groupValue: _payType,
                value: 0,
                size: 36.w,
                indent: Icon(
                  CupertinoIcons.checkmark_alt,
                  color: Colors.black,
                  size: 28.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    var alipay = GestureDetector(
      onTap: () {
        _payType.clear();
        _payType.add(1);
        setState(() {});
      },
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            Assets.newIcon.alipay.image(width: 48.w, height: 48.w),
            8.wb,
            '支付宝'.text.size(28.sp).color(Colors.black.withOpacity(0.85)).make(),
            Spacer(),
            BeeCheckRadio(
              groupValue: _payType,
              value: 1,
              size: 36.w,
              indent: Icon(
                CupertinoIcons.checkmark_alt,
                color: Colors.black,
                size: 28.w,
              ),
            ),
          ],
        ),
      ),
    );
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            '支付'
                .text
                .size(32.sp)
                .bold
                .isIntrinsic
                .color(Colors.black.withOpacity(0.85))
                .make(),
            48.hb,
            Column(
              children: [
                '¥'
                    .richText
                    .color(Colors.black.withOpacity(0.85))
                    .size(26.sp)
                    .withTextSpanChildren([
                  widget.amount
                      .toString()
                      .textSpan
                      .size(40.sp)
                      .color(Colors.black.withOpacity(0.85))
                      .make(),
                ]).make(),
                Offstage(
                  offstage: widget.isBalance,
                  child: '总共购买${widget.amount * 10}积分'
                      .text
                      .size(32.sp)
                      .color(Colors.black.withOpacity(0.45))
                      .make(),
                ),
                60.hb,
                Offstage(
                  offstage: widget.isBalance,
                  child: Column(
                    children: [
                      wallet,
                      40.hb,
                    ],
                  ),
                ),
                alipay,
                80.hb,
                BeeLongButton(
                    width: double.infinity,
                    onPressed: () async {
                      if (_payType.contains(0)) {
                        if (!UserTool
                            .userProvider.userInfoModel!.isBalancePayPwd) {
                          Get.dialog(SetPayPasswordDialog());
                        } else {
                          Get.back();
                          var psd = await Get.dialog(
                              InputPayPasswordDialog());
                          await NetUtil().post(
                              SAASAPI.balance.buyPointsByBalance,
                              params: {
                                'balance': widget.amount,
                                'balancePayPwd': psd
                              },
                              showMessage: true);
                        }
                        return;
                      }
                      if (_payType.contains(1)) {
                        var cancel = BotToast.showLoading();
                        await _alipayFuc();
                        cancel();
                        Get.back();
                        return;
                      }
                    },
                    text: '确认支付${widget.amount}元'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _alipayFuc() async {
    if (widget.isBalance) {
      var base = await NetUtil().post(SAASAPI.pay.createBalanceOrder, params: {
        'balance': widget.amount,
      });
      if (base.success) {
        var re = await PayUtil()
            .callAliPay(base.data, SAASAPI.pay.balanceOrderCheckAlipay);
      } else {
        BotToast.showText(text: base.msg);
      }
    } else {
      var base = await NetUtil().post(SAASAPI.pay.createPointsOrder, params: {
        'payAmount': widget.amount,
      });
      if (base.success) {
        var re = await PayUtil()
            .callAliPay(base.data, SAASAPI.pay.pointsOrderCheckAlipay);
      } else {
        BotToast.showText(text: base.msg);
      }
    }
  }
}
