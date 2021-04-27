import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/constants/application_objects.dart';
import 'package:aku_community/pages/personal/user_profile_page.dart';
import 'package:aku_community/pages/sign/sign_in_page.dart';
import 'package:aku_community/painters/user_bottom_bar_painter.dart';
import 'package:aku_community/provider/user_provider.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/views/application_view.dart';

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
                    image: AssetImage(R.ASSETS_IMAGES_MINE_BG_PNG),
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
                          Get.to(() => SignInPage());
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
