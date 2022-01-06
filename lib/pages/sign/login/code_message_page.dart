import 'package:aku_new_community/pages/sign/sign_func.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:velocity_x/velocity_x.dart';

class CodeMessagePage extends StatefulWidget {
  final String tel;

  const CodeMessagePage({Key? key, required this.tel}) : super(key: key);

  @override
  _CodeMessagePageState createState() => _CodeMessagePageState();
}

class _CodeMessagePageState extends State<CodeMessagePage> {
  String? _errorMessage;
  TextEditingController _controller = TextEditingController();
  String? _currentCode;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0), () async {
      await SmsAutoFill().listenForCode();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '',
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              46.w.heightBox,
              '请输入验证码'
                  .text
                  .size(36.sp)
                  .color(Colors.black.withOpacity(0.65))
                  .bold
                  .make(),
              16.w.heightBox,
              _errorMessage != null
                  ? '${_errorMessage}'.text.color(Colors.red).size(28.sp).make()
                  : '验证码已发送至'
                      .richText
                      .withTextSpanChildren([
                        '${widget.tel}'
                            .textSpan
                            .size(28.sp)
                            .color(Color(0xFFCF1322).withOpacity(0.8))
                            .make(),
                      ])
                      .size(28.sp)
                      .color(Colors.black.withOpacity(0.45))
                      .make(),
              80.w.heightBox,
              PinFieldAutoFill(
                autoFocus: true,
                currentCode: _currentCode,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                codeLength: 6,
                onCodeChanged: (code) async {
                  if (code!.length >= 6) {
                    var re = await SignFunc.loginBySms(
                        widget.tel,
                        code,
                        UserTool.appProveider.pickedCityAndCommunity!
                            .communityModel!.id);
                    if (re.data['success']) {
                      UserTool.userProvider.setLogin(re.data['data'] as int);
                    } else {
                      _errorMessage = re.data['msg'];
                      BotToast.showText(text: re.data['msg']);
                      _controller.clear();
                    }
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
              ),
              24.w.heightBox,
              Row(
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () async {
                        var base = await SignFunc.sendMessageCode(
                            widget.tel,
                            UserTool.appProveider.pickedCityAndCommunity!
                                .communityModel!.id);
                        if (base.success) {
                          _errorMessage = null;
                          UserTool.appProveider.startTimer();
                        } else {
                          BotToast.showText(text: base.msg);
                        }
                      },
                      child: (UserTool.appProveider.second >= 60
                              ? '重新发送验证码'
                              : '${UserTool.appProveider.second}秒后可重新发送')
                          .text
                          .size(28.sp)
                          .color(Color(0xFF5096F1))
                          .make()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
