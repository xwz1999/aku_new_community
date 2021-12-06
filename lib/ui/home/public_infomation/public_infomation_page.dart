import 'package:aku_new_community/models/news/news_category_model.dart';
import 'package:aku_new_community/ui/home/public_infomation/public_infomation_view.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/material.dart';

class PublicInfomationPage extends StatefulWidget {
  final List<NewsCategoryModel> models;

  PublicInfomationPage({
    Key? key,
    required this.models,
  }) : super(key: key);

  @override
  _PublicInfomationPageState createState() => _PublicInfomationPageState();
}

class _PublicInfomationPageState extends State<PublicInfomationPage>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.models.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '公共资讯',
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: widget.models.map((e) => e.name).toList(),
        scrollable: true,
      ),
      body: TabBarView(
        children:
            widget.models.map((e) => PublicInfomationView(model: e)).toList(),
        controller: _tabController,
      ),
    );
  }
}
