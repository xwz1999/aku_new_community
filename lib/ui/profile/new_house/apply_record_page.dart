import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/sars_model/my_house/my_house_apply_record_list_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/tag/bee_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class ApplyRecordPage extends StatefulWidget {
  const ApplyRecordPage({Key? key}) : super(key: key);

  @override
  _ApplyRecordPageState createState() => _ApplyRecordPageState();
}

class _ApplyRecordPageState extends State<ApplyRecordPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的房屋申请',
      body: SafeArea(
          child: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {
          var base = await NetUtil().get(SARSAPI.profile.house.applyRecord);
          if (base.success) {}
        },
        onLoad: () async {},
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
          children: [],
        ),
      )),
    );
  }

  Widget _houseCard(MyHouseApplyRecordListModel model) {
    return Stack(
      children: [
        Container(
          width: 686.w,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
          child: Column(
            children: [
              Row(
                children: [
                  '${model.addressName}  ${model.communityName}'
                      .text
                      .size(24.sp)
                      .color(Colors.black.withOpacity(0.65))
                      .make(),
                ],
              ),
              8.w.heightBox,
              Row(
                children: [
                  '${model.buildingName}${model.unitName}${model.estateName}'
                      .text
                      .size(36.sp)
                      .color(Colors.black.withOpacity(0.85))
                      .make(),
                  24.w.widthBox,
                  BeeTag.yellowSolid(text: '${model.manageEstateTypeName}')
                ],
              ),
              24.w.heightBox,
              BeeDivider.horizontal(),
              24.w.heightBox,
              Row(
                children: [
                  BeeTag.yellowHollow(text: '${model.manageEstateTypeName}'),
                  10.w.widthBox,
                  '${model.name}  ${model.tel}'
                      .text
                      .size(24.sp)
                      .color(Colors.black.withOpacity(0.65))
                      .make(),
                ],
              )
            ],
          ),
        ),
        Positioned(child: Image.asset(_getStatusIconPath(model.status))),
      ],
    );
  }

  String _getStatusIconPath(int status) {
    switch (status) {
      case 1:
        return Assets.icons.examining.path;
      case 2:
        return Assets.icons.reject.path;
      case 3:
        return Assets.icons.pass.path;
      default:
        return '';
    }
  }
}