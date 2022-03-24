import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/home/home_activity_model.dart';
import 'package:aku_new_community/ui/community/activity/activity_func.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/beeImageNetwork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'activity_detail_page.dart';

class ActivityCard extends StatelessWidget {
  final bool? home;
  final HomeActivityModel? model;

  const ActivityCard({
    Key? key,
    required this.model,
    this.home = false,
  }) : super(key: key);

  bool get outdate => ActivityFunc.dateCheck(model!.end) == '';

  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: home! ? 480.w : 540.w),
      child: MaterialButton(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        padding: EdgeInsets.zero,
        onPressed: () => Get.to(() => ActivityDetailPage(id: model!.id)),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.w),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: ImgModel.first(model!.imgList),
              child: Material(
                color: Colors.grey,
                child: BeeImageNetwork(
                  imgs: model!.imgList ?? [],
                  width: double.infinity,
                  height: home! ? 240.w : 340.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.w, top: 24.w),
              child: Row(
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
                  GestureDetector(
                    child: Container(
                      //color: Color(0x80FEBF76),

                      // shape: StadiumBorder(),
                      alignment: Alignment.center,
                      height: 39.w,
                      width: 98.w,
                      decoration: BoxDecoration(
                        color: outdate
                            ? Colors.black.withOpacity(0.06)
                            : Color(0x80FEBF76),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),

                      child: outdate
                          ? '已结束'
                              .text
                              .size(22.sp)
                              .color(Colors.black.withOpacity(0.25))
                              .make()
                          : '报名中'
                              .text
                              .size(22.sp)
                              .color(Color(0xFFF48117))
                              .make(),
                    ),
                    onTap: () {
                      outdate
                          ? null
                          : () {
                              Get.to(() => ActivityDetailPage(id: model!.id));
                            };
                    },
                  ),
                  24.wb
                ],
              ),
            ),
            Spacer(),
            [
              Flexible(
                child: AvatarsParticipate(
                  avatars:
                      (model?.avatarImgList?.map((e) => e.url).toList() ?? []),
                  pNum: model?.registrationNum ?? 0,
                  hasIcon: false,
                ),
              ),
              // Spacer(),
              ActivityFunc.dateCheck(model!.end)
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
            ].row().pSymmetric(h: 24.w),
            20.hb,
          ],
        ),
      ),
    );
  }
}
