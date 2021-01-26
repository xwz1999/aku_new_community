// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController _controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller.pauseCamera();
    } else if (Platform.isIOS) {
      _controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: _qrKey,
        onQRViewCreated: (controller) {
          _controller = controller;
        },
      ),
    );
  }
}
