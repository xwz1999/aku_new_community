import 'package:flutter/material.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/models/facility/facility_type_model.dart';
import 'package:aku_community/utils/headers.dart';

class FacilityTypeCard extends StatelessWidget {
  final FacilityTypeModel model;
  const FacilityTypeCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
            image: API.image(ImgModel.first(model.imgUrls)),
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
              MaterialButton(
                height: 52.w,
                minWidth: 168.w,
                padding: EdgeInsets.zero,
                elevation: 0,
                shape: StadiumBorder(),
                color: kPrimaryColor,
                onPressed: () {},
                child: Text(
                  '填写预约',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.sp,
                  ),
                ),
              ),
              32.wb,
            ],
          ),
          24.hb,
        ],
      ),
      onPressed: () {},
    );
  }
}
