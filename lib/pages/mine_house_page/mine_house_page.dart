import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class MineHousePage extends StatefulWidget {
  MineHousePage({Key key}) : super(key: key);

  @override
  _MineHousePageState createState() => _MineHousePageState();
}

class _MineHousePageState extends State<MineHousePage> {
  List<Map<String, dynamic>> _listHouse = [
    {'title': '深圳华茂悦峰', 'subtitle': '1幢-1单元-702室'},
  ];

  Widget _containerHouseCard(String title, subtitle) {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(24),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: Screenutil.length(41),
          bottom: Screenutil.length(41),
          left: Screenutil.length(27),
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
              height: Screenutil.length(48),
              width: Screenutil.length(48),
            ),
            SizedBox(width: Screenutil.length(20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Screenutil.size(32),
                    color: Color(0xff474747),
                  ),
                ),
                SizedBox(height: Screenutil.length(10)),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: Screenutil.size(32),
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

  Widget _inkWellCheck() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
            context, PageName.house_authenticate_page.toString());
      },
      child: Container(
        padding: EdgeInsets.only(
          top: Screenutil.length(11),
          bottom: Screenutil.length(10),
        ),
        alignment: Alignment.center,
        width: Screenutil.length(167),
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
          '去认证',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Screenutil.size(32),
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  Widget _containerAttestation() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsImage.HOUSEHEADER,
            height: Screenutil.length(124),
            width: Screenutil.length(124),
          ),
          SizedBox(height: Screenutil.length(24)),
          Text(
            '马泽鹏',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Screenutil.size(32),
              color: Color(0xff474747),
            ),
          ),
          SizedBox(height: Screenutil.length(8)),
          Text(
            '经过产权人审核成为住户，开启更多功能',
            style: TextStyle(
              fontSize: Screenutil.size(24),
              color: Color(0xff999999),
            ),
          ),
          SizedBox(height: Screenutil.length(39)),
          _inkWellCheck(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '我的房屋',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Column(
              children: _listHouse
                  .map((item) => _containerHouseCard(
                        item['title'],
                        item['subtitle'],
                      ))
                  .toList(),
            ),
            SizedBox(height: Screenutil.length(156)),
            _containerAttestation(),
          ],
        ),
      ),
    );
  }
}
