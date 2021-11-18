import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/application_objects.dart';
import 'package:aku_community/pages/message_center_page/message_center_page.dart';
import 'package:aku_community/pages/personal/user_profile_page.dart';
import 'package:aku_community/pages/sign/sign_in_page.dart';
import 'package:aku_community/painters/user_bottom_bar_painter.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/provider/user_provider.dart';
import 'package:aku_community/ui/profile/order/order_page.dart';
import 'package:aku_community/ui/search/bee_search.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/login_util.dart';
import 'package:aku_community/widget/views/application_view.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class PropertyPage extends StatefulWidget {
  final bool? isSign;

  PropertyPage({Key? key, this.isSign}) : super(key: key);

  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int sum = 0;
  int commentCount = 0;
  int sysCount = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        initialIndex: 0, length: 2, vsync: this);

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  SliverAppBar _sliverAppBar(double height) {
    final userProvider = Provider.of<UserProvider>(context);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    commentCount = appProvider.messageCenterModel.commentCount ?? 0;
    sysCount = appProvider.messageCenterModel.sysCount ?? 0;
    sum = commentCount + sysCount;
    return SliverAppBar(
      pinned: true,
      snap: false,
      //toolbarHeight: 0,
      elevation: 0,
      collapsedHeight:420.w,
      titleSpacing: 10.0,
      floating: true,
      title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (appProvider.location != null)
              Padding(
                padding:  EdgeInsets.only(right: 5),
                child: Image.asset(
                  R.ASSETS_ICONS_ICON_MAIN_LOCATION_PNG,
                  width: 32.w,
                  height: 32.w,
                ),
              ),
            Text(
              appProvider.location?['city']==null?'':appProvider.location?['city'] as String? ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                color: Color(0xff333333),
              ),
              textAlign: TextAlign.center,
            ),
          ]),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(() => BeeSearch());
          },
          child: Image.asset(R.ASSETS_ICONS_ICON_MAIN_FIND_PNG,
              height: 40.w, width: 40.w),
        ),
        Padding(
          padding:  EdgeInsets.only(right: 10.w, left: 12.w),
          child: Badge(
              elevation: 0,
              badgeColor: Color(0xFFCF2525),
              padding: sum > 9 ? EdgeInsets.all(2.w) : EdgeInsets.all(5.w),
              showBadge: appProvider.messageCenterModel.commentCount != 0 ||
                  appProvider.messageCenterModel.sysCount != 0,
              position: BadgePosition.topEnd(
                top: 3,
                end: -5,
              ),
              badgeContent: Text(
                (sum).toString(),
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
              ),
              child: GestureDetector(
                onTap: () {
                  if (LoginUtil.isNotLogin) return;
                  Get.to(() => MessageCenterPage());
                },
                child: Image.asset(R.ASSETS_ICONS_ICON_MAIN_MESSAGE_PNG,
                    height: 40.w, width: 40.w),
              )),
        ),
      ],
      expandedHeight: 420.w,
      backgroundColor: Colors.white,
      flexibleSpace: Stack(
        children: [
          Positioned(
              child: Container(
                color: Color(0xF9D57A59),
                height: 503.w,
                width: double.infinity,
              ),
              // Image(
              //   fit: BoxFit.cover,
              //   image: NetworkImage(
              //     "https://images.pexels.com/photos/62389/pexels-photo-62389.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
              //   ),
              // ),
              top: 0,
              left: 0,
              right: 0,
              bottom: 0),
          // Positioned(
          //   child: Container(
          //     height: 30,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.vertical(
          //         top: Radius.circular(50),
          //       ),
          //     ),
          //   ),
          //   bottom: -1,
          //   left: 0,
          //   right: 0,
          // ),
          Positioned(
              child: Container(
                margin: EdgeInsets.only(left: 32.w,right: 32.w),
                width: 686.w,
                height: 74.w,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.w),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    24.wb,
                    Text('当前绑定房屋',style: TextStyle(fontSize: 28.sp,color: Colors.white.withOpacity(0.85),height: 1.00),),
                    Spacer(),
                    Text('B栋2单元1803室',style: TextStyle(fontSize: 28.sp,color: Colors.white.withOpacity(0.85),height:1.00,fontWeight: FontWeight.bold),),
                    32.wb,
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80.w,
                        height: 42.w,
                        child:Text('切换',style: TextStyle(fontSize: 24.sp,color: Colors.white.withOpacity(0.85)),),
                        decoration: BoxDecoration(
                          color: Color(0xFF3D8CE8),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.w),
                          ),
                        ),
                      ),
                    ),
                    24.wb,

                  ],
                ),
              ),
              top: kTextTabBarHeight+50.w,
              left: 0,
              right: 0,
             ),

          Positioned(
            child: _goodsTitle(),
            top: kTextTabBarHeight+50.w+94.w,
            left: 0,
            right: 0,
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 20.w),
              height: 150.w,

              child: TabBarView(
                children: [_payView(true),_payView(false)],
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
            top: kTextTabBarHeight+50.w+94.w+60.w,
            left: 0,
            right: 0,
          ),
        ],
      ),


    );
  }


  _payView(bool pay){
    return Container(
      padding: EdgeInsets.only(left: 36.w,right: 36.w),
      width: double.infinity,
      height: 150.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1,944.00',
                style: TextStyle(
                  color: Color(0xFFFFFFFF).withOpacity(0.85),
                  fontSize: 40.sp,
                ),
              ),
              8.hb,
              Text(
                '点击查看明细',
                style: TextStyle(
                  color: Color(0xFFFFFFFF).withOpacity(0.45),
                  fontSize: 22.sp,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            alignment: Alignment.center,
            width: 160.w,
            height: 55.w,
            child:Text(!pay?'一键缴费':'点击充值',style: TextStyle(fontSize: 24.sp,color: Colors.white.withOpacity(0.85)),),
            decoration: BoxDecoration(
              color: Color(0xFFFFB634),
              borderRadius: BorderRadius.all(
                Radius.circular(8.w),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _goodsTitle(){
    return Row(
        children: [
          24.wb,
          Container(
            height: 60.w,
            child: Material(
              color: Colors.transparent,
              child: TabBar(
                  onTap: (index) {
                    // _presenter.fetchList(_category.id, 0, _sortType);
                    setState(() {});
                  },
                  isScrollable: true,
                  labelPadding:  EdgeInsets.zero,

                  controller: _tabController,
                  labelColor: Colors.white.withOpacity(0.85),
                  unselectedLabelColor: Colors.white.withOpacity(0.65),

                  indicatorPadding: EdgeInsets.symmetric(horizontal: 40.w),
                  indicatorSize: TabBarIndicatorSize.label,

                  labelStyle: TextStyle(color:Colors.white.withOpacity(0.85),),

                  indicatorColor: Color(0xFFE8A93A),
                  tabs: _tabItems()),
            ),
          ),
          Spacer(),
          Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Text(
                  '缴费记录',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 24.sp,
                  ),
                ),
                10.wb,
                Icon(
                  CupertinoIcons.chevron_forward,
                  size: 24.w,
                  color: Colors.white.withOpacity(0.45),
                ),
              ],
            ),
          ),

          36.wb,
        ],
      );

  }

  List<Widget> _tabItems() {
    return [_tabItem(0,'未缴账单'),_tabItem(1,'预缴金额')];
  }

  _tabItem(int index,String text) {
    bool isChoose = index == _tabController.index;
    // Color textColor = index == _tabController.index
    //     ? getCurrentThemeColor()
    //     : Colors.black.withOpacity(0.9);
    return Tab(
      child: Container(
        alignment: Alignment.center,
        width: 150.w,

        // color: Colors.white,
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  fontWeight: isChoose?FontWeight.bold:FontWeight.normal,
                  fontSize: isChoose?32.sp:28.sp,
                  color: isChoose?Colors.white.withOpacity(0.85):Colors.white.withOpacity(0.65)),
            ),
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

  Widget _orderButton({
    required String name,
    required String path,
    required int index,
  }) {
    return MaterialButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(path, height: 50.w, width: 50.w),
          10.hb,
          Text(
            name,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 22.sp,
            ),
          ),
        ],
      ),
      onPressed: () {
        Get.to(() => OrderPage(initIndex: index));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _statusHeight = MediaQuery.of(context).padding.top;
    final userProvider = Provider.of<UserProvider>(context);
    var orderWidget = SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _containerBar('我的订单'),
          GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            shrinkWrap: true,
            children: [
              _orderButton(
                name: '待付款',
                path: R.ASSETS_ICONS_USER_ICON_DFK_PNG,
                index: 1,
              ),
              _orderButton(
                name: '待收货',
                path: R.ASSETS_ICONS_USER_ICON_DSH_PNG,
                index: 2,
              ),
              _orderButton(
                name: '待评价',
                path: R.ASSETS_ICONS_USER_ICON_DPJ_PNG,
                index: 3,
              ),
              _orderButton(
                name: '售后',
                path: R.ASSETS_ICONS_USER_ICON_SH_PNG,
                index: 4,
              ),
            ],
          ),
        ],
      ),
    );
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

            // orderWidget,
            SliverToBoxAdapter(
              child: _getFunctionView(getOutApp,'出行安全',Color(0xFFFAC058)),
            ),
            SliverToBoxAdapter(
              child: _getFunctionView(propertyServicesApp,'物业服务',Color(0xFF58FA8F)),
            ),
            SliverToBoxAdapter(
              child: _getFunctionView(residentLifeApp,'居民生活',Color(0xFF58C0FA)),
            ),
            SliverToBoxAdapter(
              child: _getFunctionView(aboutCommunityApp,'关于社区',Color(0xFFFA5858)),
            ),
          ],
        ),
      ),
    );
  }

  _getFunctionView(List<AO> item,String title,Color color){
    return Container(
      margin: EdgeInsets.only(left: 32.w,right: 32.w,top: 32.w),
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
      //margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.only(left: 32.w,right: 32.w,top: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _containerBar('我的物业'),
          Container(
            child: Column(
              children: [
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 6.w),
                      width: 4.w,
                      height: 24.w,
                      color: color,
                    ),
                    10.wb,
                    _getTitle(title),
                  ],
                ),
                ApplicationView.custom(
                  items: item,
                  needAllApp: false,
                ),
              ],
            ),
          )


        ],
      ),
    );
  }

  _getTitle(String title){
   return  Text(
     title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28.sp,
        color: ktextPrimary,

      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
