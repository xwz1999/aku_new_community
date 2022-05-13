import 'package:flutter/material.dart';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/bee_search_text_field.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';

// import 'package:amap_search_fluttify/amap_search_fluttify.dart' as search;

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  AMapController? _mapController;
  var poiList = [];
  LatLng? _target;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      var location = await Permission.locationWhenInUse.isGranted;
      if (!location) {
        await Permission.locationWhenInUse.request();
      }
      _target = LatLng(
        (UserTool.appProvider.location?['latitude'] ?? 0) as double,
        (UserTool.appProvider.location?['longitude'] ?? 0) as double,
      );
      // poiList = await search.AmapSearch.instance.searchAround(search.LatLng(
      //   (UserTool.appProveider.location?['latitude'] ?? 0) as double,
      //   (UserTool.appProveider.location?['longitude'] ?? 0) as double,
      // ));
      // print(poiList.length);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: BeeSearchTextField(),
      body: Stack(
        children: [
          AMapWidget(
            privacyStatement: AMapPrivacyStatement(
                hasContains: true, hasShow: true, hasAgree: true),
            onMapCreated: (controller) {
              // final appProvider =
              //     Provider.of<AppProvider>(context, listen: false);
              // LatLng _target = LatLng(
              //   (appProvider.location?['latitude'] ?? 0) as double,
              //   (appProvider.location?['longitude'] ?? 0) as double,
              // );
              _mapController = controller;
              _mapController!.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: _target!, zoom: 18),
                ),
              );
            },
            myLocationStyleOptions: MyLocationStyleOptions(
              true,
              circleFillColor: Theme.of(context).primaryColor.withOpacity(0.2),
              circleStrokeColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
