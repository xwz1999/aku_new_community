import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/goods_deto_page/deto_create_page/widget/common_radio.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/bee_parse.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:provider/provider.dart';

class MyHousePage extends StatefulWidget {
  MyHousePage({Key key}) : super(key: key);

  @override
  _MyHousePageState createState() => _MyHousePageState();
}

Widget _currentHouseTag() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.w),
    constraints: BoxConstraints(minWidth: 120.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.w),
        color: Color(0xFFFFF4D3),
        border: Border.all(width: 2.w, color: Color(0xFFFFC40C))),
    child: '当前房屋'.text.color(ktextPrimary).size(20.sp).make(),
  );
}

Widget _unPaidTag() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.w),
    constraints: BoxConstraints(minWidth: 120.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.w),
        color: Color(0xFFFFEBE8),
        border: Border.all(width: 2.w, color: Color(0xFFFC361D))),
    child: '当前房屋'.text.color(Color(0xFFFC361D)).size(20.sp).make(),
  );
}

class _MyHousePageState extends State<MyHousePage> {
  int _select;
  Widget _buildCard(String currentHouse, String estateName, int index,
      {bool paid = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _select = index;
              setState(() {});
            },
            child: CommonRadio(
              value: index,
              groupValue: _select,
              size: 32.w,
            ),
          ),
          24.w.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              kEstateName.text.size(24.sp).color(ktextSubColor).bold.make(),
              16.w.heightBox,
              BeeParse.getEstateName(estateName).text.color(ktextPrimary).size(28.sp).bold.make(),
            ],
          ),
          Spacer(),
          currentHouse == estateName
              ? _currentHouseTag()
              : paid
                  ? _unPaidTag()
                  : SizedBox()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return BeeScaffold(
      title: '我的房屋',
      body: ListView(
        children: <Widget>[
          ...userProvider.userDetailModel.estateNames
              .map((e) => _buildCard(userProvider.currentHouse, e,
                  userProvider.userDetailModel.estateNames.indexOf(e)))
              .toList(),
        ].sepWidget(separate: BeeDivider.horizontal()),
      ),
    );
  }
}
