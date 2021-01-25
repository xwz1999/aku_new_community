import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akuCommunity/const/resource.dart';

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
      height: 184.w + 24.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.w),
              child: FadeInImage.assetNetwork(
                placeholder: R.ASSETS_ICONS_PROPOSAL_PNG,
                image: API.image(widget.urls[index]),
              ),
            ),
          );
        },
        itemCount: widget.urls.length,
      ),
    );
  }
}
