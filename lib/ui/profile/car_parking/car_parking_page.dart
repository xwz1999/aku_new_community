import 'package:akuCommunity/ui/profile/car_parking/car_parking_card.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CarParkingPage extends StatefulWidget {
  CarParkingPage({Key key}) : super(key: key);

  @override
  _CarParkingPageState createState() => _CarParkingPageState();
}

class _CarParkingPageState extends State<CarParkingPage> {
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
              '还没有车位',
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
    return BeeScaffold(
      title: '我的车位',
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('管理车位'),
        ),
      ],
      body: EasyRefresh(
        onRefresh: () async {},
        header: MaterialHeader(),
        // emptyWidget: _renderEmptyWidget,
        child: ListView.separated(
          separatorBuilder: (context, index) => 32.hb,
          itemBuilder: (context, index) {
            return CarparkingCard(outdated: false);
          },
          padding: EdgeInsets.all(32.w),
          itemCount: 2,
        ),
      ),
    );
  }
}
