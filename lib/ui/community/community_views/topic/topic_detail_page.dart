import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/community/all_dynamic_list_model.dart';
import 'package:aku_new_community/models/community/top_detail_model.dart';
import 'package:aku_new_community/ui/community/community_views/add_new_event_page.dart';
import 'package:aku_new_community/ui/community/community_views/topic/topic_sliver_header.dart';
import 'package:aku_new_community/ui/community/community_views/widgets/chat_card.dart';
import 'package:aku_new_community/utils/login_util.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class TopicDetailPage extends StatefulWidget {
  final int? topicId;

  TopicDetailPage({Key? key, this.topicId}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  TopDetailModel? _detailModel;
  List<AllDynamicListModel> _dynamicList = [];
  bool _onLoad = true;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  int _page = 1;
  int _currentIndex = 0;
  List<String> _tabs = ['最新', '最热'];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemStyle.initial,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: 'event_add',
          onPressed: () async {
            if (LoginUtil.isNotLogin) return;
            await Get.to(() => AddNewEventPage.topic(
                  topicName: _detailModel?.title,
                  initTopic: widget.topicId,
                ));
          },
          child: Icon(Icons.add),
        ),
        body: EasyRefresh.custom(
            firstRefresh: true,
            controller: _refreshController,
            header: MaterialHeader(),
            footer: MaterialFooter(),
            onRefresh: () async {
              _page = 1;
              var res = await NetUtil().get(SAASAPI.community.topicDetail,
                  params: {'topicId': widget.topicId});
              if (res.success) {
                _detailModel = TopDetailModel.fromJson(res.data);
              }
              var baseList = await NetUtil()
                  .getList(SAASAPI.community.dynamicList, params: {
                'pageNum': _page,
                'size': 4,
                'topicId': widget.topicId,
                'type': _currentIndex + 1
              });
              _dynamicList = baseList.rows
                  .map((e) => AllDynamicListModel.fromJson(e))
                  .toList();
              _onLoad = false;
              setState(() {});
            },
            onLoad: () async {
              _page++;
              BaseListModel baseList = await NetUtil()
                  .getList(SAASAPI.community.dynamicList, params: {
                'pageNum': _page,
                'size': 4,
                'topicId': widget.topicId,
                'type': 1
              });
              if (_dynamicList.length < baseList.total) {
                _dynamicList.addAll(baseList.rows
                    .map((e) => AllDynamicListModel.fromJson(e))
                    .toList());
              }
            },
            slivers: _onLoad
                ? []
                : [
                    SliverPersistentHeader(
                      delegate: TopicSliverHeader(
                        id: widget.topicId,
                        title: _detailModel?.title,
                        imgPath: ImgModel.first(_detailModel?.imgList),
                        subTitle: _detailModel?.content,
                        dynamicNum: _detailModel?.dynamicNum,
                        commentNum: _detailModel?.commentNum,
                      ),
                      pinned: true,
                      floating: true,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: double.infinity,
                        height: 100.w,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.w, horizontal: 32.w),
                        child: Row(
                          children: [
                            ..._tabs
                                .mapIndexed((e, index) => _tab(e, index))
                                .toList()
                                .sepWidget(separate: 40.w.widthBox),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 20.w),
                            child: ChatCard(
                              model: _dynamicList[index],
                              refresh: () {
                                _refreshController.callRefresh();
                              },
                            ),
                          );
                        },
                        childCount: _dynamicList.length,
                      ),
                    ),
                  ]),
      ),
    );
  }

  Widget _tab(String text, int index) {
    var select = _currentIndex == index;
    return GestureDetector(
      onTap: () async {
        _currentIndex = index;
        _refreshController.callRefresh();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text.text
              .color(Colors.black)
              .fontWeight(select ? FontWeight.bold : FontWeight.normal)
              .size(30.sp)
              .make(),
          8.w.heightBox,
          !select
              ? SizedBox(
                  height: 4.w,
                )
              : Container(
                  width: 40.w,
                  height: 4.w,
                  color: Color(0xFFB634).withOpacity(0.8),
                ),
        ],
      ),
    );
  }
}
