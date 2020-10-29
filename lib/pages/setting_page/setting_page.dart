import 'dart:async';
import 'package:akuCommunity/pages/setting_page/agreement_page/agreement_page.dart';
import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:ani_route/ani_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/custom_action_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'agreement_page/privacy_page.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isNotice = false;

  List<Map<String, dynamic>> _listView = [
    {
      'title': '是否接受信息通知',
      'isSwitch': true,
    },
    {
      'title': '关于小蜜蜂智慧社区',
      'isSwitch': false,
    },
    {
      'title': '邀请注册',
      'isSwitch': false,
    },
    {'title': '清除缓存', 'isSwitch': false, 'fun': null},
    {
      'title': '意见反馈',
      'isSwitch': false,
    },
    {
      'title': '账号管理',
      'isSwitch': false,
    },
    {
      'title': '用户协议',
      'isSwitch': false,
    },
    {
      'title': '隐私政策',
      'isSwitch': false,
    }
  ];

  void _showDialog(String url) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            url,
            style: TextStyle(
              fontSize: 34.sp,
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 34.sp,
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '确认',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 34.sp,
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _selectAction(String title, subtitle) async {
    int index1 = await showPayActionSheets(
        context: context, title: title, subtitle: subtitle);
    print(index1);
  }

  /// 具体使用方式
  Future<int> showPayActionSheets(
      {@required BuildContext context, String title, String subtitle}) {
    return showCustomBottomSheet(
      context: context,
      title: title,
      children: [
        actionItem(
          context: context,
          index: 1,
          title: subtitle,
          isLastOne: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _inkWellListTile(String title, bool isSwitch) {
    return InkWell(
      onTap: () {
        switch (title) {
          case '关于小蜜蜂智慧社区':
            Navigator.pushNamed(context, PageName.about_page.toString());
            break;
          case '邀请注册':
            Navigator.pushNamed(context, PageName.invite_page.toString());
            break;
          case '意见反馈':
            Navigator.pushNamed(context, PageName.feedback_page.toString());
            break;
          case '清除缓存':
            _showDialog('是否清除缓存?');
            break;
          case '账号管理':
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
                        Navigator.popUntil(context, (route) {
                          return !Navigator.canPop(context);
                        });
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SignInPage(),
                            ));
                      },
                    ),
                  ],
                  cancelButton: CupertinoButton(
                    child: Text('取消'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
            break;
          case '用户协议':
            ARoute.push(context, AgreementPage());
            break;
          case '隐私政策':
            ARoute.push(context, PrivacyPage());
            break;
          default:
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 28.w),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: BaseStyle.fontSize28,
                  color: BaseStyle.color333333,
                ),
              ),
              isSwitch
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          isNotice = !isNotice;
                        });
                      },
                      child: CupertinoSwitch(
                        value: isNotice,
                        activeColor: Color(0xffffc40c), // 激活时原点颜色
                        onChanged: (bool val) {
                          setState(() {
                            isNotice = !isNotice;
                          });
                        },
                      ),
                    )
                  : Icon(
                      AntDesign.right,
                      size: 36.sp,
                      color: BaseStyle.color999999,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerQuit() {
    final userProvider = Provider.of<UserProvider>(context);
    return InkWell(
      onTap: () {
        userProvider.isSigned?
        showCupertinoModalPopup(
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
                    ARoute.pop(context);
                    // Navigator.popUntil(context, (route) {
                    //   return !Navigator.canPop(context);
                    // });
                    // Navigator.pushReplacement(
                    //     context,
                    //     CupertinoPageRoute(
                    //       builder: (context) => SignInPage(),
                    //     ));
                  },
                ),
              ],
              cancelButton: CupertinoButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
          },
        ):ARoute.push(context, SignInPage());
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
                  color: BaseStyle.color333333,
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              height: 89.w,
              width: 586.w,
              padding: EdgeInsets.only(
                  top: 25.w, bottom: 24.w),
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
                  color: BaseStyle.color333333,
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '设置',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: ListView(
        children: [
          Column(
            children: _listView
                .take(3)
                .toList()
                .map((item) => _inkWellListTile(
                      item['title'],
                      item['isSwitch'],
                    ))
                .toList(),
          ),
          SizedBox(height: 24.w),
          Column(
            children: _listView
                .take(8)
                .skip(3)
                .toList()
                .map((item) => _inkWellListTile(
                      item['title'],
                      item['isSwitch'],
                    ))
                .toList(),
          ),
          SizedBox(height: 52.w),
          _containerQuit(),
        ],
      ),
    );
  }
}
