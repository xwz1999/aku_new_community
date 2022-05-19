import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/models/bracelet/bracelet_list_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

import 'add_equipment_page.dart';

class EquipmentListPage extends StatefulWidget {
  const EquipmentListPage({Key? key}) : super(key: key);

  @override
  _EquipmentListPageState createState() => _EquipmentListPageState();
}

class _EquipmentListPageState extends State<EquipmentListPage> {
  BraceletListModel? _currentBracelet;
  List<BraceletListModel> _bracelets = [];

  @override
  Widget build(BuildContext context) {
    var user = Padding(
      padding: EdgeInsets.only(left: 24.w, bottom: 24.w, right: 24.w),
      child: Row(
        children: [
          // CircleAvatar(
          //   child: Image.network(
          //       UserTool.userProvider.userInfoModel?.imgUrls.first.url ?? ''),
          // ),
          24.w.widthBox,
          '陈东强'.text.size(28.sp).color(Colors.black).make(),
          Spacer(),
          '切换用户'.text.size(24.sp).color(Colors.black.withOpacity(0.65)).make(),
          24.w.widthBox,
          Icon(
            CupertinoIcons.chevron_right,
            size: 20.w,
          ),
        ],
      ),
    );
    var connected = Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '当前连接'
              .text
              .size(24.sp)
              .color(Colors.black.withOpacity(0.65))
              .bold
              .make(),
          24.w.heightBox,
          if (_currentBracelet != null)
            _braceletWidget(e: _currentBracelet!, bgColor: Color(0xFF6395D7))
        ],
      ),
    );
    var bingding = Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '已绑定设备'
              .text
              .size(24.sp)
              .color(Colors.black.withOpacity(0.65))
              .bold
              .make(),
          24.w.heightBox,
          ..._bracelets
              .map((e) => _braceletWidget(
                  e: e,
                  onTap: () {
                    _currentBracelet = e;
                    setState(() {});
                  }))
              .toList()
              .sepWidget(
                separate: 24.w.heightBox,
              ),
        ],
      ),
    );
    return BeeScaffold(
      title: '设备列表',
      bodyColor: Colors.white,
      body: SafeArea(
        child: EasyRefresh(
          firstRefresh: true,
          header: MaterialHeader(),
          onRefresh: () async {
            var base = await NetUtil().get(SAASAPI.bracelet.list);
            if (base.success) {
              _bracelets = (base.data as List)
                  .map((e) => BraceletListModel.fromJson(e))
                  .toList();
              setState(() {});
            }
          },
          child: ListView(
            padding: EdgeInsets.all(24.w),
            children: [
              // user,
              // BeeDivider.horizontal(),
              connected,
              24.w.heightBox,
              bingding,
              BeeDivider.horizontal(),
              // 24.w.heightBox,
            ],
          ),
        ),
      ),
      bottomNavi: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
        child: MaterialButton(
          onPressed: () {
            Get.to(() => AddEquipmentPage());
          },
          color: Color(0xFF5096F1),
          padding: EdgeInsets.symmetric(vertical: 24.w),
          minWidth: 686.w,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: '添加设备'.text.size(28.sp).white.make(),
        ),
      ),
    );
  }

  Widget _braceletWidget(
      {required BraceletListModel e, VoidCallback? onTap, Color? bgColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
            color: bgColor ?? Colors.black.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16.w)),
        child: Row(
          children: [
            Image.asset(
              e.braceletBrand.imgPath,
              width: 100.w,
              height: 100.w,
            ),
            12.w.widthBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                '${e.deviceType}  ${e.braceletBrand.name}'
                    .text
                    .size(24.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
                16.w.heightBox,
                '设备码：${e.imei}'
                    .text
                    .size(24.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
              ],
            ),
            Spacer(),
            Container(
              width: 15.w,
              height: 16.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(16.w),
              ),
            ),
            24.w.widthBox,
            '${UserTool.oldAgeProvider.imei == e.imei ? '已连接' : '未开启'}'
                .text
                .size(24.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
          ],
        ),
      ),
    );
  }
}
