import 'package:aku_new_community/widget/bee_image_network.dart';
import 'package:flutter/material.dart';


import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';

class HorizontalImageView extends StatelessWidget {
  final List<String?> urls;

  HorizontalImageView(
    this.urls, {
    Key? key,
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
              tag: urls[index]!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                child: BeeImageNetwork(
                  urlsWithHost:[SAASAPI.image(urls[index])],
                  height: 184.w,
                  width: 184.w,
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
