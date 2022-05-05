import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/home/home_activity_model.dart';
import 'package:aku_new_community/ui/community/activity/activity_func.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/beeImageNetwork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'activity_detail_page.dart';

class ActivityCard extends StatelessWidget {
  final bool home;
  final HomeActivityModel? model;

  const ActivityCard({
    Key? key,
    required this.model,
    this.home = false,
  }) : super(key: key);

  bool get outdate => model!.end?.isBefore(DateTime.now()) ?? true;

  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: home ? 450.w : 540.w),
      child: MaterialButton(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero,
        onPressed: () => Get.to(() => ActivityDetailPage(id: model!.id)),
        elevation: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                Hero(
                  tag: ImgModel.first(model!.imgList),
                  child: Material(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.w),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: BeeImageNetwork(
                      imgs: model!.imgList ?? [],
                      width: double.infinity,
                      height: home ? 250.w : 340.w,
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 39.w,
                      width: 98.w,
                      decoration: BoxDecoration(
                        color: outdate ? Color(0xFFE8E8E8) : Color(0xFFFDE019),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            bottomRight: Radius.circular(12.w)),
                      ),
                      child: outdate
                          ? '已结束'
                              .text
                              .size(22.sp)
                              .color(Color(0xFF999999))
                              .make()
                          : '报名中'
                              .text
                              .size(22.sp)
                              .color(Color(0xFF333333))
                              .make(),
                    ))
              ],
            ),
            24.hb,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 340.w),
                  child: Text(
                    model == null ? '' : model!.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(0xD9000000),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
              ],
            ),
            24.hb,
            Row(
              children: [
                Flexible(
                  child: AvatarsParticipate(
                    avatars:
                        (model?.avatarImgList?.map((e) => e.url).toList() ??
                            []),
                    pNum: model?.registrationNum ?? 0,
                    hasIcon: false,
                  ),
                ),
                // Spacer(),
                Offstage(
                    offstage: ActivityFunc.dateCheck(model!.end) == '已结束',
                    child: ActivityFunc.dateCheck(model!.end)
                        .text
                        .size(24.sp)
                        .black
                        .make()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
