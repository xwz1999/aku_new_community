import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/sign/login/other_login_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/community/community_views/community_page.dart';
import 'package:aku_new_community/ui/market/market_page.dart';
import 'package:aku_new_community/utils/websocket/web_socket_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'home/home_page.dart';
import 'personal/personal_page.dart';

class TabNavigator extends StatefulWidget {
  final int? index;

  const TabNavigator({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentIndex = 0;
  DateTime? _lastPressed;

  //页面列表
  List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(Get.context!);
    Future.delayed(Duration(milliseconds: 0), () async {
      await appProvider.getMyAddress(); //设置默认地址
    });
    _pages = [
      HomePage(),
      MarketPage(),
      // PropertyPage(),
      CommunityPage(),
      PersonalIndex()
    ];

    _tabController = TabController(
        length: _pages.length, vsync: this, initialIndex: widget.index ?? 0);
  }

  _buildBottomBar(
    String title,
    String unselected,
    String selected,
  ) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        unselected,
        height: 44.w,
        width: 44.w,
        color: Colors.black38,
      ),
      activeIcon: Image.asset(
        selected,
        height: 44.w,
        width: 44.w,
      ),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    //底部导航来
    List<BottomNavigationBarItem> _bottomNav = <BottomNavigationBarItem>[
      _buildBottomBar(
        '首页',
        Assets.home.icShouyeNor.path,
        Assets.home.icShouyeSel.path,
      ),
      _buildBottomBar(
        '商城',
        R.ASSETS_ICONS_TABBAR_MARKET_NO_PNG,
        R.ASSETS_ICONS_TABBAR_MARKET_PNG,
      ),
      // BottomNavigationBarItem(icon: Container()),
      _buildBottomBar(
        '社区',
        Assets.home.icShequNor.path,
        Assets.home.icShequSel.path,
      ),
      _buildBottomBar(
        '我的',
        Assets.home.icWodeNor.path,
        Assets.home.icWodeSel.path,
      ),
    ];
    return BeeScaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed!) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒重新计算
            _lastPressed = DateTime.now();
            BotToast.showText(text: '再点击一次返回退出');
            return false;
          }
          //否则关闭app
          WebSocketUtil().closeWebSocket();
          return true;
        },
        child: TabBarView(
          children: _pages,
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavi: StatefulBuilder(builder: (context, setFunc) {
        return BottomNavigationBar(
          items: _bottomNav,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          selectedFontSize: 20.sp,
          unselectedFontSize: 20.sp,
          onTap: (index) {
            if (UserTool.userProvider.isLogin == false) {
              //暂时隐去一键登录页
              Get.offAll(() => OtherLoginPage());
            } else {
              _tabController!.animateTo(index, curve: Curves.easeInOutCubic);
              setFunc(() => _currentIndex = index);
            }
          },
        );
      }),
    );
  }
}
