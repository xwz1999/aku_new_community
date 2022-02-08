import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/ui/profile/new_house/certification/certification_success_page.dart';
import 'package:aku_new_community/ui/profile/new_house/widgets/add_house_button.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CertificationPage extends StatefulWidget {
  const CertificationPage({Key? key}) : super(key: key);

  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  Widget get tips {
    var reg = RegexUtil.matches(
        r'^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$',
        _codeController.text);
    if (!reg && _codeController.text.isNotEmpty) {
      return '身份证号输入有误，请重新输入'.text.size(28.sp).color(Colors.red).make();
    } else {
      return '证件信息绑定后将不能修改，请填写本人的实名信息'
          .text
          .size(28.sp)
          .color(Colors.black.withOpacity(0.25))
          .make();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '实名认证',
      body: SafeArea(
          child: ListView(
        children: [
          40.w.heightBox,
          Assets.images.certification.image(width: 300, height: 300.w),
          40.w.heightBox,
          '您所提供的身份信息仅用于本APP身份绑定\n未经您本人允许不会用于其他用途'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.25))
              .align(TextAlign.center)
              .make(),
          50.w.heightBox,
          Container(
            width: 686.w,
            // height: 210.w,
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: '姓名'.text.size(28.sp).color(Colors.black).make(),
                      width: 120.w,
                    ),
                    Expanded(
                        child: TextField(
                      controller: _nameController,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: '请输入真实姓名',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 28.sp,
                              color: Colors.black.withOpacity(0.25))),
                    )),
                  ],
                ),
                BeeDivider.horizontal(),
                Row(
                  children: [
                    SizedBox(
                      child: '身份证'.text.size(28.sp).color(Colors.black).make(),
                      width: 120.w,
                    ),
                    Expanded(
                        child: TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: '请输入身份证号码',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 28.sp,
                              color: Colors.black.withOpacity(0.25))),
                    )),
                  ],
                ),
              ],
            ),
          ),
          24.w.heightBox,
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: tips,
          ),
        ],
      )),
      bottomNavi: Padding(
        padding: EdgeInsets.all(32.w),
        child: AddHouseButton(
          text: '提交',
          onTap: () async {
            var cancel = BotToast.showLoading();
            var base =
                await NetUtil().post(SARSAPI.user.certification, params: {
              'name': _nameController.text,
              'idCard': _codeController.text,
            });
            if (base.success) {
              Get.off(() => CertificationSuccessPage());
              UserTool.userProvider.updateUserInfo();
              UserTool.userProvider.updateMyHouseInfo();
            } else {
              BotToast.showText(text: base.msg);
            }
            cancel();
          },
        ),
      ),
    );
  }
}
