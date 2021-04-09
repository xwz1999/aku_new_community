import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/picker/bee_image_preview.dart';

class HorizontalImageView extends StatelessWidget {
  final List<String> urls;
  HorizontalImageView(
    this.urls, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (urls.isEmpty) return 15.hb;
    return Container(
      height: 184.w + 32.w,
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        separatorBuilder: (_, __) => 16.wb,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              BeeImagePreview.toPath(path: urls[index], tag: urls[index]);
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
      ),
    );
  }
}
