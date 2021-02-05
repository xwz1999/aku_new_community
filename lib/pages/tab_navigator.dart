// Flutter imports:
import 'package:akuCommunity/ui/community/community_views/community_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'home/home_page.dart';
import 'personal/personal_page.dart';
import 'property/property_index.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({
    Key key,
  }) : super(key: key);
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  DateTime _lastPressed;

  //页面列表
  List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePage(),
      // MarketPage(),
      PropertyIndex(),
      // CommunityIndex(),
      CommunityPage(),
      PersonalIndex()
    ];
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
      _buildBottomBar('首页', R.ASSETS_ICONS_TABBAR_HOME_NO_PNG,
          R.ASSETS_ICONS_TABBAR_HOME_PNG),
      // _buildBottomBar(
      //     '商城', AssetsImage.TAB_MARKET_UNSELECT, AssetsImage.TAB_MARKET_SELECT),
      _buildBottomBar('物业', R.ASSETS_ICONS_TABBAR_HOUSE_NO_PNG,
          R.ASSETS_ICONS_TABBAR_HOUSE_PNG),
      _buildBottomBar('社区', R.ASSETS_ICONS_TABBAR_MESSAGE_NO_PNG,
          R.ASSETS_ICONS_TABBAR_MESSAGE_PNG),
      _buildBottomBar('我的', R.ASSETS_ICONS_TABBAR_USER_NO_PNG,
          R.ASSETS_ICONS_TABBAR_USER_PNG),
    ];
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒重新计算
            _lastPressed = DateTime.now();
            return false;
          }
          //否则关闭app
          return true;
        },
        child: PageView.builder(
          itemBuilder: (context, index) => _pages[index],
          itemCount: _pages.length,
          controller: _pageController,
          // physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNav,
        currentIndex: _currentIndex,
        selectedFontSize: 20.sp,
        unselectedFontSize: 16.sp,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
