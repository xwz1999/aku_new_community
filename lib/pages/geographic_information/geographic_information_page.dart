import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/pages/one_alarm/alarm_detail_page.dart';
import 'package:aku_new_community/pages/one_alarm/widget/alarm_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


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
    PermissionUtil.getLocationPermission();
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
              CameraPosition(target: _target, zoom: 18),
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
