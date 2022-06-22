import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/pages/setting_page/agreement_page/agreement_page.dart';
import 'package:aku_new_community/pages/setting_page/agreement_page/privacy_page.dart';
import 'package:aku_new_community/pages/sign/login/other_login_page.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/utils/developer_util.dart';
import 'package:aku_new_community/utils/websocket/web_socket_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';

import 'account_manager_page.dart';
import 'blacklist_page/blacklist_page.dart';
import 'feedback_page/feedback_page.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _buildTile({
    required String title,
    VoidCallback? onTap,
    Widget? suffix,
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
                          Get.offAll(() => OtherLoginPage());
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
          ...<Widget>[
            // _buildTile(
            //   title: '是否接受信息通知',
            //   suffix: CupertinoSwitch(
            //     value: false,
            //     onChanged: (state) {},
            //   ),
            // ),
            // _buildTile(
            //   title: '关于小蜜蜂智慧小区',
            //   onTap: () => Get.to(() => AboutPage()),
            // ),
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
            // _buildTile(
            //   title: '清除缓存',
            //   onTap: () {},
            // ),
            _buildTile(
              title: '意见反馈',
              onTap: () => Get.to(() => FeedBackPage()),
            ),
            _buildTile(
              title: '账号管理',
              onTap: () => Get.to(() => AccountManagerPage()),
            ),
            _buildTile(
              title: '用户协议',
              onTap: () => Get.to(() => AgreementPage()),
            ),
            _buildTile(
              title: '隐私政策',
              onTap: () => Get.to(() => PrivacyPage()),
            ),
            _buildTile(
              title: '社区黑名单',
              onTap: () => Get.to(() => blackListPage()),
            ),
          ].sepWidget(
              separate: Divider(
            indent: 32.w,
            endIndent: 32.w,
            thickness: 1.w,
            height: 1.w,
          )),
          53.hb,
          if (DeveloperUtil.dev) _closeFireAlert(),
          if (DeveloperUtil.dev) 53.hb,
          _quitButton(),
        ],
      ),
    );
  }

  Widget _closeFireAlert() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 64.w),
      child: Row(
        children: [
          '接收火灾报警通知'.text.size(28.sp).color(ktextPrimary).bold.make().expand(),
          CupertinoSwitch(
              value: UserTool.appProvider.fireAlert,
              onChanged: (value) {
                if (value) {
                  WebSocketUtil().startWebSocket();
                } else {
                  WebSocketUtil().closeWebSocket();
                }
                setState(() {});
              })
        ],
      ),
    );
  }
}
