import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeeImagePreview extends StatefulWidget {
  final File file;
  BeeImagePreview({Key key, @required this.file}) : super(key: key);

  @override
  _BeeImagePreviewState createState() => _BeeImagePreviewState();
}

class _BeeImagePreviewState extends State<BeeImagePreview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Center(
          child: InteractiveViewer(
            minScale: 0.2,
            child: Hero(
              tag: widget.file.hashCode,
              child: Image.file(widget.file),
            ),
          ),
        ),
      ),
    );
  }
}
