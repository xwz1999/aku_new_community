import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/ui/profile/new_house/examine_view.dart';
import 'package:aku_new_community/ui/profile/new_house/member_view.dart';
import 'package:aku_new_community/ui/profile/new_house/widgets/add_house_button.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/dialog/certification_dialog.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'add_house_page.dart';

class MyFamilyPage extends StatefulWidget {
  const MyFamilyPage({Key? key}) : super(key: key);

  @override
  _MyFamilyPageState createState() => _MyFamilyPageState();
}

class _MyFamilyPageState extends State<MyFamilyPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> _tabs = ['当前成员', '审核列表'];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tab = Container(
      width: double.infinity,
      height: 108.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40.w)),
      child: TabBar(
        controller: _tabController,
        indicatorColor: kPrimaryColor,
        indicatorPadding:
            EdgeInsets.only(left: 25.w, right: 25.w, bottom: 16.w),
        indicatorWeight: 4.w,
        labelStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28.sp),
        unselectedLabelStyle:
            TextStyle(color: Colors.black.withOpacity(0.45), fontSize: 28.sp),
        tabs: _tabs
            .map((e) => Tab(
                  text: e,
                ))
            .toList(),
      ),
    );
    return BeeScaffold(
      title: '我的家庭',
      extendBody: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topRight,
                  scale: 3,
                  image: AssetImage(
                    Assets.static.family.path,
                  )),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFC37D),
                    Color(0xFFE28F2D),
                  ]),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  60.w.heightBox,
                  Padding(
                    padding: EdgeInsets.only(left: 32.w),
                    child: '${UserTool.userProvider.defaultHouse?.addressName ?? ''} '
                            '${UserTool.userProvider.defaultHouse?.communityName ?? ''}'
                        .text
                        .color(Colors.white)
                        .size(32.sp)
                        .make(),
                  ),
                  55.w.heightBox,
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40.w))),
                    child: Column(
                      children: [
                        tab,
                        Expanded(
                            child: TabBarView(
                          controller: _tabController,
                          children: [
                            MemberView(),
                            ExamineView(),
                          ],
                        ))
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          _tabController.index == 0
              ? Positioned(
                  bottom: 32.w,
                  right: 32.w,
                  left: 32.w,
                  child: AddHouseButton(
                      text: '添加房屋',
                      onTap: () async {
                        if (UserTool.userProvider.userInfoModel?.name == null) {
                          await Get.dialog(CertificationDialog());
                        } else {
                          Get.to(() => AddHousePage());
                        }
                      }),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
