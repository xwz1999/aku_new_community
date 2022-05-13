import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/message/reply_list_model.dart';
import 'package:aku_new_community/models/message/thumbs_up_list_model.dart';
import 'package:aku_new_community/pages/message_center_page/message_func.dart';
import 'package:aku_new_community/widget/bee_image_network.dart';

class ThumbsUpCard extends StatelessWidget {
  final ReplyListModel model;

  const ThumbsUpCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await MessageFunc.readMessage(model.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.w),
        color: Colors.white,
        child: Row(
          children: [
            ClipOval(
              child: BeeImageNetwork(
                imgs: model.avatarImgList,
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
                  Assets.icons.communityLikeIs
                      .image(width: 28.w, height: 28.w, fit: BoxFit.contain),
                  5.heightBox,
                  model.sendDate.text.size(24.sp).color(ktextSubColor).make(),
                ],
              ),
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(9.w),
              child: BeeImageNetwork(
                imgs: model.dynamicImgList,
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
