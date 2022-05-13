import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/facility/facility_type_model.dart';
import 'package:aku_new_community/ui/community/facility/facility_preorder_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'facility_type_detail_page.dart';

class FacilityTypeCard extends StatelessWidget {
  final FacilityTypeModel model;

  const FacilityTypeCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      padding: EdgeInsets.all(30.w),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(10.w),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: FadeInImage.assetNetwork(
              placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              image: SAASAPI.image(ImgModel.first(model.imgUrls)),
              height: 280.w,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          24.hb,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                    15.hb,
                    '${model.type==1?'设备数量':'设施数量'} ${model.num_}'
                        .text
                        .size(15.sp)
                        .color(BaseStyle.color4a4b51.withOpacity(0.45))
                        .make(),
                    // Row(
                    //   children: [
                    //     Text(
                    //       '开放时段',
                    //       style: TextStyle(
                    //         color: ktextSubColor,
                    //         fontSize: 22.sp,
                    //       ),
                    //     ),
                    //     Text(
                    //       '${model.startDateStr}-${model.endDateStr}',
                    //       style: TextStyle(
                    //         fontSize: 22.sp,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              32.wb,
            ],
          ),
        ],
      ),
      onPressed: () {
        Get.off(() => FacilityTypeDetailPage(facilityModel: model,));
      },
    );
  }
}
