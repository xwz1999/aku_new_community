import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/house_keeping/house_keeping_list_model.dart';
import 'package:aku_community/ui/manager/house_keeping/house_keeping_detail_page.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/buttons/card_bottom_button.dart';
import 'package:aku_community/widget/others/aku_chip_box.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HouseKeepingCard extends StatelessWidget {
  final HouseKeepingListModel model;
  const HouseKeepingCard({Key? key, required this.model}) : super(key: key);
  String get dateStart =>
      DateUtil.formatDateStr(model.createDate, format: 'yyyy-MM-dd HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.to(() => HouseKeepingDetailPage(model: model));
      },
      child: Container(
        padding: EdgeInsets.all(24.w),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                AkuChipBox(title: model.typeString),
                16.w.widthBox,
                Expanded(
                  child: Text(
                    dateStart,
                    style: TextStyle(
                      color: ktextSubColor,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                Text(
                  model.statusString,
                  style: TextStyle(color: model.statusColor),
                ),
              ],
            ),
            24.w.heightBox,
            Text(
              model.content,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: ktextPrimary,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            16.w.heightBox,
            _buildImgs(),
            Row(
              children: [
                Image.asset(
                  R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  width: 40.w,
                  height: 40.w,
                ),
                12.w.widthBox,
                '${S.of(context)!.tempPlotName}·${model.roomName}'
                    .text
                    .size(28.sp)
                    .color(ktextSubColor)
                    .make()
              ],
            ),
            _getBottomCard(),
          ],
        ),
        margin: EdgeInsets.only(top: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
    );
  }

  _buildImgs() {
    return Container(
      height: 168.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var imgObj = model.submitImgList[index].url;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            height: 168.w,
            width: 168.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
            ),
            clipBehavior: Clip.antiAlias,
            child: FadeInImage.assetNetwork(
                placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                image: API.image(imgObj ?? '')),
          );
        },
        itemCount: model.submitImgList.length,
      ),
    );
  }

  _getBottomCard() {
    return Column(
      children: [
        Divider(height: 48.w),
        Align(
            alignment: Alignment.centerRight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _getButtons())),
      ],
    );
  }

  _getButtons() {
    switch (model.status) {
      case 1:
        return [
          CardBottomButton.white(onPressed: () async {}, text: ('取消服务')),
        ];
      case 2:
        return [
          CardBottomButton.white(onPressed: () async {}, text: ('取消服务')),
        ];
      case 3:
        return [
          CardBottomButton.white(
              onPressed: () async {
                Get.to(() => HouseKeepingDetailPage(model: model));
              },
              text: ('查看详情')),
        ];
      case 4:
        return [
          CardBottomButton.white(onPressed: () async {}, text: ('查看账单')),
        ];
      case 5:
        return [
          CardBottomButton.white(onPressed: () async {}, text: ('查看详情')),
        ];
      case 6:
        return [
          CardBottomButton.white(onPressed: () async {}, text: ('查看详情')),
        ];
      case 9:
        return [
          CardBottomButton.white(onPressed: () async {}, text: ('查看详情')),
        ];
      default:
        return [];
    }
  }
}
