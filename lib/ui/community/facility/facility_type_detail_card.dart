import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import '../../../models/facility/facility_type_detail_model.dart';
import '../../../models/facility/facility_type_model.dart';
import 'facility_preorder_page.dart';

class FacilityTypeDetailCard extends StatelessWidget {
  final FacilityTypeDetailModel model;
  final FacilityTypeModel facilityModel;

  const FacilityTypeDetailCard(
      {Key? key, required this.model, required this.facilityModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      padding: EdgeInsets.all(30.w),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Material(
                borderRadius: BorderRadius.circular(10.w),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child:FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  image: SAASAPI.image(ImgModel.first(model.imgList)),
                  height: 150.h,
                  width: 200.w,
                  fit: BoxFit.cover,
                ),
              ),
              30.wb,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  15.hb,
                  '${DateUtil.formatDate(model.openStartDT,format: 'HH:mm')}-${DateUtil.formatDate(model.openEndDT,format: 'HH:mm')}  开放'
                      .text
                      .size(20.sp)
                      .make(),
                  12.hb,
                  '${model.address}'
                      .text
                      .size(20.sp)
                      .color(BaseStyle.color474747)
                      .make(),
                ],
              ),
            ],
          ),
        ],
      ),
      onPressed: () {
        Get.off(() => FacilityPreorderPage(
          facilityModel: facilityModel,
              typeModel: model,
            ));
      },
    );
  }
}
