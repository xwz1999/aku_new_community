import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/pages/activities_page/activities_page.dart';
import 'package:akuCommunity/pages/address_page/address_page.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_page.dart';
import 'package:akuCommunity/pages/mine_car_page/mine_car_page.dart';
import 'package:akuCommunity/pages/mine_house_page/mine_house_page.dart';
import 'package:akuCommunity/pages/personal/order_page.dart';
import 'package:akuCommunity/pages/personal/user_profile_page.dart';
import 'package:akuCommunity/pages/setting_page/settings_page.dart';
import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/pages/things_page/fixed_submit_page.dart';
import 'package:akuCommunity/pages/visitor_access_page/visitor_access_page.dart';
import 'package:akuCommunity/painters/user_bottom_bar_painter.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/grid_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/single_ad_space.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PersonalIndex extends StatefulWidget {
  final bool isSign;
  PersonalIndex({Key key, this.isSign}) : super(key: key);

  @override
  _PersonalIndexState createState() => _PersonalIndexState();
}

class _PersonalIndexState extends State<PersonalIndex>
    with SingleTickerProviderStateMixin {
  List<GridButton> _manageGridList = [
    GridButton('我的房屋', R.ASSETS_ICONS_USER_ICON_WDFW_PNG, () {
      MineHousePage().to();
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
      LifePayPage().to();
    }),
    GridButton('我的保修', R.ASSETS_ICONS_USER_ICON_WDBX_PNG, () {
      FixedSubmitPage().to();
    }),
    GridButton('我的地址', R.ASSETS_ICONS_USER_ICON_WDDZ_PNG, () {
      AddressPage().to();
    }),
    GridButton('我的管家', R.ASSETS_ICONS_USER_ICON_WDGJ_PNG, () {}),
    GridButton('我的访客', R.ASSETS_ICONS_USER_ICON_WDFK_PNG, () {
      VisitorAccessPage().to();
    }),
    GridButton('设置', R.ASSETS_ICONS_USER_ICON_SZ_PNG, () {
      SettingsPage().to();
    }),
  ];

  List<GridButton> _orderList = [
    GridButton('待付款', R.ASSETS_ICONS_USER_ICON_DFK_PNG, () {}),
    GridButton('待发货', R.ASSETS_ICONS_USER_ICON_DFH_PNG, () {}),
    GridButton('待收货', R.ASSETS_ICONS_USER_ICON_DSH_PNG, () {}),
    GridButton('待评价', R.ASSETS_ICONS_USER_ICON_DPJ_PNG, () {}),
    GridButton('售后', R.ASSETS_ICONS_USER_ICON_SH_PNG, () {}),
  ];

  List<GridButton> _groupOrderList = [
    GridButton('待发货', R.ASSETS_ICONS_USER_ICON_DFH_PNG, () {}),
    GridButton('待收货', R.ASSETS_ICONS_USER_ICON_DSH_PNG, () {}),
  ];

  SliverAppBar _sliverAppBar(double height) {
    final userProvider = Provider.of<UserProvider>(context);
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0,
      elevation: 0,
      stretch: true,
      floating: true,
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsImage.MINEBG),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: 32.w),
                      child: Row(
                        children: [
                          Container(
                            child: ClipOval(
                              child: CachedImageWrapper(
                                url:
                                    'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1851283359,3457678391&fm=26&gp=0.jpg',
                                width: 106.w,
                                height: 106.w,
                                isSigned: userProvider.isSigned,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (!userProvider.isLogin)
                                SignInPage().to();
                              else
                                UserProfilePage().to();
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 16.w),
                                child: userProvider.isLogin
                                    ? Text(
                                        userProvider.userInfoModel.nickName,
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
                          ),
                        ],
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

  Container _containerBar(String title) {
    return Container(
      color: title == '我的物业' ? Colors.white : BaseStyle.colorf9f9f9,
      padding: EdgeInsets.all(title == '我的物业' ? 0 : 32.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize34,
              color: ktextPrimary,
            ),
          ),
          title == '我的物业'
              ? SizedBox()
              : InkWell(
                  onTap: () {
                    OrderPage().to;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '查看全部',
                        style: TextStyle(
                          fontSize: BaseStyle.fontSize22,
                          color: ktextPrimary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        AntDesign.right,
                        size: BaseStyle.fontSize28,
                        color: BaseStyle.color999999,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _statusHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: <Widget>[
          _sliverAppBar(_statusHeight),
          // SliverToBoxAdapter(
          //   child: _containerBar('我的订单'),
          // ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     margin: EdgeInsets.only(top: 10.w),
          //     color: BaseStyle.colorf9f9f9,
          //     child: GridButtons(
          //       gridList: _orderList,
          //       crossCount: 5,
          //     ),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     margin: EdgeInsets.only(top: 32.w, left: 32.w, right: 32.w),
          //     child: Divider(
          //       color: Color(0xffd8d8d8),
          //     ),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: _containerBar('我的团购'),
          // ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     color: BaseStyle.colorf9f9f9,
          //     margin: EdgeInsets.only(top: 10.w),
          //     alignment: Alignment.center,
          //     child: GridButtons(
          //       gridList: _groupOrderList,
          //       crossCount: 5,
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: SingleAdSpace(
              imagePath: 'assets/example/guanggao7.png',
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
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
              margin: EdgeInsets.all(20.w),
              padding: EdgeInsets.all(12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _containerBar('我的物业'),
                  GridButtons(
                    gridList: _manageGridList,
                    crossCount: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
