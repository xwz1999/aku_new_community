import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';

class CarparkingCard extends StatelessWidget {
  final bool outdated;
  const CarparkingCard({Key key, @required this.outdated}) : super(key: key);

  String get _assetImage {
    return outdated
        ? R.ASSETS_STATIC_PARKING_GREY_WEBP
        : R.ASSETS_STATIC_PARKING_YELLOW_WEBP;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 688 / 286,
      child: Container(
        child: Column(
          children: [],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(_assetImage)),
        ),
      ),
    );
  }
}
