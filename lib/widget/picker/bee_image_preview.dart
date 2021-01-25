import 'dart:io';
import 'dart:ui';

import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeeImagePreview extends StatefulWidget {
  final File file;
  final String path;
  BeeImagePreview.file({Key key, @required this.file})
      : path = null,
        super(key: key);

  BeeImagePreview.path({Key key, @required this.path})
      : file = null,
        super(key: key);

  @override
  _BeeImagePreviewState createState() => _BeeImagePreviewState();
}

class _BeeImagePreviewState extends State<BeeImagePreview> {
  Widget get image {
    if (widget.file == null)
      return Hero(
        tag: widget.path,
        child: FadeInImage.assetNetwork(
          placeholder: R.ASSETS_IMAGES_LOGO_PNG,
          image: API.image(widget.path),
        ),
      );
    else
      return Hero(
        tag: widget.file.hashCode,
        child: Image.file(widget.file),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(48),
            minScale: 0.2,
            maxScale: 10,
            child: Center(child: image),
          ),
        ),
      ),
    );
  }
}
