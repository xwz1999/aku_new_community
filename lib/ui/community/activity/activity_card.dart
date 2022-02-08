import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/community/activity_item_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'activity_detail_page_old.dart';

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
        borderRadius: BorderRadius.circular(24.w),
        // side: BorderSide(
        //   color: Colors.grey,
        // ),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: ImgModel.first(model!.imgUrls),
            child: Material(
              color: Colors.grey,
              child: FadeInImage.assetNetwork(
                placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                image: API.image(ImgModel.first(model!.imgUrls)),
                height: 197.w,
                width: double.infinity,
                fit: BoxFit.cover,
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
                    model == null ? '' : model!.title!,
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
          // [
          //   '地        点:'.text.size(24.sp).color(Color(0xFF999999)).make(),
          //   model!.location!.text.size(24.sp).make(),
          // ].row().pSymmetric(h: 24.w),
          20.hb,
          [
            '报名截止：'.text.size(22.sp).color(Color(0x73000000)).make(),
            '${DateUtil.formatDate(
              model!.end,
              format: 'yyyy年MM月dd日 HH:mm',
            )}'
                .text
                .size(22.sp)
                .color(Color(0x73000000))
                .make(),
          ].row().pSymmetric(h: 24.w),
          // [
          //   // StackAvatar(
          //   //     avatars: model!.headImgURls!.map((e) => e.url).toList()),
          //   Spacer(),
          //   MaterialButton(
          //     elevation: 0,
          //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //     color: Color(0xFFFFC40C),
          //     shape: StadiumBorder(),
          //     height: 44.w,
          //     minWidth: 120.w,
          //     disabledColor: Color(0xFFABABAB),
          //     onPressed: outdate
          //         ? null
          //         : () {
          //             Get.to(() => ActivityDetailPage(id: model!.id));
          //           },
          //     child: outdate
          //         ? '已结束'.text.size(20.sp).bold.make()
          //         : '去看看'.text.size(20.sp).bold.make(),
          //   ),
          // ].row().p(24.w),
        ],
      ),
    );
  }
}
