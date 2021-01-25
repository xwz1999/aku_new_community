import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/suggestion_or_complain_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/ui/manager/advice/advice_card.dart';
import 'package:akuCommunity/ui/manager/advice/new_advice_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/buttons/bottom_button.dart';
import 'package:akuCommunity/widget/tab_bar/bee_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

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
    return 0;
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
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
                itemBuilder: (context, index) {
                  return AdviceCard(model: items[index]);
                },
                separatorBuilder: (_, __) => 20.hb,
                itemCount: items.length,
              );
            },
          );
        }).toList(),
      ),
      bottomNavi: BottomButton(
        onPressed: () async {
          bool needRefresh = await Get.to(NewAdvicePage(type: widget.type));
          if (needRefresh == true) {
            _refreshController.callRefresh();
            Get.dialog(CupertinoAlertDialog(
              title: '您的信息已提交，我们会尽快回复您，祝您生活愉快'.text.isIntrinsic.make(),
              actions: [
                CupertinoDialogAction(
                  child: '确定'.text.color(Color(0xFFFF8200)).isIntrinsic.make(),
                  onPressed: Get.back,
                ),
              ],
            ));
          }
        },
        child: Text('新增'),
      ),
    );
  }
}
