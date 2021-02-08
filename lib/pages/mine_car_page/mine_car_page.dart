// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/pages/mine_car_page/car_add_page/car_add_page.dart';
import 'package:akuCommunity/pages/mine_car_page/select_community_page/select_community_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class MineCarPage extends StatefulWidget {
  MineCarPage({Key key}) : super(key: key);

  @override
  _MineCarPageState createState() => _MineCarPageState();
}

class _MineCarPageState extends State<MineCarPage> {
  List<Map<String, dynamic>> _listHouse = [
    {'title': '深圳华茂悦峰', 'subtitle': '1幢-1单元-702室'},
  ];

  Widget _containerHouseCard(String title, subtitle) {
    return Container(
      margin: EdgeInsets.only(
        top: 24.w,
        left: 32.w,
        right: 32.w,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 41.w,
          bottom: 41.w,
          left: 27.w,
        ),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AssetsImage.HOUSEATTESTATION,
              height: 48.w,
              width: 48.w,
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: Color(0xff474747),
                  ),
                ),
                SizedBox(height: 10.w),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: Color(0xff474747),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _inkWellCheck(String type) {
    return InkWell(
      onTap: () {
        switch (type) {
          case '车':
            CarAddPage().to;
            break;
          case '车位':
            SelectCommunityPage().to;
            break;
          default:
        }
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 11.w,
          bottom: 10.w,
        ),
        alignment: Alignment.center,
        width: 167.w,
        decoration: BoxDecoration(
          color: Color(0xffffd000),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Text(
          '去添加',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  Widget _containerAttestation(String tag) {
    return Container(
      margin: EdgeInsets.only(top: 156.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsImage.CARHEADER,
            height: 240.w,
            width: 130.w,
          ),
          SizedBox(height: 24.w),
          Text(
            '马泽鹏',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.sp,
              color: Color(0xff474747),
            ),
          ),
          SizedBox(height: 8.w),
          Text(
            '尊敬的业主/租客，您还没有添加您的$tag',
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xff999999),
            ),
          ),
          SizedBox(height: 39.w),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的',
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 85.w),
                  child: Column(
                    children: [
                      Column(
                        children: _listHouse
                            .map((item) => _containerHouseCard(
                                  item['title'],
                                  item['subtitle'],
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // _positionedBottomBar(widget.buttonName),
          ],
        ),
      ),
    );
  }
}
