import 'package:akuCommunity/pages/activities_page/activities_page.dart';
import 'package:akuCommunity/pages/address_page/address_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_page.dart';
import 'package:akuCommunity/pages/mine_car_page/mine_car_page.dart';
import 'package:akuCommunity/pages/mine_house_page/mine_house_page.dart';
import 'package:akuCommunity/pages/setting_page/settings_page.dart';
import 'package:akuCommunity/pages/things_page/fixed_submit_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_access_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_pass_page.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/home_gride_button.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalGridButton extends StatefulWidget {
  final int crossCount;
  PersonalGridButton({Key key, this.crossCount}) : super(key: key);

  @override
  _PersonalGridButtonState createState() => _PersonalGridButtonState();
}

class _PersonalGridButtonState extends State<PersonalGridButton> {
  List<GridButton> _gridList = [
    GridButton('我的房屋', R.ASSETS_ICONS_USER_ICON_WDFW_PNG, () {
      Get.to(MineHousePage());
    }),
    GridButton('我的车位', R.ASSETS_ICONS_USER_ICON_WDCW_PNG, () {
      Get.to(MineCarPage(
        bundle: Bundle()..putMap('carType', {'type': '车位'}),
      ));
    }),
    GridButton('我的车', R.ASSETS_ICONS_USER_ICON_WDC_PNG, () {
      Get.to(MineCarPage(
        bundle: Bundle()..putMap('carType', {'type': '车'}),
      ));
    }),
    GridButton('社区活动', R.ASSETS_ICONS_USER_ICON_WDSQHD_PNG, () {
      Get.to(ActivitiesPage(
        bundle: Bundle()..putBool('isVote', false),
      ));
    }),
    GridButton('我的缴费', R.ASSETS_ICONS_USER_ICON_WDJF_PNG, () {
      Get.to(LifePayPage());
    }),
    GridButton('我的保修', R.ASSETS_ICONS_USER_ICON_WDBX_PNG, () {
      Get.to(FixedSubmitPage());
    }),
    GridButton('我的地址', R.ASSETS_ICONS_USER_ICON_WDDZ_PNG, () {
      Get.to(AddressPage());
    }),
    GridButton('我的管家', R.ASSETS_ICONS_USER_ICON_WDGJ_PNG, () {}),
    GridButton('我的访客', R.ASSETS_ICONS_USER_ICON_WDFK_PNG, () {
      Get.to(VisitorAccessPage());
    }),
    GridButton('设置', R.ASSETS_ICONS_USER_ICON_SZ_PNG, () {
      Get.to(SettingsPage());
    }),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _gridList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: _gridList[index].onTap,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  _gridList[index].path,
                  height: 53.w,
                  width: 53.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 5),
                Text(
                  _gridList[index].title,
                  style: TextStyle(fontSize: 24.sp),
                )
              ],
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossCount,
          mainAxisSpacing: 6.0,
          childAspectRatio: 1.0),
    );
  }
}
