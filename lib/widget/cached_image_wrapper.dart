import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

enum ImageType {
  normal,
  // random, //随机
  assets, //资源目录
}

class CachedImageWrapper extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageType imageType;
  final bool isSigned;

  CachedImageWrapper(
      {@required this.url,
      @required this.width,
      @required this.height,
      this.isSigned = true,
      this.imageType: ImageType.normal,
      this.fit: BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return imageType == ImageType.normal
        ? CachedNetworkImage(
            key: Key(url),
            imageBuilder: (context, imageProvider) {
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: isSigned
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.6),
                  image: isSigned
                      ? DecorationImage(
                          image: imageProvider, fit: BoxFit.cover, scale: 1)
                      : null,
                ),
              );
            },
            imageUrl: imageUrl,
            placeholder: (_, __) => SizedBox(
                width: width,
                height: height,
                child:
                    CupertinoActivityIndicator(radius: min(10.0, width / 3))),
            errorWidget: (_, __, ___) => SizedBox(
              width: width,
              height: height,
              child: Icon(
                Icons.error_outline,
              ),
            ),
          )
        : SizedBox(
            width: width,
            height: height,
            child: Image.asset(imageUrl),
          );
  }

  String get imageUrl {
    switch (imageType) {
      // case ImageType.random:
      //   return ImageHelper.randomUrl(
      //       key: url, width: width.toInt(), height: height.toInt());
      case ImageType.assets:
        return "assets/images/" + url;
      case ImageType.normal:
        return url;
    }
    return url;
  }
}
