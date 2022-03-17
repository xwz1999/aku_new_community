import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/facility/facility_type_model.dart';
import 'package:aku_new_community/ui/community/facility/facility_preorder_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityTypeCard extends StatelessWidget {
  final FacilityTypeModel model;

  const FacilityTypeCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            image: SAASAPI.image(ImgModel.first(model.imgUrls)),
            height: 320.w,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          24.hb,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              32.wb,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    32.hb,
                    Row(
                      children: [
                        Text(
                          '开放时段',
                          style: TextStyle(
                            color: ktextSubColor,
                            fontSize: 22.sp,
                          ),
                        ),
                        Text(
                          '${model.startDateStr}-${model.endDateStr}',
                          style: TextStyle(
                            fontSize: 22.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              32.wb,
            ],
          ),
          24.hb,
        ],
      ),
      onPressed: () {
        Get.off(() => FacilityPreorderPage(id: model.id));
      },
    );
  }
}
