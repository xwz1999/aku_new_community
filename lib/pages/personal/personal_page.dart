import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/constants/application_objects.dart';
import 'package:akuCommunity/pages/personal/order_page.dart';
import 'package:akuCommunity/pages/personal/user_profile_page.dart';
import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/painters/user_bottom_bar_painter.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/views/application_view.dart';

class PersonalIndex extends StatefulWidget {
  final bool isSign;
  PersonalIndex({Key key, this.isSign}) : super(key: key);

  @override
  _PersonalIndexState createState() => _PersonalIndexState();
}

class _PersonalIndexState extends State<PersonalIndex>
    with SingleTickerProviderStateMixin {
  SliverAppBar _sliverAppBar(double height) {
    final userProvider = Provider.of<UserProvider>(context);
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0,
      elevation: 0,
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
                    MaterialButton(
                      padding: EdgeInsets.all(5.w),
                      onPressed: () {
                        if (!userProvider.isLogin)
                          SignInPage().to();
                        else
                          UserProfilePage().to();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 32.w),
                        child: Row(
                          children: [
                            Hero(
                              tag: 'AVATAR',
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                                  image: API.image(
                                      userProvider?.userInfoModel?.imgUrl ??
                                          ''),
                                  height: 106.w,
                                  width: 106.w,
                                  fit: BoxFit.cover,
                                ),
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
    final double _statusHeight = MediaQuery.of(context).padding.top;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: EasyRefresh(
        header: MaterialHeader(),
        onRefresh: () async {
          await userProvider.updateProfile();
          await userProvider.updateUserDetail();
        },
        child: CustomScrollView(
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
            // SliverToBoxAdapter(
            //   child: SingleAdSpace(
            //     imagePath: 'assets/example/guanggao7.png',
            //   ),
            // ),
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
                    ApplicationView.custom(
                      items: userAppObjects,
                      needAllApp: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
