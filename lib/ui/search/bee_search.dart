import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/application_objects.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/community/activity_item_model.dart';
import 'package:aku_new_community/model/community/community_topic_model.dart';
import 'package:aku_new_community/models/search/search_model.dart';
import 'package:aku_new_community/ui/community/activity/activity_detail_page_old.dart';
import 'package:aku_new_community/ui/community/community_views/topic/topic_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';

class BeeSearch extends StatefulWidget {
  BeeSearch({Key? key}) : super(key: key);

  @override
  _BeeSearchState createState() => _BeeSearchState();
}

class _BeeSearchState extends State<BeeSearch> {
  late EasyRefreshController _refreshController;
  TextEditingController _textEditingController = TextEditingController();
  SearchModel _searchModel = SearchModel.init();

  @override
  void initState() {
    _refreshController = EasyRefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  List<AO> get _searchAppObjects {
    if (_textEditingController.text.isEmpty) return [];
    return appObjects
        .where((element) => element.title.contains(_textEditingController.text))
        .toList();
  }

  List<dynamic> _getNullSafeObjects(dynamic list) {
    List _list = [];
    list.forEach((element) {
      if (element != null) {
        _list.add(element);
      }
    });
    return _list;
  }

  _renderSearchResultBox(String title, {Widget? child, bool visible = true}) {
    if (!visible) return SizedBox().sliverBoxAdapter();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.text.size(28.sp).make(),
        Divider(),
        child!,
      ],
    ).p(32.w).material(color: Colors.white).sliverBoxAdapter();
  }

  Widget _buildColumnIcon(AO e) {
    return MaterialButton(
      onPressed: () {
        if (LoginUtil.isNotLogin) return;
        // if (!LoginUtil.haveRealName(e.title)) return;
        if (e.callback == null) {
          BotToast.showText(text: '该功能正在准备上线中，敬请期待', align: Alignment(0, 0.5));
        } else {
          e.callback!();
        }
      },
      shape: StadiumBorder(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            e.path,
            height: 75.w,
            width: 75.w,
          ),
          8.hb,
          e.title.text.size(24.sp).make(),
        ],
      ),
    );
  }

  ///社区活动卡片
  Widget _activityCardButton(ActivityItemModel model) {
    return MaterialButton(
      onPressed: () {
        Get.to(() => ActivityDetailPage(id: model.id));
      },
      shape: StadiumBorder(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200.w,
            height: 200.w,
            child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                child: FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  image: SAASAPI.image(ImgModel.first(model.imgUrls)),
                  fit: BoxFit.cover,
                )),
          ),
          12.w.widthBox,
          SizedBox(
            width: 400.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                model.title!.text
                    .size(28.sp)
                    .color(ktextPrimary)
                    .maxLines(2)
                    .overflow(TextOverflow.ellipsis)
                    .isIntrinsic
                    .bold
                    .make()
                    .expand(),
                model.statusString.text
                    .size(24.sp)
                    .color(model.statusColor)
                    .make()
                    .expand()
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///话题卡片
  Widget _communityCardButton(CommunityTopicModel model) {
    return MaterialButton(
      onPressed: () {
        Get.to(() => TopicDetailPage(
              topicId: model.id,
            ));
      },
      shape: StadiumBorder(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200.w,
            height: 200.w,
            child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                child: FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  image: SAASAPI.image(ImgModel.first(model.imgUrl)),
                  fit: BoxFit.cover,
                )),
          ),
          12.w.widthBox,
          SizedBox(
            width: 400.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                model.title!.text
                    .size(28.sp)
                    .color(ktextPrimary)
                    .maxLines(2)
                    .bold
                    .overflow(TextOverflow.ellipsis)
                    .isIntrinsic
                    .make()
                    .expand(),
                model.summary!.text
                    .size(28.sp)
                    .color(ktextPrimary)
                    .maxLines(1)
                    .overflow(TextOverflow.ellipsis)
                    .make()
                    .expand(),
                SizedBox(
                  width: 100.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        R.ASSETS_ICONS_HOT_FIRE_PNG,
                        height: 24.w,
                        width: 24.w,
                      ),
                      12.wb,
                      '${model.activityNum}'.text.maxLines(1).size(22.sp).make()
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BeeBackButton(),
        elevation: 0,
        title: Row(
          children: [
            40.wb,
            Icon(
              Icons.search,
              size: 32.w,
              color: Color(0xFF666666),
            ),
            TextField(
              controller: _textEditingController,
              onChanged: (_) {
                _refreshController.callRefresh();
                setState(() {});
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                border: InputBorder.none,
                // hintText: '搜索应用',
                hintStyle: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 28.sp,
                ),
              ),
            ).expand(),
          ],
        )
            .box
            .color(Color(0xFFF3F3F3))
            .withRounded(value: 36.w)
            .height(72.w)
            .alignment(Alignment.center)
            .make(),
      ),
      body: EasyRefresh(
        controller: _refreshController,
        firstRefresh: false,
        header: MaterialHeader(),
        onRefresh: () async {
          BaseModel baseModel = await NetUtil().get(API.search.homeSearch,
              params: {"searchName": _textEditingController.text});
          if (baseModel.success && baseModel.data != null) {
            _searchModel = SearchModel.fromJson(baseModel.data);
          }
          setState(() {});
        },
        child: CustomScrollView(
          slivers: [
            32.hb.sliverBoxAdapter(),
            _renderSearchResultBox(
              '应用',
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children:
                    _searchAppObjects.map((e) => _buildColumnIcon(e)).toList(),
              ),
              visible: _searchAppObjects.isNotEmpty,
            ),
            32.hb.sliverBoxAdapter(),
            _renderSearchResultBox('社区活动',
                child: GridView.count(
                  crossAxisCount: 1,
                  shrinkWrap: true,
                  childAspectRatio: 4 / 1,
                  mainAxisSpacing: 20.w,
                  physics: NeverScrollableScrollPhysics(),
                  children: _getNullSafeObjects(_searchModel.activityVoList)
                      .map((e) => _activityCardButton(e))
                      .toList(),
                ),
                visible: _searchModel.activityVoList.isNotEmpty),
            32.hb.sliverBoxAdapter(),
            _renderSearchResultBox(
              '话题',
              child: GridView.count(
                crossAxisCount: 1,
                shrinkWrap: true,
                childAspectRatio: 4 / 1,
                mainAxisSpacing: 20.w,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ..._getNullSafeObjects(_searchModel.gambitVoList)
                      .map((e) => _communityCardButton(e))
                      .toList()
                ],
              ),
              visible: _searchModel.gambitVoList.isNotEmpty,
            ),
          ],
        ),
      ),
    );
  }
}
