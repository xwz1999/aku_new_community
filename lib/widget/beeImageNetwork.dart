import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeeImageNetwork extends StatelessWidget {
  final List<ImgModel> urls;
  final double? width;
  final double? height;

  const BeeImageNetwork({Key? key, required this.urls, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
      image: SARSAPI.image(ImgModel.first(urls)),
      imageErrorBuilder: (context, obj, stackTrace) {
        return Image.asset(
          R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
          width: width ?? 160.w,
          height: 160.w,
        );
      },
      height: height ?? 160.w,
      width: width ?? 160.w,
      fit: BoxFit.cover,
    );
  }
}
