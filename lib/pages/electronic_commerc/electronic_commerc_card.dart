import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/electronic_commerc/electronic_commerc_list_model.dart';
import 'package:aku_new_community/pages/electronic_commerc/electronic_commerc_detail_page.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ElectronicCommercCard extends StatefulWidget {
  final ElectronicCommercListModel model;

  ElectronicCommercCard({Key? key, required this.model}) : super(key: key);

  @override
  _ElectronicCommercCardState createState() => _ElectronicCommercCardState();
}

class _ElectronicCommercCardState extends State<ElectronicCommercCard> {
  @override
  Widget build(BuildContext context) {
    return _buildCard(widget.model);
  }

  _buildCard(ElectronicCommercListModel model) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        Get.to(() => ElectronicCommercDetailPage(id: model.id));
      },
      padding: EdgeInsets.zero,
      child: Container(
        height: 248.w,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.title),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: ktextSubColor,
                      fontSize: 20.sp,
                    ),
                    child: Row(
                      children: [
                        // Text('测试'),
                        Spacer(),
                        Text('发布于 ${DateUtil.formatDateStr(
                          model.createDate,
                          format: 'yyyy-MM-dd HH:mm',
                        )}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            32.w.widthBox,
            FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              width: 240.w,
              height: 200.w,
              fit: BoxFit.cover,
              image: SARSAPI.image(ImgModel.first(model.imgList)),
            ),
          ],
        ),
      ),
    );
  }
}
