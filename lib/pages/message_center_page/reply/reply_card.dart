import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/message/reply_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ReplyCard extends StatelessWidget {
  final ReplyListModel model;

  const ReplyCard({Key? key, required this.model}) : super(key: key);

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
                model.title.text.size(26.sp).black.bold.make(),
                model.content.text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .maxLines(1)
                    .ellipsis
                    .make(),
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
