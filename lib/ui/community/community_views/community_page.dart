import 'dart:math';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/community/all_dynamic_list_model.dart';
import 'package:aku_new_community/models/community/information_category_list_model.dart';
import 'package:aku_new_community/models/community/information_list_model.dart';
import 'package:aku_new_community/models/community/topic_model.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/community/community_func.dart';
import 'package:aku_new_community/ui/community/community_views/add_new_event_page.dart';
import 'package:aku_new_community/ui/community/community_views/my_community_view.dart';
import 'package:aku_new_community/ui/community/community_views/new_community_view.dart';
import 'package:aku_new_community/ui/community/community_views/topic/topic_community_view.dart';
import 'package:aku_new_community/ui/community/community_views/topic/topic_detail_page.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/chat_card.dart';
import 'package:aku_new_community/ui/home/public_infomation/public_infomation_card.dart';
import 'package:aku_new_community/ui/home/public_infomation/public_infomation_page.dart';
import 'package:aku_new_community/ui/home/public_infomation/public_information_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  late EasyRefreshController _easyRefreshController;

  List<String> get _tabs {
    if (UserTool.userProvider.isLogin) return ['附近社区', '我的动态'];
    return ['附近社区'];
  }

  GlobalKey<TopicCommunityViewState> topicKey =
      GlobalKey<TopicCommunityViewState>();
  GlobalKey<MyCommunityViewState> myKey = GlobalKey<MyCommunityViewState>();
  GlobalKey<NewCommunityViewState> newKey = GlobalKey<NewCommunityViewState>();

  List<AllDynamicListModel> _newItems = [];
  List<TopicModel> _gambitModels = [];
  List<InformationListModel> _hotNewsModels = [];

  int _pageNum = 1;
  int _size = 4;
  bool _onload = true;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _easyRefreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Align(
            alignment: Alignment.centerLeft,
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: TabBar(
                onTap: (index) {
                  setState(() {});
                  if (_tabController?.index == 1) {
                    myKey.currentState?.refresh();
                  }
                },
                controller: _tabController,
                indicatorColor: Color(0xffffc40c),
                indicatorPadding: EdgeInsets.only(bottom: 15.w),
                indicator: const BoxDecoration(),
                tabs: _tabs.map((e) => Tab(text: e)).toList(),
                labelStyle:
                    TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold),
                labelColor: Color(0xD9000000),
                unselectedLabelStyle: TextStyle(fontSize: 32.sp),
                unselectedLabelColor: Color(0x73000000),
                isScrollable: true,
              ),
            )),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 32.w),
            child: GestureDetector(
              onTap: () async {
                if (LoginUtil.isNotLogin) return;
                bool? result = await Get.to(() => AddNewEventPage());
                if (result == true) {
                  switch (_tabController!.index) {
                    case 0:
                      _easyRefreshController.callRefresh();

                      break;
                    case 1:
                      myKey.currentState!.refresh();
                      break;
                  }
                }
              },
              child: Image.asset(R.ASSETS_ICONS_ICON_COMMUNITY_PUSH_PNG,
                  height: 40.w, width: 40.w),
            ),
          )
        ],
      ),
      body: TabBarView(
        children: [
          EasyRefresh(
            firstRefresh: true,
            header: MaterialHeader(),
            footer: MaterialFooter(),
            controller: _easyRefreshController,
            onRefresh: () async {
              _pageNum = 1;
              await (getNewInfo());
              _gambitModels = await CommunityFunc.getListGambit();
              _hotNewsModels = await CommunityFunc.getHotNews();
              _onload = false;
              setState(() {});
            },
            onLoad: () async {
              _pageNum++;
              await loadNewInfo();
              setState(() {});
            },
            child: _onload
                ? SizedBox()
                : ListView(
                    children: [
                      // _geSearch(),
                      // 2.hb,
                      _hotNewsModels.isEmpty ? SizedBox() : _getInfo(),
                      16.hb,
                      _gambitModels.isEmpty ? SizedBox() : _getNews(),
                      16.hb,
                      ..._newItems
                          .map((e) => ChatCard(
                              model: e,
                              refresh: () {
                                _easyRefreshController.callRefresh();
                                setState(() {});
                              }))
                          .toList()
                    ],
                  ),
          ),
          if (UserTool.userProvider.isLogin) MyCommunityView(key: myKey),
        ],
        controller: _tabController,
      ),
    );
  }

  Future getNewInfo() async {
    BaseListModel baseListModel = await NetUtil().getList(
        SAASAPI.community.dynamicList,
        params: {"pageNum": _pageNum, "size": _size, 'type': 1});
    if (baseListModel.rows.isNotEmpty) {
      _newItems = (baseListModel.rows)
          .map((e) => AllDynamicListModel.fromJson(e))
          .toList();
    }
  }

  Future loadNewInfo() async {
    BaseListModel baseListModel = await NetUtil().getList(
        SAASAPI.community.dynamicList,
        params: {"pageNum": _pageNum, "size": _size, 'type': 1});
    if (baseListModel.total > _newItems.length) {
      _newItems.addAll((baseListModel.rows)
          .map((e) => AllDynamicListModel.fromJson(e))
          .toList());
    } else {
      _easyRefreshController.finishLoadCallBack!(noMore: true);
    }
  }

  ///热门资讯
  _getInfo() {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(top: 32.w, bottom: 32.w, left: 32.w, right: 32.w),
      child: Column(
        children: [
          _homeTitle('热门资讯', () async {
            final cancel = BotToast.showLoading();
            BaseModel model =
                await NetUtil().get(SAASAPI.information.categoryList);
            var category = <InformationCategoryListModel>[];
            if (model.success == true && model.data != null) {
              category = (model.data as List)
                  .map((e) => InformationCategoryListModel.fromJson(e))
                  .toList();
            }
            cancel();
            Get.to(() => PublicInfomationPage(models: category));
          }, '更多'),
          32.hb,
          Container(
            height: 204.w,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 24.w,
                );
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 396.w,
                  child: Builder(
                    builder: (context) {
                      return _infoCard(_hotNewsModels[index]);
                    },
                  ),
                );
              },
              itemCount: _hotNewsModels.length,
            ),
          ),
        ],
      ),
    );
  }

  _homeTitle(String title, VoidCallback onTap, String suffixTitle) {
    return Row(
      children: [
        title.text.size(32.sp).bold.make(),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
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
        ),
        //24.wb,
      ],
    );
  }

  _next(int min, int max) {
    var rng = new Random();
//将 参数min + 取随机数（最大值范围：参数max -  参数min）的结果 赋值给变量 result;
    var result = min + rng.nextInt(max - min);
//返回变量 result 的值;
    return result;
  }

  _infoCard(InformationListModel item) {
    return GestureDetector(
      onTap: () async {
        var result =
            await Get.to(() => PublicInformationDetailPage(id: item.id));

        CommunityFunc.addViews(item.id);

        if (result != null && result) {
          _easyRefreshController.callRefresh();
        }
      },
      child: Stack(
        children: [
          Container(
            width: 396.w,
            height: 204.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(12),
                left: Radius.circular(16),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  SAASAPI.image(ImgModel.first(item.imgList)),
                ),
                fit: BoxFit.cover,
              ),
              //color: Colors.black38,
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              width: 396.w,
              height: 204.w,
              padding: EdgeInsets.only(
                  top: 32.w, left: 40.w, right: 40.w, bottom: 32.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(12),
                  left: Radius.circular(16),
                ), //color: Colors.black38,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 316.w,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold),
                      )),
                  24.hb,
                  Row(
                    children: [
                      Text(
                        '${item.viewsNum}浏览',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 24.sp,
                        ),
                      ),
                      Spacer(),
                      Text(
                        RelativeDateFormat.format(item.createDate.toDate()),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 24.sp,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getNews() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: 32.w,
        bottom: 32.w,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 32.w, right: 32.w),
            child: _homeTitle('新鲜话题', () {
              Get.to(() => TopicCommunityView());
            }, '全部'),
          ),
          32.hb,
          _newTopicListWidget()
        ],
      ),
    );
  }

  _geSearch() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.w, left: 32.w, right: 32.w),
      color: Colors.white,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 74.w,
        shape: StadiumBorder(),
        elevation: 0,
        minWidth: double.infinity,
        color: Color(0xFFF3F3F3),
        onPressed: () {
          // Get.to(() => TopicSearchPage());
        },
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 32.w,
              color: Color(0xFF666666),
            ),
            10.wb,
            '请输入关键字'.text.size(28.sp).color(ktextSubColor).make().expand(),
          ],
        ),
      ),
    );
  }

  ///新鲜话题列表
  _newTopicListWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 32.w, right: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Wrap(
                children: [..._gambitModels.map((e) => _choiceChip(e)).toList()]
                // [_choiceChip('EDG夺冠',1),_choiceChip('双十一',2),
                //   _choiceChip('11月吃土',2),_choiceChip('成都疫情',0),_choiceChip('万圣节',0)],
                ),
          ),
          // Spacer()
        ],
      ),
    );
  }

  _choiceChip(TopicModel item) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w, bottom: 24.w),
      child: ChoiceChip(
        backgroundColor: Color(0xFFF4F7FC),
        // disabledColor: Colors.blue,
        labelStyle: TextStyle(fontSize: 15 * 2.sp, color: Colors.black),

        labelPadding: EdgeInsets.only(right: 12.w, left: 12.w),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onSelected: (bool value) {
          Get.to(() => TopicDetailPage(
                topicId: item.id,
              ));
        },
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '# ${item.title}',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.65),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500),
            ),
            item.type != 1 ? 8.wb : SizedBox(),
            item.type != 1 ? _chipType(item.type) : SizedBox()
          ],
        ),
        selected: false,
      ),
    );
  }

  _chipType(int type) {
    return Container(
      width: 32.w,
      height: 32.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(6.4.w),
        ),
        color: type == 1 ? Color(0xFFFFD76F) : Color(0xFFFF8383),
      ),
      child: Text(
        type == 1 ? '荐' : '热',
        style: TextStyle(
            color: type == 1
                ? Colors.black.withOpacity(0.65)
                : Colors.white.withOpacity(0.85),
            fontSize: 20.sp,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
