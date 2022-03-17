import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopicSliverHeader extends SliverPersistentHeaderDelegate {
  final String? imgPath;
  final String? title;
  final String? subTitle;
  final int? id;
  final int? dynamicNum;
  final int? commentNum;

  TopicSliverHeader(
      {this.imgPath,
      this.title,
      this.subTitle,
      required this.id,
      this.commentNum,
      this.dynamicNum});

  _buildOverlay(double shrinkOffset) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Material(
        color: Colors.black.withOpacity(0 + 0.5 * _offset(shrinkOffset)),
      ),
    );
  }

  _buildBackButton() {
    return Positioned(
      left: 0,
      top: ScreenUtil().statusBarHeight,
      child: BeeBackButton(color: Colors.white).material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  _buildTitle(double shrinkOffset) {
    return Positioned(
      bottom: 248.w - 248.w * _filterOffset(shrinkOffset),
      left: 32.w + (95.w - 32.w) * _offset(shrinkOffset),
      child: '#$title'.text.bold.white.size(52.sp).make(),
    );
  }

  _buildNum(double shrinkOffset) {
    return Positioned(
      bottom: 206.w - 206.w * _offset(shrinkOffset) * 2,
      left: 32.w + (95.w - 32.w) * _offset(shrinkOffset),
      child: '${dynamicNum ?? 0}条动态  ${commentNum ?? 0}人讨论'
          .text
          .size(24.sp)
          .white
          .make(),
    );
  }

  _buildSubTitle(double shrinkOffset) {
    return Positioned(
      bottom: 104.w - 104.w * _offset(shrinkOffset) * 2,
      left: 32.w,
      child: Opacity(
        opacity: 1 - _offset(shrinkOffset),
        child: SizedBox(
          width: 500.w,
          child: subTitle!.text
              .size(24.sp)
              .maxLines(2)
              .white
              .overflow(TextOverflow.ellipsis)
              .make(),
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: "$imgPath\_$id",
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: SAASAPI.image(imgPath),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Material(color: Colors.black.withOpacity(0.4)),
          ),
          // _buildOverlay(shrinkOffset),
          _buildBackButton(),
          _buildTitle(shrinkOffset),
          _buildNum(shrinkOffset),
          _buildSubTitle(shrinkOffset),
        ],
      ),
    );
  }

  double _offset(double shrinkOffset) {
    if (shrinkOffset <= 0)
      return 0;
    else if (shrinkOffset > 0 && shrinkOffset <= maxExtent)
      return shrinkOffset / maxExtent;
    else
      return 1;
  }

  double _filterOffset(double shrinkOffset) {
    var offset = _offset(shrinkOffset);
    if (offset <= 0) return 0;
    if (offset < 0.7) return offset / 0.7;
    return 1;
  }

  @override
  double get maxExtent => 500.w + ScreenUtil().statusBarHeight;

  @override
  double get minExtent => 50 + ScreenUtil().statusBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
