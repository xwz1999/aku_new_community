import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/personal/user_profile_page.dart';
import 'package:aku_new_community/pages/setting_page/settings_page.dart';
import 'package:aku_new_community/pages/sign/login/other_login_page.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/market/order/order_page.dart';
import 'package:aku_new_community/ui/profile/new_house/my_family_page.dart';
import 'package:aku_new_community/ui/profile/new_house/my_house_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_avatar_widget.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'address/address_list_page.dart';
import 'clock_in/clock_in_page.dart';
import 'clock_in/clock_success_dialog.dart';
import 'intergral/integral_center_page.dart';

class PersonalIndex extends StatefulWidget {
  final bool? isSign;

  PersonalIndex({Key? key, this.isSign}) : super(key: key);

  @override
  _PersonalIndexState createState() => _PersonalIndexState();
}

class _PersonalIndexState extends State<PersonalIndex>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Widget _orderButton({
    required String name,
    required String path,
    required int index,
  }) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(path, height: 64.w, width: 64.w),
          10.hb,
          Text(
            name,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 26.sp,
            ),
          ),
        ],
      ),
      onTap: () {
        Get.to(() => OrderPage(initIndex: index));
      },
    ).expand();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double _statusHeight = MediaQuery.of(context).padding.top;
    final userProvider = Provider.of<UserProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: EasyRefresh(
              header: MaterialHeader(),
              onRefresh: () async {
                await userProvider.updateUserInfo();
                await userProvider.updateMyHouseInfo();
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 512.w,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Assets.newIcon.imgBg,
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.only(top: 100.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.to(SettingsPage());
                              },
                              child: Container(
                                width: 72.w,
                                height: 40.w,
                                alignment: Alignment.center,
                                child: Image.asset(
                                    R.ASSETS_ICONS_ICON_MY_SETTING_PNG,
                                    width: 40.w,
                                    height: 40.w),
                              ),
                            ),
                            24.wb,
                          ],
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(5.w),
                          onPressed: () {
                            if (!userProvider.isLogin)
                              //暂时隐去一键登录页
                              Get.to(() => OtherLoginPage());
                            else
                              Get.to(() => UserProfilePage());
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 32.w),
                            child: Row(
                              children: [
                                Hero(
                                  tag: 'AVATAR',
                                  child: BeeAvatarWidget(
                                    imgs: UserTool
                                        .userProvider.userInfoModel?.imgList,
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 16.w),
                                    child: userProvider.isLogin
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userProvider.userInfoModel
                                                        ?.nickName ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 40.sp,
                                                  color: Colors.black
                                                      .withOpacity(0.85),
                                                ),
                                              ),
                                              4.hb,
                                              Text(
                                                '当一个新时代的有志青年',
                                                style: TextStyle(
                                                  fontSize: 24.sp,
                                                  color: Colors.black
                                                      .withOpacity(0.45),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            '登录/注册',
                                            style: TextStyle(
                                              fontSize: 32.sp,
                                              color: Color(0xffad8940),
                                            ),
                                          )),
                                Spacer(),
                                MaterialButton(
                                  onPressed: () async {
                                    var base = await NetUtil()
                                        .get(SAASAPI.profile.integral.sign);
                                    if (base.success) {
                                      await Get.dialog(ClockSuccessDialog(
                                          todayIntegral: 1,
                                          tomorrowIntegral: 2));
                                      await UserTool.userProvider
                                          .changeTodayClocked();
                                    } else {
                                      BotToast.showText(text: base.msg);
                                    }
                                  },
                                  elevation: 0,
                                  color: Colors.white,
                                  minWidth: 168.w,
                                  height: 64.w,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.w)),
                                  child: Row(
                                    children: [
                                      Assets.newIcon.imgQiandao
                                          .image(width: 48.w, height: 48.w),
                                      12.wb,
                                      '${UserTool.userProvider.userInfoModel!.isSign ? '已签到' : '签到'}'
                                          .text
                                          .size(22.sp)
                                          .black
                                          .make(),
                                    ],
                                  ),
                                ),
                                32.w.widthBox,
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 686.w,
                          height: 168.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: 24.w, top: 24.w, bottom: 24.w),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.w),
                                  topRight: Radius.circular(24.w))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              32.wb,
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Assets.newIcon.imgVip
                                          .image(width: 84.w, height: 32.w),
                                      24.wb,
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.w),
                                            gradient: LinearGradient(colors: [
                                              Color(0xFFFEE8C0),
                                              Color(0xFFFCCC8C),
                                            ])),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w, vertical: 8.w),
                                        child: Assets.newIcon.imgDengji
                                            .image(width: 40.w, height: 16.w),
                                      ),
                                    ],
                                  ),
                                  16.hb,
                                  '尊享6大会员权益'
                                      .text
                                      .size(24.sp)
                                      .color(Color(0xFFFCCC8C))
                                      .make(),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => Get.to(() => integralCenterPage()),
                                child: Container(
                                  width: 160.w,
                                  height: 58.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFE0A9),
                                      borderRadius:
                                          BorderRadius.circular(29.w)),
                                  child: '会员中心'.text.size(24.sp).black.make(),
                                ),
                              ),
                              32.wb,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 600.w),
                    child: Column(
                      children: [
                        Container(
                          width: 686.w,
                          height: 282.w,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(left: 32.w, right: 32.w),
                          padding: EdgeInsets.only(
                              top: 24.w, left: 32.w, right: 32.w),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _homeTitle('我的订单', () {
                                Get.to(() => OrderPage(initIndex: 0));
                              }, '查看全部'),
                              50.hb,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _orderButton(
                                    name: '待付款',
                                    path: Assets.newIcon.icDaifuk.path,
                                    index: 1,
                                  ),
                                  _orderButton(
                                    name: '待发货',
                                    path: Assets.newIcon.imgDaifah.path,
                                    index: 2,
                                  ),
                                  _orderButton(
                                    name: '待收货',
                                    path: Assets.newIcon.icDaishouh.path,
                                    index: 3,
                                  ),
                                  _orderButton(
                                    name: '已完成',
                                    path: Assets.newIcon.imgDaipingj.path,
                                    index: 4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   width: double.infinity,
                        //   height: 100.w,
                        //   clipBehavior: Clip.antiAlias,
                        //   decoration: BoxDecoration(
                        //       // color: Colors.white,
                        //       borderRadius: BorderRadius.circular(16.w)),
                        //   margin: EdgeInsets.symmetric(horizontal: 32.w),
                        //   child: Material(
                        //     color: Colors.white,
                        //     child: InkWell(
                        //       onTap: () {
                        //         Get.to(() => ClockInPage());
                        //       },
                        //       borderRadius: BorderRadius.circular(16.w),
                        //       child: Padding(
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: 32.w, vertical: 24.w),
                        //         child: Row(
                        //           children: [
                        //             '我的积分'.text.size(30.sp).black.bold.make(),
                        //             Spacer(),
                        //             // Assets.icons.intergral
                        //             //     .image(width: 32.w, height: 32.w),
                        //             // 16.w.widthBox,
                        //             // '123'.text.size(28.sp).black.make(),
                        //             // 16.w.widthBox,
                        //             Icon(
                        //               CupertinoIcons.right_chevron,
                        //               size: 24.w,
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(32.w),
                          padding: EdgeInsets.all(32.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  22.wb,
                                  '其他功能'
                                      .text
                                      .size(32.sp)
                                      .color(Color(0xFF2B2B2B))
                                      .bold
                                      .make(),
                                  Spacer(),
                                ],
                              ),
                              24.hb,
                              _function('我的积分', Assets.newIcon.icJifen.path,
                                  () => ClockInPage(), ''),
                              _function(
                                '我的房屋',
                                R.ASSETS_ICONS_ICON_MY_HOUSE_PNG,
                                () => MyHousePage(),
                                // () => HouseOwnersPage(
                                //       identify: 4,
                                //     ),
                                '${UserTool.userProvider.defaultHouse?.communityName ?? ''} '
                                    '${UserTool.userProvider.defaultHouse?.buildingName ?? ''}'
                                    '${UserTool.userProvider.defaultHouse?.unitName ?? ''}'
                                    '${UserTool.userProvider.defaultHouse?.estateName ?? ''}',
                              ),
                              _function(
                                  '我的家庭',
                                  R.ASSETS_ICONS_ICON_MY_HOUSE_PNG,
                                  () => MyFamilyPage(),
                                  ''),
                              // _function('我的车位', R.ASSETS_ICONS_ICON_MY_CARSEAT_PNG,
                              //     () => CarParkingPage(), ''),
                              // 36.hb,
                              // _function('我的车', R.ASSETS_ICONS_ICON_MY_CAR_PNG,
                              //     () => CarManagePage(), ''),
                              // 36.hb,
                              // _function(
                              //     '我的访客',
                              //     R.ASSETS_ICONS_ICON_MY_VISITOR_PNG,
                              //     () => CarManagePage(),
                              //     ''),
                              // 36.hb,
                              _function(
                                  '收货地址',
                                  R.ASSETS_ICONS_ICON_MY_LOCATION_PNG,
                                  () => AddressListPage(
                                        canBack: false,
                                      ),
                                  ''),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  _homeTitle(String title, VoidCallback onTap, String suffixTitle) {
    return Row(
      children: [
        title.text.size(32.sp).bold.make(),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              suffixTitle.text.size(24.sp).color(Color(0xFF999999)).make(),
              8.wb,
              Icon(
                CupertinoIcons.chevron_forward,
                size: 24.w,
                color: Color(0xFF999999),
              ),
            ],
          ),
        ),
        //24.wb,
      ],
    );
  }

  _function(
    String title,
    String path,
    dynamic page,
    String msg,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(page);
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
        child: Row(
          children: [
            Image.asset(
              path,
              width: 40.w,
              height: 40.w,
              fit: BoxFit.fitHeight,
            ),
            16.wb,
            Text(
              title,
              style: TextStyle(
                fontSize: 28.sp,
                color: Colors.black.withOpacity(0.85),
              ),
            ),
            Spacer(),
            Text(
              msg,
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.black.withOpacity(0.45),
              ),
            ),
            24.wb,
            Icon(
              CupertinoIcons.chevron_forward,
              size: 24.w,
              color: Color(0xFF999999),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
