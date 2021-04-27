import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/ui/profile/house/add_house_page.dart';
import 'package:aku_community/ui/profile/house/house_card.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class HouseOwnersPage extends StatefulWidget {
  HouseOwnersPage({Key? key}) : super(key: key);

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
    return (appProvider.selectedHouse?.status ?? 0) == 4;
  }

  Widget get _houseTitle {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    if (_emptyHouse) return Text('还没有绑定房屋');
    if (appProvider.selectedHouse!.status == 1) return Text('您的身份正在审核中，请耐心等待');
    if (appProvider.selectedHouse!.status == 3) return Text('审核未通过');
    return SizedBox();
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
                      type: appProvider.selectedHouse!.reviewed
                          ? CardAuthType.SUCCESS
                          : CardAuthType.FAIL,
                      model: appProvider.selectedHouse,
                    ),
                  ),
            if (!_emptyHouse) 88.hb,
            if (!_haveAuthedHouse)
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 75.w),
                    child: Image.asset(R.ASSETS_STATIC_REVIEWING_WEBP),
                  ),
                  Positioned(
                    bottom: 100.w,
                    left: 0,
                    right: 0,
                    child: _houseTitle.centered(),
                  ),
                ],
              ),
            if (_emptyHouse)
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
    bool? result = await Get.to(() => AddHousePage());
    if (result == true) _refreshController.callRefresh();
  }
}
