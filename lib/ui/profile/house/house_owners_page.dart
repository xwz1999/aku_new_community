import 'package:akuCommunity/ui/profile/house/add_house_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HouseOwnersPage extends StatefulWidget {
  HouseOwnersPage({Key key}) : super(key: key);

  @override
  _HouseOwnersPageState createState() => _HouseOwnersPageState();
}

class _HouseOwnersPageState extends State<HouseOwnersPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的房屋',
      body: Column(
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
    );
  }

  _addHouse() async {
    await Get.to(() => AddHousePage());
  }
}
