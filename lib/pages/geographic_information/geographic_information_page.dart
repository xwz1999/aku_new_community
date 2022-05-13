
import 'package:flutter/material.dart';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:provider/provider.dart';

import 'package:aku_new_community/pages/one_alarm/widget/alarm_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import '../../widget/others/user_tool.dart';

class GeographicInformationPage extends StatefulWidget {
  GeographicInformationPage({Key? key}) : super(key: key);

  @override
  _GeographicInformationPageState createState() => _GeographicInformationPageState();
}

class _GeographicInformationPageState extends State<GeographicInformationPage> {
  AMapController? _mapController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () async {
      //本地存储初始化在最前
      //初始化AMap
      // await AmapLocation.instance.init(iosKey: 'ios key');
      PermissionUtil.getLocationPermission();
      UserTool.appProvider.startLocation();
    });


  }

  @override
  void dispose() {
    super.dispose();
    _mapController?.disponse();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '地理信息',
      body: AMapWidget(
        privacyStatement: AMapPrivacyStatement(
            hasContains: true, hasShow: true, hasAgree: true),
        onMapCreated: (controller) {
          final appProvider =
          Provider.of<AppProvider>(context, listen: false);
          LatLng _target = LatLng(
            (appProvider.location?['latitude'] ?? 0) as double,
            (appProvider.location?['longitude'] ?? 0) as double,
          );
          _mapController = controller;
          _mapController!.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: _target, zoom: 14),
            ),
          );
        },
        myLocationStyleOptions: MyLocationStyleOptions(
          true,
          circleFillColor: Theme.of(context).primaryColor.withOpacity(0.2),
          circleStrokeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
