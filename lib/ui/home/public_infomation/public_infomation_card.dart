import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/models/community/information_list_model.dart';
import 'package:aku_new_community/ui/home/public_infomation/public_information_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/beeImageNetwork.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicInfomationCard extends StatelessWidget {
  final InformationListModel model;

  const PublicInfomationCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        Get.to(() => PublicInformationDetailPage(id: this.model.id));
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
                        Text('发布于 ${DateUtil.formatDate(
                          model.createDateDT,
                          format: 'yyyy-MM-dd HH:mm',
                        )}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            32.wb,
            BeeImageNetwork(
              width: 240.w,
              height: 200.w,
              imgs: model.imgList,
            ),
          ],
        ),
      ),
    );
  }
}
