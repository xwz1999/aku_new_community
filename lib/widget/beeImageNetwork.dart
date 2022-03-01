import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeeImageNetwork extends StatelessWidget {
  final List<ImgModel>? imgs;
  final List<String>? urls;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const BeeImageNetwork(
      {Key? key,
      this.imgs,
      this.width,
      this.height,
      this.urls,
      this.fit = BoxFit.cover})
      : assert(imgs != null || urls != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
      image: SARSAPI.image(ImgModel.first(imgs)),
      imageErrorBuilder: (context, obj, stackTrace) {
        return Image.asset(
          R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
          width: width ?? 160.w,
          height: height ?? 160.w,
          fit: BoxFit.fill,
        );
      },
      height: height ?? 160.w,
      width: width ?? 160.w,
      fit: fit,
    );
  }
}
