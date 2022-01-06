import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/models/electronic_commerc/electronic_commerc_category_model.dart';
import 'package:aku_new_community/pages/electronic_commerc/electronic_commerc_view.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/utils/websocket/tips_dialog.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/tab_bar/bee_tab_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class ElectronicCommercPage extends StatefulWidget {
  ElectronicCommercPage({Key? key}) : super(key: key);

  @override
  _ElectronicCommercPageState createState() => _ElectronicCommercPageState();
}

class _ElectronicCommercPageState extends State<ElectronicCommercPage>
    with TickerProviderStateMixin {
  List<String> _tabs = [''];
  late TabController _tabController;
  bool _onloading = true;
  late List<ElectronicCommercCategoryModel> _models;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () async {
      var agreement =
          await HiveStore.appBox?.get('ElectronicCommercPage') ?? false;
      if (!agreement) {
        await TipsDialog.tipsDialog();
        HiveStore.appBox!.put('ElectronicCommercPage', true);
      }
    });
    _tabController = TabController(length: _tabs.length, vsync: this);
    Future.delayed(
        Duration(
          milliseconds: 0,
        ), () async {
      final cancel = BotToast.showLoading();
      BaseModel baseModel =
          await NetUtil().get(API.manager.electronicCommercCategory);
      if (baseModel.success == true && baseModel.data != null) {
        _models = (baseModel.data as List)
            .map((e) => ElectronicCommercCategoryModel.fromJson(e))
            .toList();
        cancel();
        _tabs = List.generate(_models.length, (index) => _models[index].name);
        _onloading = false;
        _tabController = TabController(length: _tabs.length, vsync: this);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '电子商务',
      appBarBottom: BeeTabBar(
        controller: _tabController,
        tabs: _tabs,
        scrollable: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          _tabs.length,
          (index) => _onloading
              ? ListView(
                  children: [SizedBox()],
                )
              : ElectronicCommercView(
                  id: _models[index].id,
                ),
        ),
      ),
    );
  }

  _buildShimmer() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.white10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VxBox().height(53.w).width(152.w).color(Colors.white).make(),
                30.hb,
                VxBox().height(40.w).width(600.w).color(Colors.white).make(),
                24.hb,
                VxBox().height(33.w).width(263.w).color(Colors.white).make(),
                50.hb,
                VxBox().height(53.w).width(152.w).color(Colors.white).make(),
                30.hb,
                VxBox().height(40.w).width(600.w).color(Colors.white).make(),
                24.hb,
                VxBox().height(33.w).width(263.w).color(Colors.white).make(),
              ],
            ).expand(),
          ),
          Divider(
            height: 50.w,
            thickness: 1.w,
            color: Color(0xFFD8D8D8),
          ),
          GridView.count(
            crossAxisCount: 2,
            children: [
              VxBox().height(53.w).width(53.w).color(Colors.white).make(),
              VxBox().height(53.w).width(53.w).color(Colors.white).make(),
              VxBox().height(53.w).width(53.w).color(Colors.white).make(),
              VxBox().height(53.w).width(53.w).color(Colors.white).make(),
            ],
          )
        ],
      ),
    );
  }
}
