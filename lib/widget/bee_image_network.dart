import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/model/common/img_model.dart';

class BeeImageNetwork extends StatelessWidget {
  final List<ImgModel>? imgs;
  final List<String>? urls;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final List<String>? urlsWithHost;

  const BeeImageNetwork(
      {Key? key,
      this.imgs,
      this.width,
      this.height,
      this.urls,
      this.fit = BoxFit.cover,
      this.urlsWithHost})
      : assert(imgs != null || urls != null || urlsWithHost != null),
        super(key: key);

  String get imgUrl => urlsWithHost == null
      ? imgs == null
          ? SAASAPI.image(urls!.isEmpty ? '' : urls!.first)
          : SAASAPI.image(ImgModel.first(imgs))
      : urlsWithHost!.first;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: Assets.images.placeholder.path,
      image: imgUrl,
      imageErrorBuilder: (context, obj, stackTrace) {
        return Image.asset(
          Assets.images.placeholder.path,
          width: width ?? 160.w,
          height: height ?? 160.w,
          fit: BoxFit.cover,
        );
      },
      height: height ?? 160.w,
      width: width ?? 160.w,
      fit: fit,
    );
  }
}
