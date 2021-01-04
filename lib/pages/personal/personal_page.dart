import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:ani_route/ani_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/grid_button.dart';
import 'package:akuCommunity/widget/single_ad_space.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PersonalIndex extends StatefulWidget {
  final bool isSign;
  PersonalIndex({Key key, this.isSign}) : super(key: key);

  @override
  _PersonalIndexState createState() => _PersonalIndexState();
}

class _PersonalIndexState extends State<PersonalIndex>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  SliverAppBar _sliverAppBar(double height) {
    final userProvider = Provider.of<UserProvider>(context);
    return SliverAppBar(
      pinned: true,
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
                      margin: EdgeInsets.only(top: 175.w, left: 32.w),
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
                              if (!userProvider.isSigned)
                                ARoute.push(context, SignInPage());
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 16.w),
                                child: userProvider.isSigned
                                    ? Text(
                                        'Cheailune',
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
                    Container(
                      margin: EdgeInsets.only(
                        top: 38.w,
                        left: 36.w,
                        right: 36.w,
                      ),
                      child: Image.asset(
                        'assets/images/member_bg.png',
                        width: 678.w,
                        height: 129.w,
                      ),
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
              color: BaseStyle.color333333,
            ),
          ),
          title == '我的物业'
              ? SizedBox()
              : InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, PageName.order_page.toString());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '查看全部',
                        style: TextStyle(
                          fontSize: BaseStyle.fontSize22,
                          color: BaseStyle.color333333,
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
    super.build(context);
    double _statusHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: <Widget>[
          _sliverAppBar(_statusHeight),
          SliverToBoxAdapter(
            child: _containerBar('我的订单'),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10.w),
              color: BaseStyle.colorf9f9f9,
              child: GridButton(
                gridList: AssetsImage.orderGridList,
                count: 5,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 32.w, left: 32.w, right: 32.w),
              child: Divider(
                color: Color(0xffd8d8d8),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _containerBar('我的团购'),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: BaseStyle.colorf9f9f9,
              margin: EdgeInsets.only(top: 10.w),
              alignment: Alignment.center,
              child: GridButton(
                gridList: AssetsImage.orderGridList.take(3).skip(1).toList(),
                count: 5,
              ),
            ),
          ),
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
                  GridButton(
                    gridList: AssetsImage.mineGridList,
                    count: 4,
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
