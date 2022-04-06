import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/models/message/reply_list_model.dart';
import 'package:aku_new_community/pages/message_center_page/message_func.dart';
import 'package:aku_new_community/ui/community/community_views/event_detail_page.dart';
import 'package:aku_new_community/widget/beeImageNetwork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ReplyCard extends StatelessWidget {
  final ReplyListModel model;

  const ReplyCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await MessageFunc.readMessage(model.id);
        Get.to(() => EventDetailPage(
          dynamicId: model.jumpId,
          onDelete: (){

          },
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.w),
        color: Colors.white,
        child: Row(
          children: [
            ClipOval(
              child: BeeImageNetwork(
                urls: [model.avatar],
                width: 100.w,
                height: 100.w,
              ),
            ),
            24.w.widthBox,
            SizedBox(
              width: 350.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  model.sendName.text.size(26.sp).black.bold.make(),
                  5.heightBox,
                  model.content.text
                      .size(26.sp)
                      .color(ktextSubColor)
                      .maxLines(1)
                      .ellipsis
                      .make(),
                  5.heightBox,
                  model.sendDate.text.size(22.sp).color(ktextSubColor).make(),
                ],
              ),
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(9.w),
              child: BeeImageNetwork(
                urls: [model.pic],
                width: 128.w,
                height: 128.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
