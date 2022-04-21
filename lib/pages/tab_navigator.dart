import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/sign/login/other_login_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/community/community_views/community_page.dart';
import 'package:aku_new_community/ui/market/market_page.dart';
import 'package:aku_new_community/utils/websocket/web_socket_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/dialog/certification_dialog.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'home/home_page.dart';
import 'opening_code_page/opening_code_page.dart';
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
      OpeningCodePage(),
      CommunityPage(),
      PersonalIndex()
    ];

    _tabController = TabController(
        length: _pages.length, vsync: this, initialIndex: widget.index ?? 0);
  }

  Widget _buildBottomBar(
    String title,
    String unselected,
    String selected,
    int index,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (UserTool.userProvider.isLogin == false) {
            //暂时隐去一键登录页
            Get.offAll(() => OtherLoginPage());
          } else {
            _tabController!.animateTo(index, curve: Curves.easeInOutCubic);
            _currentIndex = index;
            setState(() {});
          }
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 48.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _currentIndex != index
                      ? Image.asset(
                          unselected,
                          height: 44.w,
                          width: 44.w,
                          color: Colors.black38,
                        )
                      : Image.asset(
                          selected,
                          height: 44.w,
                          width: 44.w,
                        ),
                  Text(
                    title,
                    style: TextStyle(
                        color: _currentIndex != index
                            ? Color(0xFFA6ABB1)
                            : Color(0xFF333333),
                        fontWeight: _currentIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 22.sp),
                  )
                ],
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //底部导航来
    List<Widget> _bottomNav = <Widget>[
      _buildBottomBar(
        '首页',
        Assets.home.icShouyeNor.path,
        Assets.home.icShouyeSel.path,
        0,
      ),
      _buildBottomBar(
        '商城',
        Assets.home.icShangcNor.path,
        Assets.home.icShangcSel.path,
        1,
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            if (UserTool.userProvider.isLogin == false) {
              //暂时隐去一键登录页
              Get.offAll(() => OtherLoginPage());
            } else {}
              _tabController!.animateTo(2, curve: Curves.easeInOutCubic);
              _currentIndex = 2;
              setState(() {});

          },
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 108.w,
                height: 108.w,
                margin: EdgeInsets.only(top: 26.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(54.w),
                  color: Color(0xFFFDE019),
                ),
                child: Assets.home.icKaimen.image(width: 80.w, height: 80.w),
              ),
            ),
          ),
        ),
      ),
      _buildBottomBar(
        '社区',
        Assets.home.icShequNor.path,
        Assets.home.icShequSel.path,
        3,
      ),
      _buildBottomBar(
        '我的',
        Assets.home.icWodeNor.path,
        Assets.home.icWodeSel.path,
        4,
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
      bottomNavi: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 750.w, maxHeight: 146.w),
        child: Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Assets.home.imgTabdi, fit: BoxFit.fitWidth),
              color: Colors.transparent),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _bottomNav.cast<Widget>().toList(),
          ),
        ),
      ),
    );
  }
}
