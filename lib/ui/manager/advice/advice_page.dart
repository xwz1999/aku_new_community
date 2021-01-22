import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/suggestion_or_complain_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

enum AdviceType {
  SUGGESTION,
  COMPLAIN,
}

class AdvicePage extends StatefulWidget {
  final AdviceType type;
  AdvicePage({Key key, @required this.type}) : super(key: key);

  @override
  _AdvicePageState createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> with TickerProviderStateMixin {
  EasyRefreshController _refreshController = EasyRefreshController();
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '建议咨询',
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: ['您的建议', '您的咨询'],
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(2, (index) {
          return BeeListView(
            path: API.manager.advice,
            extraParams: {'adviceType': index == 0 ? 2 : 1},
            controller: _refreshController,
            convert: (model) => model.tableList
                .map((e) => SuggestionOrComplainModel.fromJson(e))
                .toList(),
            builder: (items) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return SizedBox();
                },
                separatorBuilder: (_, __) => 20.hb,
                itemCount: items.length,
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
