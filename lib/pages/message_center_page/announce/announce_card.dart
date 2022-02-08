import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/models/message/announce_list_model.dart';
import 'package:aku_new_community/pages/message_center_page/announce/announce_view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AnnounceCard extends StatelessWidget {
  final ListDateModel modelList;
  final int index;
  const AnnounceCard({
    Key? key,
    required this.modelList,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 98.w,
          child: modelList.month.text.size(36.sp).black.make(),
        ),
        ...modelList.models
            .map((e) => _card(e))
            .toList()
            .sepWidget(separate: 10.heightBox)
      ],
    );
  }

  Widget _card(AnnounceListModel model) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '${DateUtil.formatDateStr(model.date, format: 'dd日 HH:mm')}'
              .text
              .size(28.sp)
              .color(ktextSubColor)
              .make(),
          32.w.heightBox,
          '${model.title}'.text.size(36.sp).black.bold.make(),
          32.w.heightBox,
          '${model.content}'.text.size(28.sp).color(ktextSubColor).make(),
          40.w.heightBox,
          Container(
            height: 72.w,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF000000).withOpacity(0.06),
                ),
              ),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  '查看详情'.text.size(24.w).color(ktextSubColor).make(),
                  Spacer(),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 20.w,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
