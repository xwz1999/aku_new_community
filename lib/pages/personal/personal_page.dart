import 'package:akuCommunity/pages/sign/sign_in_page.dart';
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

  bool _isSigned=false;
  @override
  void initState() { 
    super.initState();
    _isSigned=widget.isSign;
  }

  SliverAppBar _sliverAppBar(double height) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      stretch: true,
      floating: true,
      expandedHeight: Screenutil.length(450) - height,
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
                      margin: EdgeInsets.only(
                          top: Screenutil.length(175),
                          left: Screenutil.length(32)),
                      child: Row(
                        children: [
                          Container(
                            child: ClipOval(
                              child: CachedImageWrapper(
                                url:
                                    'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1851283359,3457678391&fm=26&gp=0.jpg',
                                width: Screenutil.length(106),
                                height: Screenutil.length(106),
                                isSigned: _isSigned,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              _isSigned? null:ARoute.push(context, SignInPage());
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: Screenutil.length(16)),
                                child: _isSigned
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
                        top: Screenutil.length(38),
                        left: Screenutil.length(36),
                        right: Screenutil.length(36),
                      ),
                      child: Image.asset(
                        'assets/images/member_bg.png',
                        width: Screenutil.length(678),
                        height: Screenutil.length(129),
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
      padding: EdgeInsets.all(title == '我的物业' ? 0 : Screenutil.length(32)),
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
                      SizedBox(width: Screenutil.length(8)),
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
          SliverToBoxAdapter(
            child: _containerBar('我的订单'),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: Screenutil.length(10)),
              color: BaseStyle.colorf9f9f9,
              child: GridButton(
                gridList: AssetsImage.orderGridList,
                count: 5,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                  top: Screenutil.length(32),
                  left: Screenutil.length(32),
                  right: Screenutil.length(32)),
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
              margin: EdgeInsets.only(top: Screenutil.length(10)),
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
              margin: EdgeInsets.all(Screenutil.length(20)),
              padding: EdgeInsets.all(Screenutil.length(12)),
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
