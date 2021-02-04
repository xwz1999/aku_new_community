// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/picker/bee_image_preview.dart';

class BeeGridImageView extends StatelessWidget {
  final List<String> urls;
  final EdgeInsetsGeometry padding;
  const BeeGridImageView({
    Key key,
    @required this.urls,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (urls.isEmpty) return SizedBox();
    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.w,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(
              BeeImagePreview.path(path: urls[index]),
              opaque: false,
            );
          },
          child: Hero(
            tag: urls[index],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.w),
              child: FadeInImage.assetNetwork(
                height: 184.w,
                width: 184.w,
                placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                image: API.image(urls[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      itemCount: urls.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
