import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BeeQR {
  static Future<String?> scan() async {
    return await Get.to(() => _QRScanPage());
  }
}

class _QRScanPage extends StatefulWidget {
  _QRScanPage({Key? key}) : super(key: key);

  @override
  __QRScanPageState createState() => __QRScanPageState();
}

class __QRScanPageState extends State<_QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  bool _doneTag = false;
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: QRView(
          key: qrKey,
          overlay: QrScannerOverlayShape(
            borderRadius: 8,
          ),
          onQRViewCreated: (controller) {
            _controller = controller;
            controller.scannedDataStream.listen((event) {
              if (!_doneTag) {
                _doneTag = true;
                Get.back(result: event.code);
              }
            });
          },
        ),
      ),
    );
  }
}
