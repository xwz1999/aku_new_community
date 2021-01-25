import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/picker/bee_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:get/get.dart';

class HorizontalImageView extends StatefulWidget {
  final List<String> urls;
  HorizontalImageView(
    this.urls, {
    Key key,
  }) : super(key: key);

  @override
  _HorizontalImageViewState createState() => _HorizontalImageViewState();
}

class _HorizontalImageViewState extends State<HorizontalImageView> {
  @override
  Widget build(BuildContext context) {
    if (widget.urls.isEmpty) return 15.hb;
    return Container(
      height: 184.w + 32.w,
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        separatorBuilder: (_, __) => 16.wb,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  BeeImagePreview.path(path: widget.urls[index]),
                  opaque: false,
                );
              },
              child: Hero(
                tag: widget.urls[index],
                child: FadeInImage.assetNetwork(
                  height: 184.w,
                  width: 184.w,
                  placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                  image: API.image(widget.urls[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: widget.urls.length,
      ),
    );
  }
}
