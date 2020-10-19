import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';

import 'home/home_page.dart';
import 'market/market_page.dart';
import 'property/property_index.dart';
import 'community/community_index.dart';
import 'personal/personal_page.dart';

//页面列表
List<Widget> _pages = <Widget>[
  HomePage(),
  MarketPage(),
  PropertyIndex(),
  CommunityIndex(),
  PersonalIndex()
];

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  DateTime _lastPressed;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    double iconSize = ScreenUtil().setWidth(44);
    //底部导航来
    List<BottomNavigationBarItem> _bottomNav = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Image.asset(
          AssetsImage.TAB_HOME_UNSELECT,
          height: iconSize,
          width: iconSize,
        ),
        activeIcon: Image.asset(
          AssetsImage.TAB_HOME_SELECT,
          height: iconSize,
          width: iconSize,
        ),
        title: Text(
          '首页',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            color: _currentIndex == 0 ? Color(0xff000000) : Color(0xffcccccc),
            fontWeight:
                _currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          AssetsImage.TAB_MARKET_UNSELECT,
          height: iconSize,
          width: iconSize,
        ),
        activeIcon: Image.asset(
          AssetsImage.TAB_MARKET_SELECT,
          height: iconSize,
          width: iconSize,
        ),
        title: Text(
          '商城',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            color: _currentIndex == 1 ? Color(0xff000000) : Color(0xffcccccc),
            fontWeight:
                _currentIndex == 1 ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          AssetsImage.TAB_HOUSE_UNSELECT,
          height: iconSize,
          width: iconSize,
        ),
        activeIcon: Image.asset(
          AssetsImage.TAB_HOUSE_SELECT,
          height: iconSize,
          width: iconSize,
        ),
        title: Text(
          '物业',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            color: _currentIndex == 2 ? Color(0xff000000) : Color(0xffcccccc),
            fontWeight:
                _currentIndex == 2 ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          AssetsImage.TAB_MESSAGE_UNSELECT,
          height: iconSize,
          width: iconSize,
        ),
        activeIcon: Image.asset(
          AssetsImage.TAB_MESSAGE_SELECT,
          height: iconSize,
          width: iconSize,
        ),
        title: Text(
          '社区',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            color: _currentIndex == 3 ? Color(0xff000000) : Color(0xffcccccc),
            fontWeight:
                _currentIndex == 3 ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          AssetsImage.TAB_USER_UNSELECT,
          height: iconSize,
          width: iconSize,
        ),
        activeIcon: Image.asset(
          AssetsImage.TAB_USER_SELECT,
          height: iconSize,
          width: iconSize,
        ),
        title: Text(
          '我的',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            color: _currentIndex == 4 ? Color(0xff000000) : Color(0xffcccccc),
            fontWeight:
                _currentIndex == 4 ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      )
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
          physics: NeverScrollableScrollPhysics(),
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
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
