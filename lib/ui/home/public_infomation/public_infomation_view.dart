import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/models/news/news_category_model.dart';
import 'package:aku_new_community/models/news/news_item_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/home/public_infomation/public_infomation_card.dart';
import 'package:aku_new_community/utils/headers.dart';

class PublicInfomationView extends StatefulWidget {
  final NewsCategoryModel model;

  PublicInfomationView({Key? key, required this.model}) : super(key: key);

  @override
  _PublicInfomationViewState createState() => _PublicInfomationViewState();
}

class _PublicInfomationViewState extends State<PublicInfomationView>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeListView(
      path: API.news.list,
      controller: _refreshController,
      extraParams: {'newsCategoryId': widget.model.id},
      convert: (model) =>
          model.rows.map((e) => NewsItemModel.fromJson(e)).toList(),
      builder: (items) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 24.w),
          itemBuilder: (context, index) {
            return PublicInfomationCard(model: items[index]);
          },
          separatorBuilder: (_, __) => 24.hb,
          itemCount: items.length,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
