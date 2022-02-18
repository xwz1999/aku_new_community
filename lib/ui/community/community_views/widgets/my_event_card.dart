import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/model/community/my_event_item_model.dart';
import 'package:aku_new_community/models/community/dynamic_detail_model.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/community/community_views/event_detail_page.dart';
import 'package:aku_new_community/utils/bee_date_util.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/picker/bee_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class MyEventCard extends StatelessWidget {
  final MyEventItemModel model;
  final MyEventItemModel? preModel;

  const MyEventCard({
    Key? key,
    required this.model,
    required this.preModel,
  }) : super(key: key);

  bool get isFirst => preModel == null;

  bool get notSameYear => model.date!.year != (preModel?.date?.year ?? 0);

  BeeDateUtil get beeDate => BeeDateUtil(model.date);

  bool get sameDay =>
      model.date!.year == (preModel?.date?.year ?? 0) &&
      model.date!.month == (preModel?.date?.month ?? 0) &&
      model.date!.day == (preModel?.date?.day ?? 0);

  Widget title() {
    if (beeDate.sameDay) return '今天'.text.size(52.sp).bold.make();
    if (beeDate.isYesterday)
      return '昨天'.text.size(52.sp).bold.make();
    else
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          model.date!.day.toString().text.size(52.sp).bold.make(),
          '${model.date!.month}月'.text.size(36.sp).make(),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (notSameYear && model.date!.year != DateTime.now().year)
            ? '${model.date!.year}年'
                .text
                .bold
                .size(52.sp)
                .make()
                .paddingOnly(left: 32.w, top: isFirst ? 0 : 64.w, bottom: 32.w)
            : SizedBox(),
        MaterialButton(
          onPressed: () async {
            BaseModel models = await NetUtil().get(
              SARSAPI.community.dynamicDetail,
              params: {'dynamicId': model.id},
            );
            DynamicDetailModel eventItemModel =
                DynamicDetailModel.fromJson(models.data);
            Get.to(() => EventDetailPage(
                  dynamicId: model.id ?? 0,
                ));
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
              model.imgUrl!.length == 0
                  ? SizedBox(height: 152.w)
                  : GestureDetector(
                      onTap: () {
                        BeeImagePreview.toPath(
                          path: ImgModel.first(model.imgUrl),
                          tag: ImgModel.first(model.imgUrl),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                          image: SARSAPI.image(ImgModel.first(model.imgUrl)),
                          width: 152.w,
                          height: 152.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              10.wb,
              model.content!.text.make().expand(),
            ],
          ),
        ),
      ],
    );
  }
}
