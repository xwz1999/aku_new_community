import 'package:akuCommunity/model/common/img_model.dart';
import 'package:akuCommunity/model/community/activity_item_model.dart';
import 'package:akuCommunity/ui/community/activity_detail_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/widget/others/stack_avatar.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ActivityCard extends StatelessWidget {
  final ActivityItemModel model;
  const ActivityCard({
    Key key,
    @required this.model,
  }) : super(key: key);

  String get firstPath =>
      (model.imgUrls?.isEmpty ?? true) ? null : model.imgUrls.first.url;

  Widget build(BuildContext context) {
    return MaterialButton(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      padding: EdgeInsets.zero,
      onPressed: ActivityDetailPage(id: model.id).to,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.w),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          firstPath == null
              ? SizedBox()
              : Hero(
                  tag: API.image(firstPath),
                  child: Material(
                    color: Colors.grey,
                    child: FadeInImage.assetNetwork(
                      placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                      image: API.image(firstPath),
                      height: 210.w,
                      width: double.infinity,
                    ),
                  ),
                ),
          model.title.text
              .size(28.sp)
              .black
              .make()
              .pSymmetric(h: 24.w, v: 16.w),
          [
            '地        点:'.text.size(24.sp).color(Color(0xFF999999)).make(),
            model.location.text.size(24.sp).make(),
          ].row().pSymmetric(h: 24.w),
          6.hb,
          [
            '活动时间:'.text.size(24.sp).color(Color(0xFF999999)).make(),
            '${DateUtil.formatDate(
              model.begin,
              format: 'MM月dd日 HH:mm',
            )}至${DateUtil.formatDate(
              model.end,
              format: 'MM月dd日 HH:mm',
            )}'
                .text
                .size(24.sp)
                .make(),
          ].row().pSymmetric(h: 24.w),
          [
            StackAvatar(avatars: model.headImgURls.map((e) => e.url).toList()),
            Spacer(),
            MaterialButton(
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Color(0xFFFFC40C),
              shape: StadiumBorder(),
              height: 44.w,
              minWidth: 120.w,
              onPressed: () {},
              child: '去看看'.text.size(20.sp).bold.make(),
            ),
          ].row().p(24.w),
        ],
      ),
    );
  }
}
