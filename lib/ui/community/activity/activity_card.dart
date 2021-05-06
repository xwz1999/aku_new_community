import 'package:flutter/material.dart';

import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/model/community/activity_item_model.dart';
import 'package:aku_community/ui/community/activity/activity_detail_page.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/others/stack_avatar.dart';

class ActivityCard extends StatelessWidget {
  final ActivityItemModel? model;
  const ActivityCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  bool get outdate => model!.end!.compareTo(DateTime.now()) == -1;
  Widget build(BuildContext context) {
    return MaterialButton(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      padding: EdgeInsets.zero,
      onPressed: () => Get.to(() => ActivityDetailPage(id: model!.id)),
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
          ImgModel.first(model!.imgUrls) == null
              ? SizedBox()
              : Hero(
                  tag: ImgModel.first(model!.imgUrls),
                  child: Material(
                    color: Colors.grey,
                    child: FadeInImage.assetNetwork(
                      placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                      image: API.image(ImgModel.first(model!.imgUrls)),
                      height: 210.w,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          model!.title!.text
              .size(28.sp)
              .black
              .bold
              .make()
              .pSymmetric(h: 24.w, v: 16.w),
          [
            '地        点:'.text.size(24.sp).color(Color(0xFF999999)).make(),
            model!.location!.text.size(24.sp).make(),
          ].row().pSymmetric(h: 24.w),
          6.hb,
          [
            '活动时间:'.text.size(24.sp).color(Color(0xFF999999)).make(),
            '${DateUtil.formatDate(
              model!.begin,
              format: 'MM月dd日 HH:mm',
            )}至${DateUtil.formatDate(
              model!.end,
              format: 'MM月dd日 HH:mm',
            )}'
                .text
                .size(24.sp)
                .make(),
          ].row().pSymmetric(h: 24.w),
          [
            StackAvatar(
                avatars: model!.headImgURls!.map((e) => e.url).toList()),
            Spacer(),
            MaterialButton(
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Color(0xFFFFC40C),
              shape: StadiumBorder(),
              height: 44.w,
              minWidth: 120.w,
              disabledColor: Color(0xFFABABAB),
              onPressed: outdate
                  ? null
                  : () {
                      Get.to(() => ActivityDetailPage(id: model!.id));
                    },
              child: outdate
                  ? '已结束'.text.size(20.sp).bold.make()
                  : '去看看'.text.size(20.sp).bold.make(),
            ),
          ].row().p(24.w),
        ],
      ),
    );
  }
}
