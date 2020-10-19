import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class AppBarAction extends StatefulWidget {
  final IconData icon;
  final String title;
  AppBarAction({Key key, this.icon, this.title}) : super(key: key);

  @override
  _AppBarActionState createState() => _AppBarActionState();
}

class _AppBarActionState extends State<AppBarAction> {
  ScanResult scanResult;

  final _flashOnController = TextEditingController(text: "打开闪光灯");
  final _flashOffController = TextEditingController(text: "关闭闪光灯");
  final _cancelController = TextEditingController(text: "关闭");

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Screenutil.length(32)),
      child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: Color(0xff333333),
              ),
              SizedBox(height: Screenutil.length(4)),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: Screenutil.size(20),
                  color: Color(0xff333333),
                ),
              )
            ],
          ),
          onTap: () {
            switch (widget.title) {
              case '扫一扫':
                scan();
                break;
              case '消息':
                Navigator.pushNamed(
                    context, PageName.message_center_page.toString());
                break;
              case '购物车':
                Navigator.pushNamed(
                    context, PageName.market_cart_page.toString());
                break;
              case '分类':
                Navigator.pushNamed(
                    context, PageName.market_class_page.toString());
                break;
              default:
            }
          }),
    );
  }
}
