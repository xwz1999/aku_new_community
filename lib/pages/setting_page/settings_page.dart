import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/extensions/num_ext.dart';
import 'package:akuCommunity/pages/setting_page/about_page/about_page.dart';
import 'package:akuCommunity/pages/setting_page/feedback_page/feedback_page.dart';
import 'package:akuCommunity/pages/setting_page/invite_page/invite_page.dart';
import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/extensions/widget_list_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _buildTile({
    String title,
    VoidCallback onTap,
    Widget suffix,
  }) {
    return MaterialButton(
      color: Colors.white,
      disabledColor: Colors.white,
      height: 96.h,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: onTap,
      child: Row(
        children: [
          96.hb,
          32.wb,
          title.text.size(28.sp).color(Colors.black).make(),
          Spacer(),
          suffix ??
              Icon(
                CupertinoIcons.chevron_forward,
                size: 32.w,
                color: Color(0xFF999999),
              ),
          32.wb,
        ],
      ),
    );
  }

  Widget _containerQuit() {
    final userProvider = Provider.of<UserProvider>(context);
    return InkWell(
      onTap: () {
        userProvider.isSigned
            ? showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoActionSheet(
                    message: Text('退出当前账号'),
                    actions: [
                      CupertinoButton(
                        child: Text(
                          '确定',
                          style: TextStyle(
                            color: Colors.red.withOpacity(0.7),
                          ),
                        ),
                        onPressed: () {
                          userProvider.setisSigned(false);
                          Get.back();
                        },
                      ),
                    ],
                    cancelButton: CupertinoButton(
                      child: Text('取消'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  );
                },
              )
            : Get.to(SignInPage());
      },
      child: userProvider.isSigned
          ? Container(
              color: Colors.white,
              height: 96.w,
              padding: EdgeInsets.only(
                top: 26.w,
                bottom: 25.w,
              ),
              alignment: Alignment.center,
              child: Text(
                '退出当前帐号',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: BaseStyle.fontSize32,
                  color: ktextPrimary,
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              height: 89.w,
              width: 586.w,
              padding: EdgeInsets.only(top: 25.w, bottom: 24.w),
              margin: EdgeInsets.symmetric(horizontal: 82.w),
              decoration: BoxDecoration(
                color: Color(0xffffc40c),
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              child: Text(
                '登录',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: BaseStyle.fontSize28,
                  color: ktextPrimary,
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '设置',
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ...[
            _buildTile(
              title: '是否接受信息通知',
              suffix: CupertinoSwitch(
                value: false,
                onChanged: (state) {},
              ),
            ),
            _buildTile(
              title: '关于小蜜蜂智慧社区',
              onTap: () => Get.to(AboutPage()),
            ),
            _buildTile(
              title: '邀请注册',
              onTap: () => Get.to(InvitePage()),
            ),
          ].sepWidget(
              separate: Divider(
            indent: 32.w,
            endIndent: 32.w,
            color: Color(0xFFD8D8D8),
            thickness: 1.w,
            height: 1.w,
          )),
          26.hb,
          ...[
            _buildTile(
              title: '清除缓存',
              onTap: () {},
            ),
            _buildTile(
              title: '意见反馈',
              onTap: () => Get.to(FeedBackPage()),
            ),
            _buildTile(
              title: '账号管理',
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      message: Text('退出注销当前账号'),
                      actions: [
                        CupertinoButton(
                          child: Text(
                            '确定',
                            style: TextStyle(
                              color: Colors.red.withOpacity(0.7),
                            ),
                          ),
                          onPressed: () {
                            Get.offAll(SignInPage());
                          },
                        ),
                      ],
                      cancelButton: CupertinoButton(
                        child: Text('取消'),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ].sepWidget(
              separate: Divider(
            indent: 32.w,
            endIndent: 32.w,
            color: Color(0xFFD8D8D8),
            thickness: 1.w,
            height: 1.w,
          )),
          50.hb,
          _containerQuit(),
        ],
      ),
    );
  }
}
