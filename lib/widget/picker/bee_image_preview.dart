import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';

class BeeImagePreview extends StatefulWidget {
  static Future<T> toFile<T>({@required File file, String tag}) async {
    return await navigator.push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondAnimation) {
          return FadeTransition(
            opacity: animation,
            child: BeeImagePreview.file(file: file, tag: tag),
          );
        },
      ),
    );
  }

  static toPath({@required String path, String tag}) {
    navigator.push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondAnimation) {
          return FadeTransition(
            opacity: animation,
            child: BeeImagePreview.path(path: path, tag: tag),
          );
        },
      ),
    );
  }

  final File file;
  final String path;
  final String tag;
  BeeImagePreview.file({Key key, @required this.file, this.tag})
      : path = null,
        super(key: key);

  BeeImagePreview.path({Key key, @required this.path, this.tag})
      : file = null,
        super(key: key);

  @override
  _BeeImagePreviewState createState() => _BeeImagePreviewState();
}

class _BeeImagePreviewState extends State<BeeImagePreview> {
  Widget get image {
    if (widget.file == null)
      return Hero(
        tag: widget.tag ?? widget.path,
        child: FadeInImage.assetNetwork(
          placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
          image: API.image(widget.path),
        ),
      );
    else
      return Hero(
        tag: widget.tag ?? widget.file.hashCode,
        child: Image.file(widget.file),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(48),
          minScale: 0.2,
          maxScale: 10,
          child: Center(child: image),
        ),
      ),
    );
  }
}
