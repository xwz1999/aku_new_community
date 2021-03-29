import 'package:flutter/material.dart';

import 'package:flustars/flustars.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/model/manager/suggestion_or_complain_model.dart';
import 'package:akuCommunity/ui/manager/advice/advice_detail_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/views/horizontal_image_view.dart';

class AdviceCard extends StatefulWidget {
  final SuggestionOrComplainModel model;
  AdviceCard({Key key, this.model}) : super(key: key);

  @override
  _AdviceCardState createState() => _AdviceCardState();
}

class _AdviceCardState extends State<AdviceCard> {
  ///1.未反馈，2.反馈中，3.已反馈
  String get statusValue => {
        1: '未反馈',
        2: '反馈中',
        3: '已反馈',
      }[widget.model.status];

  Widget _buildRating() {
    if (widget.model.score == null)
      return SizedBox();
    else
      return [
        120.hb,
        24.wb,
        '评测得分'.text.size(32.sp).color(ktextSubColor).make(),
        Spacer(),
        RatingBarIndicator(
          itemBuilder: (context, index) => Icon(
            Icons.star_rounded,
            color: kPrimaryColor,
          ),
          rating: widget.model.score / 2,
          itemSize: 40.w,
        ),
        24.wb,
      ].row();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.zero,
      color: Colors.white,
      onPressed: () => Get.to(() => AdviceDetailPage(model: widget.model)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.hb,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateUtil.formatDate(
                widget.model.createDate,
                format: 'yyyy年MM月dd日',
              ).text.size(32.sp).black.bold.make(),
              statusValue.text.size(24.sp).color(Color(0xFFFF8200)).make(),
            ],
          ).pSymmetric(h: 28.w),
          Divider(
            indent: 28.w,
            endIndent: 28.w,
            height: 50.w,
            thickness: 1.w,
            color: Color(0xFFE8E8E8),
          ),
          widget.model.content.text.size(28.w).black.make().pSymmetric(h: 28.w),
          HorizontalImageView(widget.model.imgUrls.map((e) => e.url).toList()),
          widget.model.score == null
              ? SizedBox()
              : Divider(
                  indent: 32.w,
                  endIndent: 32.w,
                ),
          _buildRating(),
        ],
      ),
    );
  }
}
