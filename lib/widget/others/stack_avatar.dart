import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/material.dart';

class StackAvatar extends StatelessWidget {
  final List<String?> avatars;

  const StackAvatar({Key? key, required this.avatars}) : super(key: key);

  double get offset => 35.w;

  int get length => avatars.length;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 44.w * 2 + 26.w,
          height: 44.w + 6.w,
        ),
        ...List.generate(length, (index) {
          return Positioned(
            left: index * offset,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22.w + 2.w),
                border: Border.all(color: Color(0xFF999999)),
              ),
              clipBehavior: Clip.antiAlias,
              child: FadeInImage.assetNetwork(
                height: 44.w,
                width: 44.w,
                placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                image: API.image(avatars[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ],
    );
  }
}
