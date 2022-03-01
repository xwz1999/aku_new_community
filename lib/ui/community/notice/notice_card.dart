import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/home/home_announce_model.dart';
import 'package:aku_new_community/ui/community/notice/notice_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/beeImageNetwork.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

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
      model.createDateString?.year == (preModel?.createDateString?.year ?? 0) &&
      model.createDateString?.month ==
          (preModel?.createDateString?.month ?? 0) &&
      model.createDateString?.day == (preModel?.createDateString?.day ?? 0);

  bool get isYesterday {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    return yesterday.year == model.createDateString?.year &&
        yesterday.month == model.createDateString?.month &&
        yesterday.day == model.createDateString?.day;
  }

  bool get isFirst => preModel == null;

  bool get notSameYear =>
      model.createDateString?.year != (preModel?.createDateString?.year ?? 0);

  Widget title() {
    if (DateUtil.isToday(model.createDateString?.millisecond))
      return '今天'.text.size(52.sp).bold.make();
    if (isYesterday)
      return '昨天'.text.size(52.sp).bold.make();
    else
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (model.createDateString?.day.toString() ?? '')
              .text
              .size(52.sp)
              .bold
              .make(),
          '${model.createDateString?.month}月'.text.size(36.sp).make(),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (notSameYear && model.createDateString?.year != DateTime.now().year)
            ? '${model.createDateString?.year}年'
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
