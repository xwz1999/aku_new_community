import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class GridButton extends StatelessWidget {
  final List<Map<String, dynamic>> gridList;
  final int count;
  GridButton({Key key, this.gridList, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: gridList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            switch (gridList[index]['title']) {
              case '一键开门':
                Navigator.pushNamed(
                    context, PageName.open_door_page.toString());
                break;
              case '开门码':
                Navigator.pushNamed(
                    context, PageName.opening_code_page.toString());
                break;
              case '访客通行':
              case '我的访客':
                Navigator.pushNamed(
                    context, PageName.visitor_access_page.toString());
                break;
              case '报事报修':
              case '我的报修':
                Navigator.pushNamed(context, PageName.things_page.toString(),
                    arguments: Bundle()
                      ..putMap('things', {
                        'title': '报事报修',
                      }));
                break;
              case '生活缴费':
              case '我的缴费':
                Navigator.pushNamed(context, PageName.life_pay_page.toString());
                break;
              case '业委会':
                Navigator.pushNamed(
                    context, PageName.industry_committee_page.toString());
                break;
              case '建议咨询':
                Navigator.pushNamed(context, PageName.things_page.toString(),
                    arguments: Bundle()
                      ..putMap('things', {
                        'title': '建议咨询',
                        'treeList': <Map<String, dynamic>>[
                          {'name': '您的建议'},
                          {'name': '您的咨询'},
                        ]
                      }));
                break;
              case '便民电话':
                Navigator.pushNamed(
                    context, PageName.convenient_phone_page.toString());
                break;
              case '活动投票':
                Navigator.pushNamed(
                    context, PageName.activities_page.toString(),
                    arguments: Bundle()..putBool('isVote', true));
                break;
              case '社区活动':
                Navigator.pushNamed(
                    context, PageName.activities_page.toString(),
                    arguments: Bundle()..putBool('isVote', false));
                break;
              case '物品出户':
                Navigator.pushNamed(
                    context, PageName.goods_deto_page.toString());
                break;
              case '投诉表扬':
                Navigator.pushNamed(context, PageName.things_page.toString(),
                    arguments: Bundle()
                      ..putMap('things', {
                        'title': '投诉表扬',
                        'treeList': <Map<String, dynamic>>[
                          {'name': '您的表扬'},
                          {'name': '您的投诉'},
                        ]
                      }));
                break;
              case '问卷调查':
                Navigator.pushNamed(
                    context, PageName.questionnaire_page.toString());
                break;
              case '装修管理':
                Navigator.pushNamed(
                    context, PageName.fitup_manage_page.toString());
                break;
              case '借还管理':
                Navigator.pushNamed(
                    context, PageName.goods_manage_page.toString());
                break;
              case '一键报警':
                Navigator.pushNamed(
                    context, PageName.one_alarm_page.toString());
                break;
              case '全部应用':
                Navigator.pushNamed(
                    context, PageName.total_applications_page.toString());
                break;
              case '我的房屋':
                Navigator.pushNamed(
                    context, PageName.mine_house_page.toString());
                break;
              case '我的车位':
                Navigator.pushNamed(context, PageName.mine_car_page.toString(),
                    arguments: Bundle()..putMap('carType', {'type': '车位'}));
                break;
              case '我的车':
                Navigator.pushNamed(context, PageName.mine_car_page.toString(),
                    arguments: Bundle()..putMap('carType', {'type': '车'}));
                break;
              case '我的地址':
                Navigator.pushNamed(context, PageName.address_page.toString());
                break;
              case '设置':
                Navigator.pushNamed(context, PageName.setting_page.toString());
                break;
              case '居家生活':
              case '数码家电':
              case '休闲副食':
              case '滋补保健':
              case '彩妆香水':
              case '服饰箱包':
              case '母婴玩具':
              case '饮料酒水':
                Navigator.pushNamed(
                    context, PageName.market_detail_page.toString(),
                    arguments: Bundle()
                      ..putString('title', gridList[index]['title']));
                break;
              case '待付款':
              case '待发货':
              case '待收货':
              case '待评价':
              case '售后':
                Navigator.pushNamed(context, PageName.order_page.toString(),
                    arguments: Bundle()
                      ..putString('title', gridList[index]['title']));
                break;
              default:
            }
            // switch (title) {
            //   case '物业':
            //     Navigator.pushNamed(context, PageName.common_page.toString(),
            //         arguments: Bundle()
            //           ..putMap('commentMap', {
            //             'title': girdList[index]['title'],
            //             'isActions': girdList[index]['isAction'],
            //             'isAlone': girdList[index]['isAlone'],
            //             'isPropose': girdList[index]['isPropose'],
            //           }));
            //     break;
            //   case '商城':
            //     Navigator.pushNamed(
            //         context, PageName.market_detail_page.toString(),
            //         arguments: Bundle()
            //           ..putString('title', girdList[index]['title']));
            //     break;
            //   case '订单':
            //     Navigator.pushNamed(
            //         context, PageName.order_page.toString(),
            //         arguments: Bundle()
            //           ..putString('title', girdList[index]['title']));
            //     break;
            //   default:
            // }
          },
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  gridList[index]['imagePath'],
                  height: Screenutil.length(53),
                  width: Screenutil.length(53),
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 5),
                Text(
                  gridList[index]['title'],
                  style: TextStyle(fontSize: Screenutil.size(24)),
                )
              ],
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count, mainAxisSpacing: 6.0, childAspectRatio: 1.0),
    );
  }
}
