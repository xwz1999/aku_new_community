import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/message/reply_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class thumbs_up_card extends StatelessWidget {
  final ReplyListModel model;

  const thumbs_up_card({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.w),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              API.image(model.img.url),
              width: 100.w,
              height: 100.w,
            ),
          ),
          24.w.widthBox,
          SizedBox(
            width: 350.w,
            child: Column(
              children: [
                model.name.text.size(26.sp).black.bold.make(),
                Assets.icons.communityLikeIs
                    .image(width: 28.w, height: 28.w, fit: BoxFit.contain),
                model.date.text.size(24.sp).color(ktextSubColor).make(),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(9.w),
            child: Image.network(
              API.image(model.pic.url),
              width: 128.w,
              height: 128.w,
            ),
          ),
        ],
      ),
    );
  }
}
