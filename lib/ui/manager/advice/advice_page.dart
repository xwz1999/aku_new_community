import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'package:aku_new_community/constants/app_theme.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/manager/suggestion_or_complain_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/manager/advice/advice_card.dart';
import 'package:aku_new_community/ui/manager/advice/new_advice_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/animated/animated_transition.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/buttons/radio_button.dart';
import 'package:aku_new_community/widget/tab_bar/bee_tab_bar.dart';

enum AdviceType {
  SUGGESTION,
  COMPLAIN,
}

class AdvicePage extends StatefulWidget {
  final AdviceType type;

  AdvicePage({Key? key, required this.type}) : super(key: key);

  @override
  _AdvicePageState createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> with TickerProviderStateMixin {
  EasyRefreshController _refreshController = EasyRefreshController();
  TabController? _tabController;
  bool _selectedMode = false;

  List<int?> _selectedItems = [];

  String get title {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return '建议咨询';
      case AdviceType.COMPLAIN:
        return '投诉表扬';
    }
  }

  List<String> get tabs {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return ['您的建议', '您的咨询'];
      case AdviceType.COMPLAIN:
        return ['您的投诉', '您的表扬'];
    }
  }

  int adviceValue(int index) {
    switch (widget.type) {
      case AdviceType.SUGGESTION:
        return index == 0 ? 2 : 1;
      case AdviceType.COMPLAIN:
        return index == 0 ? 3 : 4;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () async {
      var agreement = await HiveStore.appBox?.get('AdvicePage') ?? false;
      if (!agreement) {
        //await TipsDialog.tipsDialog();
        HiveStore.appBox!.put('AdvicePage', true);
      }
    });
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
      systemStyle: SystemStyle.yellowBottomBar,
      actions: [
        TextButton(
          onPressed: () => setState(() => _selectedMode = !_selectedMode),
          child: (_selectedMode ? '完成' : '编辑').text.make(),
        ),
      ],
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: tabs,
        onTap: (index) {
          _selectedItems.clear();
        },
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(2, (index) {
          return BeeListView<SuggestionOrComplainModel>(
            path: SAASAPI.advice.list,
            extraParams: {'type': adviceValue(index)},
            controller: _refreshController,
            convert: (model) => model.rows
                .map((e) => SuggestionOrComplainModel.fromJson(e))
                .toList(),
            builder: (items) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_selectedItems.contains(items[index].id))
                                _selectedItems.remove(items[index].id);
                              else
                                _selectedItems.add(items[index].id);
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.topLeft,
                            child: BeeRadio(
                              value: items[index].id,
                              groupValues: _selectedItems,
                            ),
                          ),
                        ),
                      ),
                      AnimatedTranslate(
                        offset: _selectedMode ? Offset(60.w, 0) : Offset.zero,
                        child: AdviceCard(model: items[index]),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => 20.hb,
                itemCount: items.length,
              );
            },
          );
        }).toList(),
      ),
      bottomNavi: AnimatedCrossFade(
        crossFadeState: _selectedMode
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 300),
        firstChild: BottomButton(
          onPressed: () async {
            await NetUtil().post(
              SAASAPI.advice.delete,
              params: {'adviceIds': _selectedItems},
              showMessage: true,
            );
            _refreshController.callRefresh();
            setState(() => _selectedMode = false);
          },
          child: '删除'.text.make(),
        ),
        secondChild: BottomButton(
          onPressed: () async {
            bool? needRefresh = await Get.to(
              () => NewAdvicePage(
                type: widget.type,
                initType: _tabController!.index,
              ),
            );
            if (needRefresh == true) {
              _refreshController.callRefresh();
              Get.dialog(CupertinoAlertDialog(
                title: '您的信息已提交，我们会尽快回复您，祝您生活愉快'.text.isIntrinsic.make(),
                actions: [
                  CupertinoDialogAction(
                    child:
                        '确定'.text.color(Color(0xFFFF8200)).isIntrinsic.make(),
                    onPressed: Get.back,
                  ),
                ],
              ));
            }
          },
          child: Text('新增'),
        ),
      ),
    );
  }
}
