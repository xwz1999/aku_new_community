import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/picker/bee_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                placeholder: R.ASSETS_IMAGES_LOGO_PNG,
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
