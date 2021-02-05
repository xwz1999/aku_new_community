// Flutter imports:
import 'package:akuCommunity/pages/one_alarm/alarm_detail_page.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

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
  Future<void> _makephonenum(String url) async {
    (await canLaunch(url)) ? await launch(url) : throw 'Could not launch $url';
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
    return BeeScaffold(
      title: '一键报警',
      actions: [
        MaterialButton(
          onPressed: () => Get.to(AlarmDetailPage()),
          child: '功能说明'.text.black.size(28.sp).make(),
        )
      ],
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
                  margin: EdgeInsets.only(top: 32.w),
                  width: 686.w,
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
                      Container(
                        margin: EdgeInsets.only(top: 24.w, left: 32.w),
                        child: Text(
                          '当前位置(仅供参考)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff333333),
                              fontSize: 28.sp),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.w, left: 32.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Entypo.location_pin,
                              color: Color(0xff666666),
                              size: 29.sp,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.w),
                              child: Text(
                                (_location == null)
                                    ? '加载中……'
                                    : _location.aoiName,
                                style: TextStyle(
                                  color: Color(0xff666666),
                                  fontSize: 28.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      24.hb,
                    ],
                  )),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 66.w,
                    height: 66.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(66.w),
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
                          borderRadius: BorderRadius.circular(66.w)),
                      color: Color(0xFFFFFFFF),
                      onPressed: () {
                        _amapController?.setCenterCoordinate(_location.latLng);
                        Future.delayed(Duration(milliseconds: 500), () {
                          if (mounted) _amapController.setZoomLevel(16);
                        });
                      },
                      child: Icon(
                        Icons.location_searching,
                        size: 44.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 34.w),
                ],
              ),
              SizedBox(
                height: 29.w,
              ),
              Container(
                width: double.infinity,
                height: 271.w,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: Color(0xFFFFFFFF).withOpacity(0.9)),
                child: Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      bottom: 173.w,
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        height: 196.w,
                        width: 196.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(196.w)),
                        ),
                        child: Container(
                          height: 172.w,
                          width: 172.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topLeft,
                              colors: [Color(0xffef0909), Color(0xffff8880)],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(172.w)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color(0xfffd7770).withOpacity(0.33),
                                offset: Offset(0, 10.w),
                                blurRadius: 20.w,
                                spreadRadius: 4.w,
                              )
                            ],
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(172.w)),
                            onPressed: () {
                              setState(() {
                                _makephonenum('tel:110');
                              });
                            },
                            child: Icon(
                              Feather.phone_call,
                              color: Colors.white,
                              size: 87.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 146.w),
                        Text(
                          '谎报警情，依法追责',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32.sp,
                            color: Color(0xffe02020),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '谎报警情将可能被处以五日以上十日以下拘留',
                          style: TextStyle(
                            fontSize: 24.sp,
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
