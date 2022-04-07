// Dart imports:

import 'package:aku_new_community/constants/application_objects.dart';
import 'package:aku_new_community/extensions/color_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/home/home_activity_model.dart';
import 'package:aku_new_community/models/home/home_announce_model.dart';
import 'package:aku_new_community/models/home/home_swiper_model.dart';
import 'package:aku_new_community/pages/message_center_page/message_center_page.dart';
import 'package:aku_new_community/pages/one_alarm/widget/alarm_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/community/activity/activity_card.dart';
import 'package:aku_new_community/ui/community/activity/activity_detail_page.dart';
import 'package:aku_new_community/ui/community/activity/activity_list_page.dart';
import 'package:aku_new_community/ui/community/community_func.dart';
import 'package:aku_new_community/ui/community/notice/notice_detail_page.dart';
import 'package:aku_new_community/ui/home/home_notification.dart';
import 'package:aku_new_community/ui/home/home_title.dart';
import 'package:aku_new_community/ui/home/public_infomation/public_information_detail_page.dart';
import 'package:aku_new_community/ui/market/search/good_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/widget/beeImageNetwork.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/others/rectIndicator.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:aku_new_community/widget/views/bee_gradient_divider.dart';
import 'package:badges/badges.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:power_logger/power_logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  int _currentIndicator = 0;

  ScrollController? _scrollController;

  List<dynamic>? data;

  late EasyRefreshController _refreshController;

  int page = 1;
  int commentCount = 0;
  int sysCount = 0;
  int sum = 0;

  int _currentSwiperIndex = 0;

  // ActivityItemModel? _activityItemModel;
  List<HomeActivityModel> _activityItemModels = [];
  List<HomeAnnounceModel> _boardItemModels = [];
  List<HomeSwiperModel> _swiperModels = [];

  SwiperController _swiperController = SwiperController();

  @override
  void initState() {
    super.initState();
    if (UserTool.userProvider.isLogin) {
      try {
        JPush().setAlias(UserTool.userProvider.userInfoModel!.id.toString());
        LoggerData.addData(
            'setAlias ${UserTool.userProvider.userInfoModel!.id} ${DateTime.now()}');
      } catch (e) {
        LoggerData.addData('${e.toString()} ${DateTime.now()}');
      }
    }
    _scrollController = ScrollController();
    _refreshController = EasyRefreshController();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController?.dispose();
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    commentCount = appProvider.messageCenterModel.commentCount ?? 0;
    sysCount = appProvider.messageCenterModel.sysCount ?? 0;
    sum = commentCount + sysCount;
    var head = Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20.w,
          right: 32.w,
          left: 32.w,
          bottom: 20.w),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        // if (appProvider.location != null)
        Image.asset(
          Assets.home.icLocation.path,
          width: 48.w,
          height: 48.w,
        ),
        16.wb,
        Text(
          '${UserTool.userProvider.userInfoModel?.communityName ?? ""}',
          // appProvider.location?['city'] == null
          //     ? ''
          //     : appProvider.location?['city'] as String? ?? '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28.sp,
            color: Color(0xff333333),
          ),
          textAlign: TextAlign.center,
        ),
        // Text(
        //   '(${appProvider.weatherType} ${appProvider.weatherTemp}℃)',
        //   style: TextStyle(
        //     fontSize: 28.sp,
        //     color: Color(0xff999999),
        //   ),
        //   textAlign: TextAlign.center,
        // ),
        Spacer(),
        // GestureDetector(
        //   onTap: () {
        //     Get.to(() => BeeSearch());
        //   },
        //   child:
        //       Image.asset(Assets.home.icSearch.path, height: 48.w, width: 48.w),
        // ),
        20.wb,
        Badge(
            elevation: 0,
            badgeColor: Color(0xFFCF2525),
            padding: sum > 9 ? EdgeInsets.all(2.w) : EdgeInsets.all(5.w),
            showBadge: appProvider.messageCenterModel.commentCount != 0 ||
                appProvider.messageCenterModel.sysCount != 0,
            position: BadgePosition.topEnd(
              top: 8.w,
              end: -4.w,
            ),
            badgeContent: Text(
              (sum > 99 ? 99 : sum).toString(),
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
            child: GestureDetector(
              onTap: () {
                if (LoginUtil.isNotLogin) return;
                Get.to(() => MessageCenterPage());
              },
              child: Image.asset(Assets.home.icMessage.path,
                  height: 48.w, width: 48.w),
            )),
      ]),
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xFFFDE019),
          appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).padding.top + 88.w),
              child: head),
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(32.w)),
                  color: Color(0xFFF9F9F9)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: EasyRefresh(
                controller: _refreshController,
                header: MaterialHeader(),
                firstRefresh: true,
                onRefresh: () async {
                  _activityItemModels = await CommunityFunc.activityList();
                  _boardItemModels = await CommunityFunc.board();
                  _swiperModels = await CommunityFunc.swiper();
                  appProvider.getMessageCenter();
                  setState(() {});
                },
                child: CustomScrollView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: HomeSwiper(),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 32.w),
                        padding:
                            EdgeInsets.only(top: 20.w, left: 0.w, right: 0.w),
                        child: _applications(), //ApplicationView(),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.w),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: 686.w,
                        height: 320.w,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.w)),
                        margin: EdgeInsets.all(32.w),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(left: 34.w, top: 40.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.w),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            Assets.home.imgFkyq.path),
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '访客邀请',
                                        style: TextStyle(
                                            color: Color(0xD9000000),
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      10.hb,
                                      Text(
                                        '让拜访更加便捷',
                                        style: TextStyle(
                                          color: Color(0x73000000),
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  BotToast.showText(
                                      text: '本小区尚未配置门禁设备',
                                      align: Alignment(0, 0.5));
                                  //Get.to(() => VisitorAccessPage());
                                },
                              ),
                            ),
                            BeeGradientDivider.vertical(),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.w),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  Assets.home.imgYjbj.path),
                                            )),
                                        padding: EdgeInsets.only(
                                            left: 32.w, top: 40.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '一键报警',
                                              style: TextStyle(
                                                  color: Color(0xD9000000),
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            10.hb,
                                            Text(
                                              '提交报警位置给物业',
                                              style: TextStyle(
                                                color: Color(0x73000000),
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Get.to(() => AlarmPage());
                                      },
                                    ),
                                  ),
                                  BeeGradientDivider.horizontal(),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 40.w, left: 32.w),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.w),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  Assets.home.imgJyzx.path),
                                            )),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '建议咨询',
                                              style: TextStyle(
                                                  color: Color(0xD9000000),
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            10.hb,
                                            Text(
                                              '欢迎给我们提供服务意见',
                                              style: TextStyle(
                                                color: Color(0x73000000),
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        BotToast.showText(
                                            text: '此功能升级中，稍后上线',
                                            align: Alignment(0, 0.5));
                                        // Get.to(AdvicePage(
                                        //     type: AdviceType.SUGGESTION));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Container(
                      padding: EdgeInsets.all(32.w),
                      margin: EdgeInsets.symmetric(horizontal: 32.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.w)),
                      child: Column(
                        children: [
                          HomeTitle(
                            title: '社区活动',
                            suffixTitle: '查看全部',
                            onTap: () => Get.to(() => ActivityListPage()),
                          ),
                          24.hb,
                          _activityItemModels == []
                              ? SizedBox()
                              : Container(
                                  height: 450.w,
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: 16.w,
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 500.w,
                                        child: Builder(
                                          builder: (context) {
                                            return ActivityCard(
                                                home: true,
                                                model:
                                                    _activityItemModels[index]);
                                          },
                                        ),
                                      );
                                    },
                                    itemCount: _activityItemModels.length,
                                  ),
                                ),
                          // : ActivityCard(model: _activityItemModel)
                          //     .pSymmetric(h: 24.w, v: 24.w),
                        ],
                      ),
                    )),
                    SliverToBoxAdapter(
                      child: 48.hb,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget HomeSwiper() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(32.w),
      height: 248.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.w)),
      child: Swiper(
        key: UniqueKey(),
        controller: _swiperController,
        onIndexChanged: (index) async {
          _currentSwiperIndex = index;
        },
        itemBuilder: (BuildContext context, int index) {
          return getSwiperImage(_swiperModels[index]);
        },

        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: SwiperCustomPagination(
                builder: (BuildContext context, SwiperPluginConfig config) {
              return RectIndicator(
                position: config.activeIndex,
                count: _swiperModels.length,
                activeColor: Color(0x99FFFFFF),
                color: Color(0xD9FFFFFF),
                //未选中 指示器颜色，选中的颜色key为Color
                width: 4,
                //指示器宽度
                activeWidth: 14,
                //选中的指示器宽度
                radius: 4,
                //指示器圆角角度
                height: 4,
              ); //指示器高度
            })),
        scrollDirection: Axis.horizontal,
        // control: new SwiperControl(),
        autoplay: true,
        onTap: (index) {
          swiperNavigate(_swiperModels[index]);
        },
        itemCount: _swiperModels.length,
      ),
    );
  }

  void swiperNavigate(HomeSwiperModel model) {
    switch (model.type) {
      case 1:
        launch(model.customizeUrl ?? '');
        break;
      case 2:
        model.associationId == null
            ? null
            : Get.to(() => GoodDetailPage(
                  goodId: model.associationId!,
                ));
        break;
      case 3:
        model.associationId == null
            ? null
            : Get.to(() => PublicInformationDetailPage(
                  id: model.associationId!,
                ));
        break;
      case 4:
        model.associationId == null
            ? null
            : Get.to(() => NoticeDetailPage(
                  id: model.associationId!,
                ));
        break;
      case 5:
        model.associationId == null
            ? null
            : Get.to(() => ActivityDetailPage(
                  id: model.associationId!,
                ));
        break;
      default:
        () {};
    }
  }

  Widget getSwiperImage(HomeSwiperModel swiperModel) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.w)),
      child: BeeImageNetwork(
        imgs: swiperModel.imgList ?? [],
      ),
    );
  }

  Widget _applications() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getFunctionBtn(AO.fromRaw('报事报修')),
            getFunctionBtn(AO.fromRaw('设施预约')),
            getFunctionBtn(AO.fromRaw('生活缴费')),
            getFunctionBtn(AO.fromRaw('智慧养老')),
          ],
        ),
        24.hb,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getFunctionBtn(AO.fromRaw('周边服务')),
            getFunctionBtn(AO.fromRaw('任务发布', replaceTitle: '任务发布')),
            getFunctionBtn(AO.fromRaw('邻家宠物')),
            getFunctionBtn(AO.fromRaw('全部应用')),
          ],
        ),
        44.hb,
        BeeDivider.horizontal(),
        10.hb,
        HomeNotification(items: _boardItemModels),
        10.hb,
      ],
    );
  }

  Widget getFunctionBtn(AO ao) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          if (LoginUtil.isNotLogin) return;
          if (ao.title != '全部应用' && !LoginUtil.haveRealName(ao.title)) return;
          if (ao.callback == null) {
            BotToast.showText(
                text: '该功能正在准备上线中，敬请期待', align: Alignment(0, 0.5));
          } else {
            ao.callback!();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ao.path,
              height: 96.w,
              width: 96.w,
            ),
            8.hb,
            ao.title.text.size(24.sp).color(Color(0xFF333333)).make(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BeeBallPauseHeader extends Header {
  /// Key
  final Key? key;

  final ValueNotifier<Color> bgColor;

  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  BeeBallPauseHeader({
    this.key,
    required this.bgColor,
    bool enableHapticFeedback = true,
    bool enableInfiniteRefresh = false,
  }) : super(
          extent: 70.0,
          triggerDistance: 70.0,
          float: false,
          enableHapticFeedback: enableHapticFeedback,
          enableInfiniteRefresh: enableInfiniteRefresh,
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    linkNotifier.contentBuilder(
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteRefresh,
        success,
        noMore);
    return ValueListenableBuilder(
        valueListenable: bgColor,
        builder: (context, Color color, child) {
          return BallPulseHeaderWidget(
            key: key,
            color: bgColor.value.complementary,
            backgroundColor: bgColor.value,
            linkNotifier: linkNotifier,
          );
        });
  }
}
