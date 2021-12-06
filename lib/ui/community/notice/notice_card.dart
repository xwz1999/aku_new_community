import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/community/board_model.dart';
import 'package:aku_new_community/ui/community/notice/notice_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class NoticeCard extends StatelessWidget {
  final BoardItemModel model;
  final BoardItemModel? preModel;

  const NoticeCard({
    Key? key,
    required this.model,
    required this.preModel,
  }) : super(key: key);

  bool get sameDay =>
      model.releaseDate!.year == (preModel?.releaseDate?.year ?? 0) &&
      model.releaseDate!.month == (preModel?.releaseDate?.month ?? 0) &&
      model.releaseDate!.day == (preModel?.releaseDate?.day ?? 0);

  bool get isYesterday {
    DateTime now = DateTime.now();
    DateTime yestoday = DateTime(now.year, now.month, now.day - 1);
    return yestoday.year == model.releaseDate!.year &&
        yestoday.month == model.releaseDate!.month &&
        yestoday.day == model.releaseDate!.day;
  }

  bool get isFirst => preModel == null;

  bool get notSameYear =>
      model.releaseDate!.year != (preModel?.releaseDate?.year ?? 0);

  Widget title() {
    if (DateUtil.isToday(model.releaseDate!.millisecond))
      return '今天'.text.size(52.sp).bold.make();
    if (isYesterday)
      return '昨天'.text.size(52.sp).bold.make();
    else
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          model.releaseDate!.day.toString().text.size(52.sp).bold.make(),
          '${model.releaseDate!.month}月'.text.size(36.sp).make(),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (notSameYear && model.releaseDate!.year != DateTime.now().year)
            ? '${model.releaseDate!.year}年'
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
              model.imgUrls!.length == 0
                  ? SizedBox(height: 152.w)
                  : GestureDetector(
                      onTap: () {
                        BeeImagePreview.toPath(
                          path: ImgModel.first(model.imgUrls),
                          tag:
                              '${ImgModel.first(model.imgUrls)}${model.hashCode}',
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
                              '${ImgModel.first(model.imgUrls)}${model.hashCode}',
                          child: FadeInImage.assetNetwork(
                            placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                            image: API.image(ImgModel.first(model.imgUrls)),
                            width: 152.w,
                            height: 152.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              10.wb,
              model.title!.text.make().expand(),
            ],
          ),
        ),
      ],
    );
  }
}
