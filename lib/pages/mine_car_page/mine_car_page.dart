import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class MineCarPage extends StatefulWidget {
  final Bundle bundle;
  MineCarPage({Key key, this.bundle}) : super(key: key);

  @override
  _MineCarPageState createState() => _MineCarPageState();
}

class _MineCarPageState extends State<MineCarPage> {
  List<Map<String, dynamic>> _listHouse = [
    {'title': '深圳华茂悦峰', 'subtitle': '1幢-1单元-702室'},
  ];

  List<Map<String, dynamic>> _listCart = [
    {'title': '浙BZ3183', 'isDelete': true},
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

  Widget _inkWellCheck(String type) {
    return InkWell(
      onTap: () {
        switch (type) {
          case '车':
            Navigator.pushNamed(context, PageName.car_add_page.toString());
            break;
          case '车位':
            Navigator.pushNamed(
                context, PageName.select_community_page.toString());
            break;
          default:
        }
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
          '去添加',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Screenutil.size(32),
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }

  Widget _containerAttestation(String tag) {
    return Container(
      margin: EdgeInsets.only(top: Screenutil.length(156)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsImage.CARHEADER,
            height: Screenutil.length(240),
            width: Screenutil.length(130),
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
            '尊敬的业主/租客，您还没有添加您的${tag}',
            style: TextStyle(
              fontSize: Screenutil.size(24),
              color: Color(0xff999999),
            ),
          ),
          SizedBox(height: Screenutil.length(39)),
          _inkWellCheck(widget.bundle.getMap('carType')['type']),
        ],
      ),
    );
  }

  Widget _containerInfoCard(String title, bool isDelete) {
    return Container(
      margin: EdgeInsets.only(
        left: Screenutil.length(32),
        top: Screenutil.length(26),
        right: Screenutil.length(32),
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: Screenutil.length(40),
          right: Screenutil.length(26),
          top: Screenutil.length(26),
          bottom: Screenutil.length(25),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: Color(0xffeeeeee), width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Screenutil.size(32),
                color: Color(0xff333333),
              ),
            ),
            isDelete
                ? InkWell(
                    child: Text(
                      '移除',
                      style: TextStyle(
                        fontSize: Screenutil.size(28),
                        color: Color(0xff999999),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _positionedBottomBar(String buttonName) {
    return Positioned(
      bottom: 0,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(
            top: Screenutil.length(23),
            bottom: Screenutil.length(22),
          ),
          color: Color(0xffffd000),
          alignment: Alignment.center,
          height: Screenutil.length(85),
          width: MediaQuery.of(context).size.width,
          child: Text(
            buttonName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Screenutil.size(28),
              color: Color(0xff333333),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '我的${widget.bundle.getMap('carType')['type']}',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: Screenutil.length(85)),
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
                      // Container(
                      //   margin: EdgeInsets.only(top: Screenutil.length(64)),
                      //   child: Column(
                      //     children: _listCart
                      //         .map((item) => _containerInfoCard(
                      //               item['title'],
                      //               item['isDelete'],
                      //             ))
                      //         .toList(),
                      //   ),
                      // ),
                      _containerAttestation(
                          widget.bundle.getMap('carType')['type']),
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
