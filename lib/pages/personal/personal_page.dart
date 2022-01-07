import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/personal/clock_in/clock_in_page.dart';
import 'package:aku_new_community/pages/personal/user_profile_page.dart';
import 'package:aku_new_community/pages/setting_page/settings_page.dart';
import 'package:aku_new_community/pages/sign/login/login_page.dart';
import 'package:aku_new_community/painters/user_bottom_bar_painter.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/market/order/order_page.dart';
import 'package:aku_new_community/ui/profile/car/car_manage_page.dart';
import 'package:aku_new_community/ui/profile/car_parking/car_parking_page.dart';
import 'package:aku_new_community/ui/profile/house/house_owners_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'address/address_list_page.dart';
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
  SliverAppBar _sliverAppBar(double height) {
    final userProvider = Provider.of<UserProvider>(context);
    return SliverAppBar(
      pinned: false,
      toolbarHeight: 0,
      elevation: 0,
      floating: false,
      expandedHeight: 450.w - height,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage(R.ASSETS_ICONS_ICON_MY_SETTING_PNG),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: Column(
                  children: [
                    Spacer(),
                    MaterialButton(
                      padding: EdgeInsets.all(5.w),
                      onPressed: () {
                        if (!userProvider.isLogin)
                          Get.to(() => LoginPage());
                        else
                          Get.to(() => UserProfilePage());
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 32.w),
                        child: Row(
                          children: [
                            Hero(
                              tag: 'AVATAR1',
                              child: ClipOval(
                                  // child: FadeInImage.assetNetwork(
                                  //   placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                                  //   image: API.image(userProvider
                                  //           .userInfoModel!.imgUrls.isNotEmpty
                                  //       ? userProvider
                                  //           .userInfoModel!.imgUrls.first.url
                                  //       : ''),
                                  //   height: 106.w,
                                  //   width: 106.w,
                                  //   fit: BoxFit.cover,
                                  //   imageErrorBuilder:
                                  //       (context, error, stackTrace) {
                                  //     return Image.asset(
                                  //       R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                                  //       height: 106.w,
                                  //       width: 106.w,
                                  //     );
                                  //   },
                                  // ),
                                  ),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 16.w),
                                child: userProvider.isLogin
                                    ? Text(
                                        userProvider.userInfoModel?.nickName ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 32.sp,
                                          color: Color(0xffad8940),
                                        ),
                                      )
                                    : Text(
                                        '登录/注册',
                                        style: TextStyle(
                                          fontSize: 32.sp,
                                          color: Color(0xffad8940),
                                        ),
                                      )),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 41.w,
                            width: double.infinity,
                            child: CustomPaint(
                              painter: UserBottomBarPainter(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 38.w,
                            left: 36.w,
                            right: 36.w,
                            bottom: 18.w,
                          ),
                          child: Image.asset(
                            R.ASSETS_IMAGES_MEMBER_BG_PNG,
                            width: 678.w,
                            height: 129.w,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Container _containerBar(String title) {
  //   return Container(
  //     color: title == '我的物业' ? Colors.white : BaseStyle.colorf9f9f9,
  //     padding: EdgeInsets.all(title == '我的物业' ? 0 : 32.w),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             fontSize: BaseStyle.fontSize34,
  //             color: ktextPrimary,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

    return Scaffold(
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
                height: 441.w,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(R.ASSETS_IMAGES_MY_BG_PNG),
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
                          Get.to(() => LoginPage());
                        else
                          Get.to(() => UserProfilePage());
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 32.w),
                        child: Row(
                          children: [
                            Hero(
                              tag: 'AVATAR',
                              child: ClipOval(
                                  // child: FadeInImage.assetNetwork(
                                  //   placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                                  //   image: API.image((userProvider
                                  //                   .userInfoModel?.imgUrls ??
                                  //               [])
                                  //           .isNotEmpty
                                  //       ? (userProvider.userInfoModel?.imgUrls ??
                                  //               [])
                                  //           .first
                                  //           .url
                                  //       : ''),
                                  //   height: 106.w,
                                  //   width: 106.w,
                                  //   fit: BoxFit.cover,
                                  //   imageErrorBuilder:
                                  //       (context, error, stackTrace) {
                                  //     return Image.asset(
                                  //       R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                                  //       height: 106.w,
                                  //       width: 106.w,
                                  //     );
                                  //   },
                                  // ),
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
                                            userProvider
                                                    .userInfoModel?.nickName ??
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
                                await Get.dialog(ClockSuccessDialog(
                                    todayIntegral: 1, tomorrowIntegral: 2));
                                await UserTool.userProvider
                                    .changeTodayClocked();
                              },
                              elevation: 0,
                              color: Colors.white,
                              minWidth: 112.w,
                              height: 58.w,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.w)),
                              child:
                                  '${UserTool.userProvider.userConfig.todayClocked ? '已签到' : '签到'}'
                                      .text
                                      .size(22.sp)
                                      .black
                                      .make(),
                            ),
                            32.w.widthBox,
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 686.w,
                      height: 120.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage(Assets.static.vipBackground.path)),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.w),
                              topRight: Radius.circular(16.w))),
                      child: Row(
                        children: [
                          32.wb,
                          Assets.icons.vipFont.image(width: 60.w, height: 60.w),
                          24.wb,
                          '当前会员等级：2级'
                              .text
                              .size(24.sp)
                              .color(Color(0xFFFFE0A9))
                              .make(),
                          Spacer(),
                          GestureDetector(
                            onTap: () => Get.to(() => integralCenterPage()),
                            child: Container(
                              width: 160.w,
                              height: 58.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFE0A9),
                                  borderRadius: BorderRadius.circular(29.w)),
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
                padding: EdgeInsets.only(top: 450.w),
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
                      padding:
                          EdgeInsets.only(top: 24.w, left: 32.w, right: 32.w),
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
                                path: R.ASSETS_ICONS_USER_ICON_DFK_PNG,
                                index: 1,
                              ),
                              _orderButton(
                                name: '待发货',
                                path: R.ASSETS_ICONS_USER_ICON_DSH_PNG,
                                index: 2,
                              ),
                              _orderButton(
                                name: '待收货',
                                path: R.ASSETS_ICONS_USER_ICON_DPJ_PNG,
                                index: 3,
                              ),
                              _orderButton(
                                name: '已完成',
                                path: R.ASSETS_ICONS_USER_ICON_SH_PNG,
                                index: 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    24.w.heightBox,
                    Container(
                      width: double.infinity,
                      height: 100.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(16.w)),
                      margin: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ClockInPage());
                          },
                          borderRadius: BorderRadius.circular(16.w),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 24.w),
                            child: Row(
                              children: [
                                '我的积分'.text.size(30.sp).black.bold.make(),
                                Spacer(),
                                Assets.icons.intergral
                                    .image(width: 32.w, height: 32.w),
                                16.w.widthBox,
                                '123'.text.size(28.sp).black.make(),
                                16.w.widthBox,
                                Icon(
                                  CupertinoIcons.right_chevron,
                                  size: 24.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _function(
                              '我的房屋',
                              R.ASSETS_ICONS_ICON_MY_HOUSE_PNG,
                              () => HouseOwnersPage(
                                    identify: 4,
                                  ),
                              // userProvider.myHouses.first.communityName ??
                              ''),
                          36.hb,
                          _function('我的车位', R.ASSETS_ICONS_ICON_MY_CARSEAT_PNG,
                              () => CarParkingPage(), ''),
                          36.hb,
                          _function('我的车', R.ASSETS_ICONS_ICON_MY_CAR_PNG,
                              () => CarManagePage(), ''),
                          36.hb,
                          _function('我的访客', R.ASSETS_ICONS_ICON_MY_VISITOR_PNG,
                              () => CarManagePage(), ''),
                          36.hb,
                          _function(
                              '收货地址设置',
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
    );
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
