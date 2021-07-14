import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/models/house_keeping/house_keeping_list_model.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/views/bee_grid_image_view.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class HouseKeepingDetailPage extends StatefulWidget {
  final HouseKeepingListModel model;
  HouseKeepingDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _HouseKeepingDetailPageState createState() => _HouseKeepingDetailPageState();
}

class _HouseKeepingDetailPageState extends State<HouseKeepingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '服务详情',
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.w),
        children: [
          _buildInfo(),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 24.w),
      child: Column(
        children: [
          Row(
            children: [
              '服务信息'.text.size(36.sp).bold.black.make(),
              Spacer(),
              widget.model.statusString.text
                  .size(32.sp)
                  .color(widget.model.statusColor)
                  .make()
            ],
          ),
          40.w.heightBox,
          _buildTile(R.ASSETS_ICONS_ARTICLE_COUNT_PNG, '申请人',
              widget.model.proposerName),
          16.w.heightBox,
          _buildTile(
              R.ASSETS_ICONS_PHONE_PNG, '联系电话', widget.model.proposerTel),
          16.w.heightBox,
          _buildTile(R.ASSETS_ICONS_APPOINTMENT_ADDRESS_PNG, '地址',
              '${S.of(context)!.tempPlotName}·${widget.model.roomName}'),
          56.w.heightBox,
          BeeGridImageView(
              urls: widget.model.submitImgList.map((e) => e.url).toList()),
        ],
      ),
    );
  }

  Widget _buildTile(String iconPath, String title, String suffix) {
    return Row(
      children: [
        Image.asset(
          iconPath,
          width: 40.w,
          height: 40.w,
        ),
        8.w.widthBox,
        title.text.size(28.sp).color(ktextSubColor).make(),
        Spacer(),
        suffix.text.size(28.sp).black.make(),
      ],
    );
  }

  Widget _buidProcess() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 24.w),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              '服务进程'.text.size(36.sp).bold.black.make(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buidProcessTile(String title, DateTime date) {
    return Row(children: [
      title.text.size(28.sp).color(ktextSubColor).make(),
      Spacer(),
      '${DateUtil.formatDate(date, format: 'yyyy-MM-dd HH:mm:ss')}'
          .text
          .size(28.sp)
          .black
          .make(),
    ]);
  }
}
