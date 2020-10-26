import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class PermissionUtil {
  static Future<bool> getLocationPermission() async {
    return await Permission.locationWhenInUse.request().isGranted;
  }
}

class AlarmPage extends StatefulWidget {
  AlarmPage({Key key, bundle}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final _option = MyLocationOption(
    show: true,
    myLocationType: MyLocationType.Locate,
  );
  Future<void> _makephonenum(String url)async{
    (await canLaunch(url))?await launch(url):throw 'Could not launch $url';
  }

  AmapController _amapController;
  Location _location;
  @override
  void initState() {
    super.initState();
    AmapLocation.instance.fetchLocation().then((location) {
      _location = location;
      setState(() {});
    });
    PermissionUtil.getLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();
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
        children: [
          AmapView(
            onMapCreated: (controller) async {
              _amapController = controller;
              await _amapController.showMyLocation(_option);
            },
            mapType: MapType.Standard,
            showZoomControl: false,
            zoomLevel: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(top: Screenutil.length(32)),
                  width: 686.w,
                  height: Screenutil.length(148),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xE8FFFFFF).withOpacity(0.10),
                            offset: Offset(0, 2)),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Screenutil.length(24)),
                      Container(
                        margin: EdgeInsets.only(
                            top: Screenutil.length(24),
                            left: Screenutil.length(32)),
                        child: Text(
                          '当前位置(仅供参考)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: Screenutil.size(28)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: Screenutil.length(20),
                            left: Screenutil.length(32)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Entypo.location_pin,
                              color: Color(0xff666666),
                              size: Screenutil.size(29),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: Screenutil.length(5)),
                              child: Text(
                                (_location == null)
                                    ? '加载中……'
                                    : _location.aoiName,
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
                  )),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: Screenutil.length(66),
                    height: Screenutil.length(66),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Screenutil.length(66)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(0x1F000000),
                            offset: Offset(3, 4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          )
                        ]),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Screenutil.length(66))),
                      color: Color(0xFFFFFFFF),
                      onPressed: () {
                        _amapController?.setCenterCoordinate(
                            _location.latLng);
                        Future.delayed(Duration(milliseconds: 500), () {
                          if (mounted) _amapController.setZoomLevel(16);
                        });
                      },
                      child: Icon(
                        Icons.location_searching,
                        size: Screenutil.length(44),
                      ),
                    ),
                  ),
                  SizedBox(width: Screenutil.length(34)),
                ],
              ),
              SizedBox(
                height: Screenutil.length(29),
              ),
              Container(
                width: double.infinity,
                height: Screenutil.length(271),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: Color(0xFFFFFFFF).withOpacity(0.9)),
                child: Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      bottom: Screenutil.length(173),
                      child: Container(
                        padding: EdgeInsets.all(Screenutil.length(12)),
                        height: Screenutil.length(196),
                        width: Screenutil.length(196),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Screenutil.length(196))),
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
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Screenutil.length(172))),
                            onPressed: () {
                              setState(() {
                                _makephonenum('tel:110');
                              });
                            },
                            child: Icon(
                              Feather.phone_call,
                              color: Colors.white,
                              size: Screenutil.size(87),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: Screenutil.length(146)),
                        Text(
                          '谎报警情，依法追责',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Screenutil.size(32),
                            color: Color(0xffe02020),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '谎报警情将可能被处以五日以上十日以下拘留',
                          style: TextStyle(
                            fontSize: Screenutil.size(24),
                            color: Color(0xff999999),
                          ),
                        ),
                        SizedBox(height: 19.5),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
