import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
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
      placeholder: Assets.images.placeholder.path,
      image: imgs == null
          ? SARSAPI.image(urls!.isEmpty ? '' : urls!.first)
          : SARSAPI.image(ImgModel.first(imgs)),
      imageErrorBuilder: (context, obj, stackTrace) {
        return Image.asset(
          Assets.images.placeholder.path,
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
