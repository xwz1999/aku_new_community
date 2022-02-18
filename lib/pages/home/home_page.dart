// Dart imports:

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:badges/badges.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:power_logger/power_logger.dart';
import 'package:provider/provider.dart';

import 'package:aku_new_community/constants/application_objects.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/extensions/color_ext.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/community/activity_item_model.dart';
import 'package:aku_new_community/model/community/board_model.dart';
import 'package:aku_new_community/model/community/swiper_model.dart';
import 'package:aku_new_community/pages/message_center_page/message_center_page.dart';
import 'package:aku_new_community/pages/one_alarm/widget/alarm_page.dart';
import 'package:aku_new_community/pages/visitor_access_page/visitor_access_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/community/activity/activity_card.dart';
import 'package:aku_new_community/ui/community/activity/activity_list_page.dart';
import 'package:aku_new_community/ui/community/community_func.dart';
import 'package:aku_new_community/ui/home/home_notification.dart';
import 'package:aku_new_community/ui/home/home_title.dart';
import 'package:aku_new_community/ui/home/public_infomation/public_information_detail_page.dart';
import 'package:aku_new_community/ui/manager/advice/advice_page.dart';
import 'package:aku_new_community/ui/search/bee_search.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/widget/animated/OverlayWidget.dart';
import 'package:aku_new_community/widget/others/rectIndicator.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';

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
  List<ActivityItemModel> _activityItemModels = [];
  List<BoardItemModel> _boardItemModels = [];
  List<SwiperModel> _swiperModels = [];

  SwiperController _swiperController = SwiperController();
  ValueNotifier<Color> _barColor = ValueNotifier(Colors.transparent);

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
    _swiperController.addListener(() {
      //由于先触发监听后，再执行onChangeIndex函数，所以_currentSwiperIndex会比当前index少1，用+1并求余的方式获得真正当前index;
      _swiperBarColor((_currentSwiperIndex + 1) % 3);
    });
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
    var head = ValueListenableBuilder(
      valueListenable: _barColor,
      builder: (context, Color color, child) {
        return Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: color),
            color: color,
          ),
          width: double.infinity,
          child: child,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          if (appProvider.location != null)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Image.asset(
                R.ASSETS_ICONS_ICON_MAIN_LOCATION_PNG,
                width: 32.w,
                height: 32.w,
              ),
            ),
          Text(
            appProvider.location?['city'] == null
                ? ''
                : appProvider.location?['city'] as String? ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
              color: Color(0xff333333),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '(${appProvider.weatherType} ${appProvider.weatherTemp}℃)',
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xff999999),
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Get.to(() => BeeSearch());
            },
            child: Image.asset(R.ASSETS_ICONS_ICON_MAIN_FIND_PNG,
                height: 40.w, width: 40.w),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w, left: 12.w),
            child: Badge(
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
                  child: Image.asset(R.ASSETS_ICONS_ICON_MAIN_MESSAGE_PNG,
                      height: 40.w, width: 40.w),
                )),
          ),
        ]),
      ),
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              EasyRefresh(
                controller: _refreshController,
                header: BeeBallPauseHeader(bgColor: _barColor),
                firstRefresh: true,
                onRefresh: () async {
                  //_activityItemModel = await CommunityFunc.activity();
                  _activityItemModels = await CommunityFunc.activityList();
                  _boardItemModels = await CommunityFunc.board();
                  _swiperModels = await CommunityFunc.swiper();
                  appProvider.getMessageCenter();
                  setState(() {});
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HomeSwiper(), //要做点击事件
                          // SizedBox(height: 100.w),
                          Container(
                            padding: EdgeInsets.only(top: 24.w, bottom: 32.w),
                            child: getFunction(), //ApplicationView(),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0x14000000),
                                      blurRadius: 0,
                                      offset: Offset(0.0, 2.0),
                                      spreadRadius: 0.1)
                                ],
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(28),
                                    bottomRight: Radius.circular(28))),
                          )
                          //ApplicationBox(child: ApplicationView()),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                          height: 40,
                          margin: EdgeInsets.only(
                              left: 32.w, right: 32.w, top: 24.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Color(0x14000000),
                                  blurRadius: 4,
                                  spreadRadius: 0.5)
                            ],
                          ),
                          child: HomeNotification(items: _boardItemModels)),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 24.w),
                              padding: EdgeInsets.only(left: 32.w, top: 24.w),
                              width: 140,
                              height: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage(R.ASSETS_IMAGES_CARD_YELLOW_PNG),
                              )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '访客邀请',
                                    style: TextStyle(
                                        color: Color(0xD9000000),
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  10.hb,
                                  Text(
                                    '一键分享',
                                    style: TextStyle(
                                      color: Color(0x73000000),
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    '让拜访不再是难事',
                                    style: TextStyle(
                                      color: Color(0x73000000),
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    R.ASSETS_ICONS_ICON_MAIN_INVITE_PNG,
                                    width: 100.w,
                                    height: 100.w,
                                  ),
                                  30.hb,
                                ],
                              ),
                            ),
                            onTap: () {
                              Get.to(VisitorAccessPage());
                            },
                          ),
                          25.wb,
                          Container(
                            margin: EdgeInsets.only(top: 24.w),
                            child: Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    width: 190,
                                    height: 69,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          R.ASSETS_IMAGES_CARD_PINK_PNG),
                                    )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        20.wb,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            20.hb,
                                            Text(
                                              '一键报警',
                                              style: TextStyle(
                                                  color: Color(0xD9000000),
                                                  fontSize: 26.sp,
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
                                        Spacer(),
                                        Image.asset(
                                          R.ASSETS_ICONS_ICON_MAIN_POLICE_PNG,
                                          width: 98.w,
                                          height: 98.w,
                                        ),
                                        20.wb,
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Get.to(AlarmPage());
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20.w),
                                    width: 190,
                                    height: 69,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          R.ASSETS_IMAGES_CARD_BLUE_PNG),
                                    )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        20.wb,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            20.hb,
                                            Text(
                                              '建议咨询',
                                              style: TextStyle(
                                                  color: Color(0xD9000000),
                                                  fontSize: 26.sp,
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
                                        Spacer(),
                                        Image.asset(
                                          R.ASSETS_ICONS_ICON_MAIN_CONSULT_PNG,
                                          width: 98.w,
                                          height: 98.w,
                                        ),
                                        20.wb,
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Get.to(AdvicePage(
                                        type: AdviceType.SUGGESTION));
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Column(
                      children: [
                        HomeTitle(
                          title: '社区活动',
                          suffixTitle: '查看全部',
                          onTap: () => Get.to(() => ActivityListPage()),
                        ),
                        _activityItemModels == []
                            ? SizedBox()
                            : Container(
                                height: 400.w,
                                padding: EdgeInsets.only(left: 32.w),
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
                    )),
                  ],
                ),
              ),
              OverlayLivingBtnWidget()
            ],
          ),
        ));
  }

  Widget HomeSwiper() {
    return Container(
      width: double.infinity,
      height: 320.w,
      decoration:
          BoxDecoration(border: Border.all(width: 0, color: _barColor.value)),
      child: AspectRatio(
        aspectRatio: 375 / 160,
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
            Get.to(() =>
                PublicInformationDetailPage(id: _swiperModels[index].newsId!));
          },
          itemCount: _swiperModels.length,
        ),
      ),
    );
  }

  Future _swiperBarColor(int index) async {
    if (_swiperModels.isNotEmpty) {
      var color =
          await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(
        SARSAPI.image(ImgModel.first(_swiperModels[index].voResourcesImgList)),
      ));
      _barColor.value = color.dominantColor?.color ?? Colors.transparent;
    } else {
      _barColor.value = Colors.transparent;
    }
  }

  Widget getSwiperImage(SwiperModel swiperModel) {
    return Container(
      child: FadeInImage.assetNetwork(
        placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
        image: SARSAPI.image(ImgModel.first(swiperModel.voResourcesImgList)),
        fit: BoxFit.fill,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }

  Widget getFunction() {
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
        32.hb,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getFunctionBtn(AO.fromRaw('周边服务')),
            getFunctionBtn(AO.fromRaw('小蜜蜂任务', replaceTitle: '任务发布')),
            getFunctionBtn(AO.fromRaw('邻家宠物')),
            getFunctionBtn(AO.fromRaw('全部应用')),
          ],
        ),
      ],
    );
  }

  Widget getFunctionBtn(AO ao) {
    return MaterialButton(
      shape: StadiumBorder(),
      padding: EdgeInsets.zero,
      onPressed: () {
        if (LoginUtil.isNotLogin) return;
        if (!LoginUtil.haveRoom(ao.title)) return;
        if (ao.page == null) {
          BotToast.showText(text: '该功能正在准备上线中，敬请期待', align: Alignment(0, 0.5));
        } else {
          Get.to(ao.page);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ao.path,
            height: 80.w,
            width: 80.w,
          ),
          16.hb,
          ao.title.text.size(22.sp).color(Color(0xA6000000)).bold.make(),
        ],
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
