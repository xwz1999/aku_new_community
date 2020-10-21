import 'dart:async';
import 'package:akuCommunity/pages/setting_page/agreement_page/agreement_page.dart';
import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:ani_route/ani_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/custom_action_sheet.dart';

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
      'title':'隐私政策',
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
              fontSize: Screenutil.size(34),
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: Screenutil.size(34),
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
                  fontSize: Screenutil.size(34),
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
            ARoute.push(context,PrivacyPage());
            break;
          default:
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: Screenutil.length(32)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Screenutil.length(28)),
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
                      size: Screenutil.size(36),
                      color: BaseStyle.color999999,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerQuit() {
    return InkWell(
      onTap: () {
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
      },
      child: Container(
        color: Colors.white,
        height: Screenutil.length(96),
        padding: EdgeInsets.only(
          top: Screenutil.length(26),
          bottom: Screenutil.length(25),
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
          SizedBox(height: Screenutil.length(24)),
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
          SizedBox(height: Screenutil.length(52)),
          _containerQuit(),
        ],
      ),
    );
  }
}
