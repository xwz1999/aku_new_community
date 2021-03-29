import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/ui/profile/car/car_manage_card.dart';
import 'package:akuCommunity/ui/profile/car_parking/car_parking_card.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

class CarManagePage extends StatefulWidget {
  CarManagePage({Key key}) : super(key: key);

  @override
  _CarManagePageState createState() => _CarManagePageState();
}

class _CarManagePageState extends State<CarManagePage> {
  Widget get _renderEmptyWidget {
    return Center(
      child: Stack(
        children: [
          Image.asset(R.ASSETS_STATIC_REVIEWING_WEBP).pSymmetric(h: 75.w),
          Positioned(
            bottom: 100.w,
            left: 0,
            right: 0,
            child: Text(
              '还没有车辆',
              style: TextStyle(
                color: Color(0xFF999999),
              ),
            ).centered(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '我的车辆',
      actions: [
        // TextButton(
        //   onPressed: () {},
        //   child: Text('管理车位'),
        // ),
      ],
      body: EasyRefresh(
        firstRefresh: true,
        onRefresh: () async {
          await appProvider.updateCarModels();
        },
        header: MaterialHeader(),
        emptyWidget: appProvider.carModels.isEmpty ? _renderEmptyWidget : null,
        child: ListView.separated(
          separatorBuilder: (context, index) => 32.hb,
          itemBuilder: (context, index) {
            return CarManageCard(model: appProvider.carModels[index]);
          },
          padding: EdgeInsets.all(32.w),
          itemCount: appProvider.carModels.length,
        ),
      ),
    );
  }
}
