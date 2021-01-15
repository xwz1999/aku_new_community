import 'package:akuCommunity/pages/activities_page/activities_page.dart';
import 'package:akuCommunity/pages/convenient_phone/convenient_phone_page.dart';
import 'package:akuCommunity/pages/fitup_manage/fitup_manage_page.dart';
import 'package:akuCommunity/pages/goods_deto_page/goods_deto_page.dart';
import 'package:akuCommunity/pages/goods_manage_page/goods_manage_page.dart';
import 'package:akuCommunity/pages/industry_committee/industry_committee_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_page.dart';
import 'package:akuCommunity/pages/market/market_detail_page/market_detail_page.dart';
import 'package:akuCommunity/pages/one_alarm/widget/alarm_page.dart';
import 'package:akuCommunity/pages/open_door_page/open_door_page.dart';
import 'package:akuCommunity/pages/opening_code_page/opening_code_page.dart';
import 'package:akuCommunity/pages/questionnaire_page/questionnaire_page.dart';
import 'package:akuCommunity/pages/things_page/things_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_access_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'widget/applications_bar.dart';

class TotalApplicationsPage extends StatefulWidget {
  TotalApplicationsPage({Key key}) : super(key: key);

  @override
  _TotalApplicationsPageState createState() => _TotalApplicationsPageState();
}

class _TotalApplicationsPageState extends State<TotalApplicationsPage> {
  int _currentIndex = 0;
  bool isEdit = false;
  List<String> _leftNav = ['为您推荐', '智慧管家'];

  Widget _myApp() {
    return Container(
      margin: EdgeInsets.only(
        top: 32.w,
        left: 32.w,
        right: 32.w,
      ),
      padding: EdgeInsets.only(bottom: 16.w),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xffd8d8d8), width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '我的应用',
            style: TextStyle(
              fontSize: 28.sp,
              color: Color(0xff333333),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isEdit = !isEdit;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: 90.w,
              padding: EdgeInsets.symmetric(vertical: 6.w),
              decoration: BoxDecoration(
                color: Color(0xffffd000),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Text(
                isEdit ? '完成' : '编辑',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28.sp,
                  color: Color(0xff333333),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _myAppGrid(List<Map<String, dynamic>> gridList, int count) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: gridList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: isEdit
                ? () {
                    setState(() {
                      switch (count) {
                        case 3:
                          if ((!AssetsImage.mineAppList.any((item) =>
                                  item['title'] == gridList[index]['title'])) &&
                              AssetsImage.mineAppList.length < 8) {
                            AssetsImage.mineAppList.add(gridList[index]);
                          }
                          break;
                        case 4:
                          gridList.removeAt(index);
                          break;
                        default:
                      }
                    });
                  }
                : () {
                    switch (gridList[index]['title']) {
                      case '居家生活':
                      case '数码家电':
                      case '休闲副食':
                      case '滋补保健':
                      case '彩妆香水':
                      case '服饰箱包':
                      case '母婴玩具':
                      case '饮料酒水':
                        MarketDetailPage(
                          bundle: Bundle()
                            ..putString('title', gridList[index]['title']),
                        ).to;
                        break;
                      case '一键开门':
                        OpenDoorPage().to();
                        break;
                      case '开门码':
                        OpeningCodePage().to();
                        break;
                      case '访客通行':
                      case '我的访客':
                        VisitorAccessPage().to();
                        break;
                      case '报事报修':
                        ThingsPage(
                          bundle: Bundle()
                            ..putMap('things', {
                              'title': '报事报修',
                            }),
                        ).to;
                        break;
                      case '生活缴费':
                      case '我的缴费':
                        LifePayPage().to();
                        break;
                      case '业委会':
                        IndustryCommitteePage().to();
                        break;
                      case '建议咨询':
                        ThingsPage(
                          bundle: Bundle()
                            ..putMap('things', {
                              'title': '建议咨询',
                              'treeList': <Map<String, dynamic>>[
                                {'name': '您的建议'},
                                {'name': '您的咨询'},
                              ]
                            }),
                        ).to();
                        break;
                      case '便民电话':
                        ConvenientPhonePage().to();
                        break;
                      case '活动投票':
                        ActivitiesPage(
                          bundle: Bundle()..putBool('isVote', true),
                        ).to;
                        break;
                      case '社区活动':
                        ActivitiesPage(
                          bundle: Bundle()..putBool('isVote', false),
                        ).to;
                        break;
                      case '物品出户':
                        GoodsDetoPage().to();
                        break;
                      case '投诉表扬':
                        ThingsPage(
                          bundle: Bundle()
                            ..putMap('things', {
                              'title': '投诉表扬',
                              'treeList': <Map<String, dynamic>>[
                                {'name': '您的表扬'},
                                {'name': '您的投诉'},
                              ]
                            }),
                        ).to;
                        break;
                      case '问卷调查':
                        QuestionnairePage().to();
                        break;
                      case '装修管理':
                        FitupManagePage().to();
                        break;
                      case '借还管理':
                        GoodsManagePage().to();
                        break;
                      case '一键报警':
                        AlarmPage().to();
                        break;
                      default:
                        break;
                    }
                  },
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        gridList[index]['imagePath'],
                        height: 75.w,
                        width: 75.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8.w),
                      Text(
                        gridList[index]['title'],
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Color(0xff4a4b51),
                        ),
                      )
                    ],
                  ),
                  isEdit
                      ? Positioned(
                          right: 0,
                          top: 24.w,
                          child: Image.asset(
                            count == 3
                                ? AssetsImage.APPADD
                                : AssetsImage.APPREDUCE,
                            height: 24.w,
                            width: 24.w,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          childAspectRatio: 1.0,
        ),
      ),
    );
  }

  Widget _leftInkWellNav(int index) {
    return InkWell(
      child: Stack(
        children: [
          Container(
            height: 88.w,
            alignment: Alignment.center,
            color: _currentIndex == index ? Colors.white : Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 24.w),
            child: Text(
              _leftNav[index],
              style: TextStyle(
                fontSize: 28.sp,
                color: Color(0xff333333),
              ),
            ),
          ),
          _currentIndex == index
              ? Positioned(
                  top: 24.w,
                  left: 1,
                  child: SizedBox(
                    width: 4.w,
                    height: 40.w,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xffffd000)),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: ApplicationsBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: _myApp(),
          ),
          Container(
            color: Colors.white,
            child: _myAppGrid(AssetsImage.mineAppList, 4),
          ),
          Container(
            margin: EdgeInsets.only(top: 32.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 172.w,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _leftNav.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _leftInkWellNav(index);
                      }),
                ),
                Container(
                  width: 578.w,
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Builder(builder: (_) {
                        switch (_currentIndex) {
                          case 0:
                            return _myAppGrid(AssetsImage.recommendGridList, 3);
                            break;
                          case 1:
                            return _myAppGrid(AssetsImage.propertyGridList, 3);
                            break;
                          case 2:
                            return _myAppGrid(AssetsImage.shopGridList, 3);
                            break;
                          default:
                            return SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
