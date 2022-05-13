import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/home/home_announce_model.dart';
import 'package:aku_new_community/ui/community/notice/notice_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_image_network.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';

@Deprecated('旧设计，暂时弃用')
class NoticeCard extends StatelessWidget {
  final HomeAnnounceModel model;
  final HomeAnnounceModel? preModel;

  const NoticeCard({
    Key? key,
    required this.model,
    required this.preModel,
  }) : super(key: key);

  bool get sameDay =>
      model.createDateDT?.year == (preModel?.createDateDT?.year ?? 0) &&
      model.createDateDT?.month == (preModel?.createDateDT?.month ?? 0) &&
      model.createDateDT?.day == (preModel?.createDateDT?.day ?? 0);

  bool get isYesterday {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    return yesterday.year == model.createDateDT?.year &&
        yesterday.month == model.createDateDT?.month &&
        yesterday.day == model.createDateDT?.day;
  }

  bool get isFirst => preModel == null;

  bool get notSameYear =>
      model.createDateDT?.year != (preModel?.createDateDT?.year ?? 0);

  Widget title() {
    if (DateUtil.isToday(model.createDateDT?.millisecond))
      return '今天'.text.size(52.sp).bold.make();
    if (isYesterday)
      return '昨天'.text.size(52.sp).bold.make();
    else
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (model.createDateDT?.day.toString() ?? '')
              .text
              .size(52.sp)
              .bold
              .make(),
          '${model.createDateDT?.month}月'.text.size(36.sp).make(),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (notSameYear && model.createDateDT?.year != DateTime.now().year)
            ? '${model.createDateDT?.year}年'
                .text
                .bold
                .size(52.sp)
                .make()
                .paddingOnly(left: 32.w, top: isFirst ? 0 : 64.w, bottom: 32.w)
            : SizedBox(),
        MaterialButton(
          onPressed: () {
            Get.to(() => NoticeDetailPage(id: model.id));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200.w,
                padding: EdgeInsets.only(left: 32.w),
                alignment: Alignment.topLeft,
                child: sameDay ? SizedBox() : title(),
              ),
              model.imgList.length == 0
                  ? SizedBox(height: 152.w)
                  : GestureDetector(
                      onTap: () {
                        BeeImagePreview.toPath(
                          path: ImgModel.first(model.imgList),
                          tag:
                              '${ImgModel.first(model.imgList)}${model.hashCode}',
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Hero(
                          tag:
                              '${ImgModel.first(model.imgList)}${model.hashCode}',
                          child: BeeImageNetwork(
                            imgs: model.imgList,
                          ),
                        ),
                      ),
                    ),
              10.wb,
              model.title.text.make().expand(),
            ],
          ),
        ),
      ],
    );
  }
}
