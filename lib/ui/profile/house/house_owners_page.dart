import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/ui/profile/house/add_house_page.dart';
import 'package:akuCommunity/utils/network/base_list_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class HouseOwnersPage extends StatefulWidget {
  HouseOwnersPage({Key key}) : super(key: key);

  @override
  _HouseOwnersPageState createState() => _HouseOwnersPageState();
}

class _HouseOwnersPageState extends State<HouseOwnersPage> {
  EasyRefreshController _refreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return BeeScaffold(
      title: '我的房屋',
      actions: [],
      body: EasyRefresh(
        header: MaterialHeader(),
        controller: _refreshController,
        firstRefresh: true,
        onRefresh: () async {
          await _getFirstHouse();
        },
        child: SizedBox(
          height: media.size.height - media.padding.top - 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 75.w),
                child: Image.asset(R.ASSETS_STATIC_REVIEWING_WEBP),
              ),
              ElevatedButton(
                onPressed: _addHouse,
                child: Text('添加房屋'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addHouse() async {
    await Get.to(() => AddHousePage());
  }

  Future _getFirstHouse() async {
    BaseListModel model = await NetUtil().getList(
      API.user.houseList,
      params: {'pageNum': 1, 'size': 1},
    );
    print(model.tableList);
  }
}
