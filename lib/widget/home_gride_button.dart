import 'package:akuCommunity/pages/convenient_phone/convenient_phone_page.dart';
import 'package:akuCommunity/pages/industry_committee/industry_committee_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_page.dart';
import 'package:akuCommunity/pages/open_door_page/open_door_page.dart';
import 'package:akuCommunity/pages/things_page/fixed_submit_page.dart';
import 'package:akuCommunity/pages/things_page/things_page.dart';
import 'package:akuCommunity/pages/total_application_page/total_applications_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_access_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:get/get.dart';

class HomeGridButton extends StatefulWidget {
  final int crossCount;
  HomeGridButton({Key key, this.crossCount}) : super(key: key);

  @override
  _HomeGridButtonState createState() => _HomeGridButtonState();
}

class GridButton {
  String title;
  String path;
  VoidCallback onTap;
  GridButton(this.title, this.path, this.onTap);
}

class _HomeGridButtonState extends State<HomeGridButton> {
  List<GridButton> _gridList = [
    GridButton('一键开门', R.ASSETS_ICONS_TOOL_YJKM_PNG, () {
      Get.to(OpenDoorPage());
    }),
    GridButton('访客通行', R.ASSETS_ICONS_TOOL_FKYQ_PNG, () {
      Get.to(VisitorAccessPage());
    }),
    GridButton('报事报修', R.ASSETS_ICONS_TOOL_BSBX_PNG, () {
      Get.to(FixedSubmitPage());
    }),
    GridButton('生活缴费', R.ASSETS_ICONS_TOOL_SHJF_PNG, () {
      Get.to(LifePayPage());
    }),
    GridButton('业委会', R.ASSETS_ICONS_TOOL_YWH_PNG, () {
      Get.to(IndustryCommitteePage());
    }),
    GridButton('建议咨询', R.ASSETS_ICONS_TOOL_JYTS_PNG, () {
      Get.to(ThingsPage());
    }),
    GridButton('便民电话', R.ASSETS_ICONS_TOOL_BMDH_PNG, () {
      Get.to(ConvenientPhonePage());
    }),
    GridButton('全部应用', R.ASSETS_ICONS_TOOL_QBYY_PNG, () {
      Get.to(TotalApplicationsPage());
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
