// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/extensions/num_ext.dart';
import 'package:akuCommunity/extensions/page_router.dart';
import 'package:akuCommunity/extensions/widget_list_ext.dart';
import 'package:akuCommunity/pages/setting_page/about_page/about_page.dart';
import 'package:akuCommunity/pages/setting_page/account_manager_page.dart';
import 'package:akuCommunity/pages/setting_page/feedback_page/feedback_page.dart';
import 'package:akuCommunity/pages/setting_page/invite_page/invite_page.dart';
import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

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

  Widget _quitButton() {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.isLogin
        ? MaterialButton(
            elevation: 0,
            color: Colors.white,
            height: 96.w,
            child: '退出当前账号'.text.color(ktextPrimary).size(32.sp).bold.make(),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoActionSheet(
                    message: Text('退出当前账号'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          '确定',
                          style: TextStyle(
                            color: Colors.red.withOpacity(0.7),
                          ),
                        ),
                        onPressed: () {
                          userProvider.logout();
                          Get.offAll(SignInPage());
                        },
                      ),
                    ],
                    cancelButton: CupertinoDialogAction(
                      child: Text('取消'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  );
                },
              );
            },
          )
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '设置',
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ...[
            // _buildTile(
            //   title: '是否接受信息通知',
            //   suffix: CupertinoSwitch(
            //     value: false,
            //     onChanged: (state) {},
            //   ),
            // ),
            _buildTile(
              title: '关于小蜜蜂智慧社区',
              onTap: () => AboutPage().to(),
            ),
            //TODO 邀请注册
            // _buildTile(
            //   title: '邀请注册',
            //   onTap: () => InvitePage().to(),
            // ),
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
              onTap: FeedBackPage().to,
            ),
            _buildTile(
              title: '账号管理',
              onTap: AccountManagerPage().to,
            ),
          ].sepWidget(
              separate: Divider(
            indent: 32.w,
            endIndent: 32.w,
            color: Color(0xFFD8D8D8),
            thickness: 1.w,
            height: 1.w,
          )),
          53.hb,
          _quitButton(),
        ],
      ),
    );
  }
}
