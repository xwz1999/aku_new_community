import 'dart:async';
import 'dart:convert';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/message_center_page/message_center_page.dart';
import 'package:akuCommunity/pages/scan/scan_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/extensions/num_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'widget/home_search.dart';
import 'widget/home_swiper.dart';
import 'widget/home_card.dart';
import 'widget/home_tag_bar.dart';
import 'package:akuCommunity/widget/container_comment.dart';
import 'package:akuCommunity/widget/single_ad_space.dart';
import 'package:akuCommunity/widget/grid_button.dart';
import 'package:akuCommunity/service/base_model.dart';
import 'package:akuCommunity/model/aku_shop_model.dart';
import 'package:akuCommunity/routers/page_routers.dart';

import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  List<AkuShopModel> _shopList = [];
  List<dynamic> data;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int page = 1;

  @override
  void initState() {
    super.initState();
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("assets/json/shop.json");
    loadString.then((String value) {
      // 通知框架此对象的内部状态已更改
      akuShop(value);
    });
    // akuShop(page);
  }

  Future<void> akuShop(String response) async {
    Map<String, dynamic> result = json.decode(response.toString());
    BaseModel model = BaseModel.fromJson(result);
    model.result.forEach((item) {
      item["count"] = 1;
      item["isCheck"] = false;
      AkuShopModel list = AkuShopModel.fromJson(item);
      setState(() {
        _shopList.add(list);
      });
    });
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1500));
    page++;
    // akuShop(page);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  _buildColButton({IconData icon, String title, VoidCallback onTap}) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: 0,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48.w, color: Colors.black),
          4.hb,
          title.text.size(20.sp).black.make(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return BeeScaffold(
      title: 'TEST',
      bgColor: BaseStyle.colorffd000,
      leading: Container(
        margin: EdgeInsets.only(left: 32.w),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '深圳',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  color: Color(0xff333333),
                ),
              ),
              Text(
                '阴 27℃',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Color(0xff333333),
                ),
              )
            ]),
      ),
      actions: [
        _buildColButton(
          icon: AntDesign.scan1,
          title: '扫一扫',
          onTap: () => Get.to(ScanPage()),
        ),
        _buildColButton(
          icon: AntDesign.bells,
          title: '消息',
          onTap: () => Get.to(MessageCenterPage()),
        ),
        16.wb,
      ],
      body: RefreshConfiguration(
        child: SmartRefresher(
          controller: _refreshController,
          header: WaterDropHeader(),
          footer: ClassicFooter(),
          onLoading: _onLoading,
          enablePullUp: true,
          enablePullDown: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HomeSearch(),
                    HomeSwiper(),
                    SizedBox(height: 100.w),
                    ContainerComment(
                      radius: 8,
                      customWidget: GridButton(
                        gridList: AssetsImage.homeGridList,
                        count: 4,
                      ),
                    ),
                    SingleAdSpace(
                      imagePath: 'assets/example/guanggao2.png',
                    ),
                    HomeTagBar(
                      title: '物业收费标准请查收~',
                      tag: '公告',
                      isShowImage: true,
                    ),
                    Column(
                      children: [
                        HomeTagBar(
                          title: '社区活动',
                          tag: '活动',
                          isShowImage: false,
                          fun: () {
                            Navigator.pushNamed(
                                context, PageName.activities_page.toString(),
                                arguments: Bundle()..putBool('isVote', false));
                          },
                        ),
                        HomeCard(
                          isActivity: true,
                          title: '22日上午10点,阳光小镇在二期乒乓球场地举行了小区乒乓比赛',
                          subtitleOne: '活动时二楼',
                          subtitleTwo: '06月17日 12:00至06月17日 18:30',
                          imagePath:
                              'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1601275745883&di=e7b2a1afdb8812f8a9acd9742ea7e1a7&imgtype=0&src=http%3A%2F%2Fy3.ifengimg.com%2Fcmpp%2F2013%2F12%2F27%2F03%2F459f46cb-c07f-4083-9a65-27b90cb4562f.jpg',
                        ),
                      ],
                    ),
                    SizedBox(height: 24.w),
                    // Column(
                    //   children: [
                    //     HomeTagBar(
                    //       title: '社区团购',
                    //       tag: '团购',
                    //       isShowImage: false,
                    //     ),
                    //     HomeCard(
                    //       isActivity: false,
                    //       title: '新疆库尔阿勒4.5斤,仙人蕉 香甜可口',
                    //       subtitleOne: '中国新疆',
                    //       subtitleTwo: '2020年07月03日',
                    //       imagePath:
                    //           'http://news.eastday.com/d/file/tga/2013-02-17/c2e7bd7fca1ed2ecf5d50dc9fb30275d.jpg',
                    //     ),
                    //     HomeCard(
                    //       isActivity: false,
                    //       title: '刚果柠檬大果4盒 鲜果新鲜采摘15斤',
                    //       subtitleOne: '非洲刚果',
                    //       subtitleTwo: '2020年08月09日',
                    //       imagePath:
                    //           'http://5b0988e595225.cdn.sohucs.com/images/20180203/328e145f84c54dd08d1b11b890109862.jpeg',
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 30.w),
                    // HomeTagBar(
                    //   title: '社区商城',
                    //   tag: '团购',
                    //   isShowImage: false,
                    //   isShowTitle: true,
                    // ),
                  ],
                ),
              ),
              // SliverPadding(
              //     padding: EdgeInsets.only(
              //       top: 30.w,
              //       left: 32.w,
              //       right: 32.w,
              //     ),
              //     sliver: _shopList.length == 0
              //         ? SliverToBoxAdapter(child: GoodsCardSkeleton())
              //         : SliverGoodsCard(shoplist: _shopList)),
            ],
          ),
        ),
      ),
    );
  }
}
