import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/pages/sign/login/other_login_page.dart';
import 'package:aku_new_community/pages/sign/login/select_community_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '',
      bgColor: Colors.white,
      bodyColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            44.w.heightBox,
            '登录解锁更多功能'.text.size(36.sp).color(ktextPrimary).bold.make(),
            144.w.heightBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommunityWidget(),
                80.w.heightBox,
                '${'1547***93018'}'
                    .text
                    .size(36.sp)
                    .color(ktextPrimary)
                    .bold
                    .make(),
                40.w.heightBox,
                MaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  height: 100.w,
                  minWidth: 686.w,
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.w)),
                  child: '本机号码一键登录'.text.size(32.sp).black.bold.make(),
                ),
                24.w.heightBox,
                InkWell(
                  onTap: () {
                    Get.to(() => OtherLoginPage());
                  },
                  child: Text(
                    '其他登录方式',
                    style: TextStyle(
                      color: Color(0xFF5096F1),
                      fontSize: 28.sp,
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            BottomTip(),
          ],
        ),
      ),
    );
  }
}

class BottomTip extends StatelessWidget {
  const BottomTip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 100.w),
      child: RichText(
          text: TextSpan(
              style: TextStyle(
                fontSize: 24.sp,
                color: ktextSubColor,
              ),
              text: '注册/登记即代表同意',
              children: [
            WidgetSpan(
                child: InkWell(
              onTap: () {
                //TODO:跳转隐私政策
              },
              child: '《小蜜蜂隐私政策及用户协议》'
                  .text
                  .size(24.sp)
                  .color(Color(0xFF5096F1))
                  .make(),
            )),
          ])),
    );
  }
}

class CommunityWidget extends StatelessWidget {
  final MainAxisAlignment? align;

  const CommunityWidget({
    Key? key,
    this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProveider = Provider.of<AppProvider>(context, listen: true);
    var hasSelect = appProveider.pickedCityAndCommunity != null &&
        appProveider.pickedCityAndCommunity!.communityModel != null;
    return GestureDetector(
      onTap: () async {
        await Get.to(() => SelectCommunity());
      },
      child: Row(
        mainAxisAlignment: align ?? MainAxisAlignment.center,
        children: [
          (hasSelect
                  ? '${appProveider.pickedCityAndCommunity!.cityModel.district.name} ${appProveider.pickedCityAndCommunity!.communityModel!.name}'
                  : '')
              .text
              .color(Colors.black)
              .make(),
          '${hasSelect ? '  切换' : '请先选择小区'}'
              .text
              .size(32.sp)
              .color(Color(0xFF5096F1))
              .make(),
        ],
      ),
    );
  }
}
