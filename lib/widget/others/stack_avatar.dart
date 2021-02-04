// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/headers.dart';

class StackAvatar extends StatelessWidget {
  final List<String> avatars;
  const StackAvatar({Key key, @required this.avatars}) : super(key: key);
  double get offset => 35.w;
  int get length => avatars?.length ?? 0;
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
              ),
            ),
          );
        }),
      ],
    );
  }
}
