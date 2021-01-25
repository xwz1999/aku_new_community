import 'package:akuCommunity/model/manager/suggestion_or_complain_model.dart';
import 'package:akuCommunity/ui/manager/advice/advice_detail_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/views/horizontal_image_view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.zero,
      color: Colors.white,
      onPressed: AdviceDetailPage(model: widget.model).to,
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
        ],
      ),
    );
  }
}
