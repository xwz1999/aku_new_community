import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/ui/profile/house/house_card.dart';
import 'package:akuCommunity/ui/profile/house/house_func.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/ui/profile/house/add_house_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:provider/provider.dart';

class HouseOwnersPage extends StatefulWidget {
  HouseOwnersPage({Key key}) : super(key: key);

  @override
  _HouseOwnersPageState createState() => _HouseOwnersPageState();
}

class _HouseOwnersPageState extends State<HouseOwnersPage> {
  EasyRefreshController _refreshController = EasyRefreshController();

  bool get _emptyHouse {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return appProvider.houses.isEmpty;
  }

  ///存在已认证的房屋
  bool get _haveAuthedHouse {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return (appProvider?.selectedHouse?.status ?? 0) == 4;
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '我的房屋',
      actions: [
        TextButton(
          onPressed: _addHouse,
          child: Text('新增房屋'),
        ),
      ],
      body: EasyRefresh(
        header: MaterialHeader(),
        controller: _refreshController,
        firstRefresh: true,
        onRefresh: () async {
          appProvider.updateHouses(await HouseFunc.houses);
        },
        child: ListView(
          children: [
            _emptyHouse
                ? 280.hb
                : Padding(
                    padding: EdgeInsets.all(32.w),
                    child: HouseCard(
                      type: appProvider.selectedHouse.reviewed
                          ? CardAuthType.SUCCESS
                          : CardAuthType.FAIL,
                      model: appProvider.selectedHouse,
                    ),
                  ),
            if (!_emptyHouse) 88.hb,
            if (!_haveAuthedHouse)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 75.w),
                child: Image.asset(R.ASSETS_STATIC_REVIEWING_WEBP),
              ),
            if (!_haveAuthedHouse)
              Center(
                child: ElevatedButton(
                  onPressed: _addHouse,
                  child: Text('添加房屋'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  ///跳转到添加房屋
  _addHouse() async {
    bool result = await Get.to(() => AddHousePage());
    if (result == true) _refreshController.callRefresh();
  }
}
