import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class OneAlarmPage extends StatefulWidget {
  OneAlarmPage({Key key}) : super(key: key);

  @override
  _OneAlarmPageState createState() => _OneAlarmPageState();
}

class _OneAlarmPageState extends State<OneAlarmPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '一键报警',
          subtitle: '功能说明',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: Screenutil.length(271),
            minHeight: Screenutil.length(271),
            parallaxOffset: .5,
            panelSnapping: false,
            body: _body(),
            panelBuilder: (sc) => _panel(sc),
          ),
          Positioned(
            right: Screenutil.length(34),
            bottom: Screenutil.length(304),
            child: InkWell(
              child: Container(
                height: Screenutil.length(66),
                width: Screenutil.length(66),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Screenutil.length(66)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color(0xff000000).withOpacity(0.12),
                        offset: Offset(1, 1))
                  ],
                ),
                child: Icon(
                  Icons.gps_fixed,
                  size: Screenutil.length(44),
                  color: Color(0xff666666),
                ),
              ),
            ),
          ),
          Positioned(
            top: Screenutil.length(32),
            child: Container(
              width: Screenutil.length(686),
              padding: EdgeInsets.only(
                top: Screenutil.length(24),
                bottom: Screenutil.length(24),
                left: Screenutil.length(32),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xff5C5959).withOpacity(0.2),
                      offset: Offset(1, 1))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "当前位置（仅供参考）",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff333333),
                      fontSize: Screenutil.size(28),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Screenutil.length(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Entypo.location_pin,
                          color: Color(0xff666666),
                          size: Screenutil.size(28),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: Screenutil.length(10)),
                          child: Text(
                            "广东省深圳市龙岗区吉信街22-1附近",
                            style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: Screenutil.size(28),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          ListView(
            controller: sc,
            children: [
              Container(
                margin: EdgeInsets.only(top: Screenutil.length(146)),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  '谎报警情，依法追责',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Screenutil.size(32),
                    color: Color(0xffe02020),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Screenutil.length(8)),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  '谎报警情将可能被处以五日以上十日以下拘留',
                  style: TextStyle(
                    fontSize: Screenutil.size(24),
                    color: Color(0xff999999),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: -Screenutil.length(98),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(Screenutil.length(12)),
                height: Screenutil.length(196),
                width: Screenutil.length(196),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Screenutil.length(196))),
                ),
                child: Container(
                  height: Screenutil.length(172),
                  width: Screenutil.length(172),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topLeft,
                      colors: [Color(0xffef0909), Color(0xffff8880)],
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(Screenutil.length(172))),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color(0xfffd7770).withOpacity(0.33),
                        offset: Offset(0, Screenutil.length(10)),
                        blurRadius: Screenutil.length(20),
                        spreadRadius: Screenutil.length(4),
                      )
                    ],
                  ),
                  child: Icon(
                    Feather.phone_call,
                    color: Colors.white,
                    size: Screenutil.size(87),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _body() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(22.3817, 114.05),
        zoom: 13,
        maxZoom: 15,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "http://map.geoq.cn/ArcGIS/rest/services/ChinaOnlineCommunity/MapServer/tile/{z}/{y}/{x}",
        ),
        MarkerLayerOptions(markers: [
          Marker(
              point: LatLng(22.3817, 114.05),
              builder: (ctx) => Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 48.0,
                  ),
              height: 60),
        ]),
      ],
    );
  }
}
