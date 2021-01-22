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

enum _adviceInnerType {
  SUGGESTION,
  QUESTION,
  COMPLAIN,
  PRAISE,
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

  String get title {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return '建议咨询';
        break;
      case AdviceType.COMPLAIN:
        return '投诉表扬';
        break;
    }
    return '';
  }

  List<String> get tabs {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return ['您的建议', '您的咨询'];
        break;
      case AdviceType.COMPLAIN:
        return ['您的投诉', '您的表扬'];
        break;
    }
    return [];
  }

  int adviceValue(int index) {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return index == 0 ? 2 : 1;
        break;
      case AdviceType.COMPLAIN:
        return index == 0 ? 4 : 3;
        break;
    }
  }

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
      title: title,
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: tabs,
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(2, (index) {
          return BeeListView(
            path: API.manager.advice,
            extraParams: {'adviceType': adviceValue(index)},
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
