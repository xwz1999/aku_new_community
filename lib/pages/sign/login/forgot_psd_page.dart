import 'package:aku_new_community/pages/sign/login/forgot_set_psd_page.dart';
import 'package:aku_new_community/pages/sign/widget/login_button_widget.dart';
import 'package:aku_new_community/pages/sign/widget/tel_text_field.dart';
import 'package:aku_new_community/provider/clock_timer_provider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../sign_func.dart';

class ForgotPsdPage extends StatefulWidget {
  const ForgotPsdPage({Key? key}) : super(key: key);

  @override
  _ForgotPsdPageState createState() => _ForgotPsdPageState();
}

class _ForgotPsdPageState extends State<ForgotPsdPage> {
  TextEditingController _telController = TextEditingController();

  @override
  void dispose() {
    _telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ClockTimerProvider clockTimer = Provider.of<ClockTimerProvider>(context);
    return BeeScaffold(
      title: '',
      bodyColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          24.w.heightBox,
          Row(
            children: [
              48.w.widthBox,
              '忘记密码'
                  .text
                  .size(36.sp)
                  .bold
                  .color(Colors.black.withOpacity(0.65))
                  .make(),
              Spacer(),
            ],
          ),
          16.w.heightBox,
          Row(
            children: [
              48.w.widthBox,
              '为了安全，我们会向你的手机发送验证码'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
              Spacer(),
            ],
          ),
          144.w.heightBox,
          TelTextField(
              controller: _telController,
              onChange: (content) {
                setState(() {});
              }),
          100.w.heightBox,
          LoginButtonWidget(
              onTap: _telController.text.isNotEmpty
                  ? () async {
                      if (!RegexUtil.isMobileSimple(_telController.text)) {
                        BotToast.showText(text: '请输入正确的手机号！');
                        return;
                      }
                      var base = await SignFunc.sendForgotMessageCode(
                          _telController.text,
                          UserTool.appProvider.pickedCityAndCommunity!
                              .communityModel!.id);
                      if (base.success) {
                        Get.to(() => ForgotSetPsdPage(
                              tel: _telController.text,
                            ));
                        clockTimer.startTimer();
                      } else {
                        BotToast.showText(text: base.msg);
                      }
                      setState(() {});
                    }
                  : null,
              text: '下一步'),
        ],
      ),
    );
  }
}
