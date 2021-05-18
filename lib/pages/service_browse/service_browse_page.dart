import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:aku_community/extensions/widget_list_ext.dart';

class ServiceBrowsePage extends StatefulWidget {
  ServiceBrowsePage({Key? key}) : super(key: key);

  @override
  _ServiceBrowsePageState createState() => _ServiceBrowsePageState();
}

class _ServiceBrowsePageState extends State<ServiceBrowsePage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '服务浏览',
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12.w),
        children: [
          _buildCard(
              '小区绿化服务范围及工作范畴',
              '随着城市建设的发展，人们对生活环境的要求越来越高，越来越重视小区的园林绿化建设，绿化养护作为一项长期性工作，需要有科学的计划和正确的实施方法，同时要求园林人扎实做好......',
              '南宁人才公寓',
              ' 04-13 09:46'),
        ].sepWidget(separate: 12.w.heightBox),
      ),
    );
  }

  Widget _buildCard(String title, String content, String name, String date) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title.text
                .size(32.sp)
                .color(ktextPrimary)
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .bold
                .make(),
            32.w.heightBox,
            content.text
                .size(24.sp)
                .color(ktextSubColor)
                .maxLines(3)
                .overflow(TextOverflow.ellipsis)
                .make(),
            32.w.heightBox,
            Row(
              children: [
                name.text.size(20.sp).color(ktextSubColor).make(),
                Spacer(),
                '发布于 ${DateUtil.formatDateStr(date, format: 'MM-dd HH:mm')}'
                    .text
                    .size(20.sp)
                    .color(ktextSubColor)
                    .make(),
              ],
            ),
          ],
        ));
  }
}
