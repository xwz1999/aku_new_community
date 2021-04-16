import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/user/house_model.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/ui/profile/house/add_house_page.dart';
import 'package:akuCommunity/ui/profile/house/house_func.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class PickMyHousePage extends StatefulWidget {
  PickMyHousePage({Key key}) : super(key: key);

  @override
  _PickMyHousePageState createState() => _PickMyHousePageState();
}

class _PickMyHousePageState extends State<PickMyHousePage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  _renderTitle(String title) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
      sliver: SliverToBoxAdapter(
        child: Text(title, style: Theme.of(context).textTheme.subtitle2),
      ),
    );
  }

  Widget get _renderSep => SliverToBoxAdapter(child: 24.hb);

  List<HouseModel> get housesWithoutSelected {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    List<HouseModel> models = List.from(appProvider.houses);
    models.removeWhere(
      (element) => element.id == (appProvider?.selectedHouse?.id ?? -1),
    );
    if (models == null || models.isEmpty) return [];
    return models;
  }

  _renderList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        housesWithoutSelected
            .map((e) => _HouseCard(
                  model: e,
                  controller: _refreshController,
                ))
            .toList()
            .sepWidget(
                separate: Divider(
              height: 1.w,
              indent: 32.w,
              endIndent: 32.w,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '我的房屋',
      body: EasyRefresh(
        header: MaterialHeader(),
        controller: _refreshController,
        onRefresh: () async {
          final appProvider = Provider.of<AppProvider>(context, listen: false);
          appProvider.updateHouses(await HouseFunc.houses);
        },
        firstRefresh: true,
        child: CustomScrollView(
          slivers: [
            _renderSep,
            _renderTitle('当前房屋'),
            SliverToBoxAdapter(
              child: _HouseCard(
                model: appProvider.selectedHouse,
                highlight: true,
                controller: _refreshController,
              ),
            ),
            _renderSep,
            if (housesWithoutSelected.isNotEmpty) _renderTitle('其他房屋'),
            if (housesWithoutSelected.isNotEmpty) _renderList(),
          ],
        ),
      ).material(color: Colors.white),
      bottomNavi: ElevatedButton(
        child: Text('新增房屋'),
        onPressed: () async {
          bool result = await Get.to(() => AddHousePage());
          if (result == true) _refreshController.callRefresh();
        },
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 26.w)),
        ),
      ),
    );
  }
}

class _HouseCard extends StatelessWidget {
  final HouseModel model;
  final bool highlight;
  final EasyRefreshController controller;
  const _HouseCard({
    Key key,
    @required this.model,
    this.highlight = false,
    @required this.controller,
  }) : super(key: key);
  bool get canTapSlide {
    if (model == null) return false;
    return model.status == 4 || model.status == 3 && !highlight;
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) return SizedBox();
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      secondaryActions: [
        SlideAction(
          onTap: canTapSlide
              ? () async {
                  bool result = await Get.dialog(CupertinoAlertDialog(
                    title: Text('删除房屋'),
                    content: Text('删除房屋后，可以再次验证添加'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('取消'),
                        onPressed: () => Get.back(),
                      ),
                      CupertinoDialogAction(
                        child: Text('确认'),
                        onPressed: () => Get.back(result: true),
                      ),
                    ],
                  ));
                  if (result == true) {
                    final cancel = BotToast.showLoading();
                    await NetUtil().post(
                      API.user.deleteHouse,
                      params: {
                        'ids': [model.id]
                      },
                    );
                    // if(controller.)
                    controller.callRefresh();
                    cancel();
                  }
                }
              : null,
          closeOnTap: canTapSlide,
          child: Text(
            '删除',
            style: TextStyle(
              color: canTapSlide ? Colors.white : Color(0xFF999999),
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: canTapSlide ? Color(0xFFFD4912) : Color(0xFFE8E8E8),
        ),
      ],
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        height: 136.w,
        child: Row(
          children: [
            Container(
              child: Text(
                model?.houseStatus ?? '',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: model?.houseStatusColor ?? Colors.white,
                    ),
              ),
              alignment: Alignment.center,
              height: 88.w,
              width: 88.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                gradient: LinearGradient(
                  colors: model.backgroundColor,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            24.wb,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).tempPlotName,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color:
                              highlight ? Color(0xFFFF8200) : Color(0xFF333333),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  8.hb,
                  Text(
                    model.roomName,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: Color(0xFF999999),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () async {
          final appProvider = Provider.of<AppProvider>(context, listen: false);
          appProvider.setCurrentHouse(model);
          //我的房屋：修改选中的房产审核id
          await NetUtil().get(API.user.changeSelectExanmineId,params: {"examineId":model.estateId});
          Get.back();
        },
      ),
    );
  }
}
