import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/constants/application_objects.dart';
import 'package:aku_community/model/community/board_model.dart';
import 'package:aku_community/ui/community/notice/notice_card.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/base_list_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/views/application_box.dart';
import 'package:aku_community/widget/views/application_view.dart';
import 'widget/property_card.dart';

//TODO CLEAN BOTTOM CODES.
@Deprecated("sh*t property_index need to be cleaned.")
class PropertyIndex extends StatefulWidget {
  PropertyIndex({Key? key}) : super(key: key);

  @override
  _PropertyIndexState createState() => _PropertyIndexState();
}

//TODO CLEAN BOTTOM CODES.
@Deprecated("sh*t property_index need to be cleaned.")
class _PropertyIndexState extends State<PropertyIndex>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  EasyRefreshController _refreshController = EasyRefreshController();
  int _page = 1;
  int? _pageCount = 0;
  List<BoardItemModel> _models = [];
  Future<List<BoardItemModel>> _getItems() async {
    BaseListModel model = await NetUtil().getList(
      API.community.boardList,
      params: {
        'pageNum': _page,
        'size': 10,
      },
    );
    _pageCount = model.pageCount;
    return model.tableList!.map((e) => BoardItemModel.fromJson(e)).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeScaffold(
      title: '物业',
      body: EasyRefresh(
        controller: _refreshController,
        firstRefresh: true,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {
          _page = 1;
          _models = await _getItems();
          setState(() {});
        },
        onLoad: () async {
          _page++;
          _models.addAll(await _getItems());
          if (_page >= _pageCount!) _refreshController.finishLoad(noMore: true);
          setState(() {});
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ApplicationBox(
                child: ApplicationView.custom(items: smartManagerApp),
              ),
            ),
            SliverToBoxAdapter(
              child: PropertyCard(),
            ),
            // PropertyBar(
            //   title: '社区活动',
            //   subtitle: '精彩往期',
            //   more: '更多活动',
            //   fun: activityRouter,
            // ),
            // SliverToBoxAdapter(
            //   child: PropertyActivityCard(fun: activityDetailsRouter),
            // ),
            // PropertyBar(
            //   title: '社区公告',
            //   subtitle: '看看小区最近发生什么?',
            // ),
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => SizedBox(),
                itemCount: 3,
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                final BoardItemModel model = _models[index];
                BoardItemModel? preModel;
                if (index >= 1) preModel = _models[index - 1];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.w),
                  child: NoticeCard(model: model, preModel: preModel),
                );
              },
              childCount: _models.length,
            )),
          ],
        ),
      ),
    );
  }
}
