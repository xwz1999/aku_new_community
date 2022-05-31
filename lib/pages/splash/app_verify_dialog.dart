import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/pages/setting_page/agreement_page/agreement_page.dart';
import 'package:aku_new_community/pages/setting_page/agreement_page/privacy_page.dart';
import 'package:aku_new_community/widget/bee_divider.dart';

class AppVerifyDialog extends StatelessWidget {
  const AppVerifyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 600.w,
        height: 700.w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.w),
        ),
        child: Material(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0,
                      0.3,
                    ],
                    colors: [
                      Color(0x33FBE541),
                      Colors.white,
                    ])),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    children: [
                      52.hb,
                      Text(
                        '欢迎使用小蜜蜂智慧生活',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.85),
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      45.hb,
                      Text(
                        '''
在您使用小蜜蜂智慧生活前，请认真阅读并同意小蜜蜂智慧生活使用条款和隐私政策，授权位置、设备信息、储存信息等权限，包括：
【地理位置权限】：根据您所处的地理位置提供个性化的内容信息；
【相册访问权限】：在报事报修、社区等功能中需要访问相册上传图片信息；
【其他权限】：使用过程中可能需要调用相机、麦克风、系统通知、及安装的应用列表等权限。
                      ''',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.85),
                            fontSize: 24.sp),
                      ),
                      30.hb,
                      RichText(
                        text: TextSpan(
                            text: '更多详细信息，请您阅读',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.85),
                                fontSize: 24.sp),
                            children: [
                              TextSpan(
                                text: '《用户协议》',
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 24.sp),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => AgreementPage());
                                  },
                              ),
                              TextSpan(
                                text: '、',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.85),
                                    fontSize: 24.sp),
                              ),
                              TextSpan(
                                text: '《小蜜蜂智慧生活隐私保护政策》',
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 24.sp),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => PrivacyPage());
                                  },
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                BeeDivider.horizontal(),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 100.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 30.w),
                          onPressed: () {
                            Get.back(result: false);
                          },
                          child: Text('退出',
                            style: TextStyle(

                                fontSize: 24.sp
                            ),),
                        ),
                      ),
                      Container(
                        width: 2.w,
                        height: double.infinity,
                        color: Color(0xFFF0F0F0),
                      ),
                      Expanded(
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 20.w),
                          onPressed: () {
                            Get.back(result: true);
                          },
                          child: Text('确认',style: TextStyle(
                              fontSize: 24.sp
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
