import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/src/extensions/iterable_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/utils/application_utils.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class AllApplicationNewPage extends StatefulWidget {
  const AllApplicationNewPage({Key? key}) : super(key: key);

  @override
  _AllApplicationNewPageState createState() => _AllApplicationNewPageState();
}

class _AllApplicationNewPageState extends State<AllApplicationNewPage> {
  List<String> rootTypes = ['物业服务', '出行安全', '居民生活', '关于社区', '智慧服务', '附近市场'];

  List<String> getApplications(int index) {
    switch (index) {
      case 0:
        return ['报事报修', '设施预约', '生活缴费', '装修管理'];
      case 1:
        return [
          '开门码',
          '物品出门',
          '地理信息',
          '小蜜蜂任务',
        ];
      case 2:
        return ['便民电话', '问卷调查', '活动投票', '快递包裹', '投诉表扬', '业委会', '社区介绍', '借还管理'];
      case 3:
        return ['服务浏览', '周边企业', '住房说明', '电子商务'];
      case 4:
        return Platform.isIOS?['任务发布', '周边服务', '共享投屏']:['智慧养老', '任务发布', '周边服务', '共享投屏'];
      case 5:
        return ['自营商城', '邻家宠物', '共享停车', '二手市场'];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
        title: '全部应用',
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
          children: rootTypes
              .mapIndexed((e, index) => _applicationTile(index))
              .toList()
              .sepWidget(separate: 16.hb),
        ));
  }

  Container _applicationTile(int index) {
    return Container(
      width: 686.w,
      padding: EdgeInsets.only(top: 32.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 32.w, bottom: 24.w),
            child: rootTypes[index]
                .text
                .size(32.sp)
                .color(Color(0xFF2B2B2B))
                .bold
                .make(),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: NeverScrollableScrollPhysics(),
            children: ApplicationUtil(getApplications(index))
                .elements
                .map((e) => applicationItem(e))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget applicationItem(AppElement appElement) {
    return GestureDetector(
      onTap: appElement.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            appElement.imgPath,
            width: 96.w,
            height: 96.w,
          ),
          8.hb,
          appElement.title.text.size(24.sp).color(Color(0xFF333333)).make(),
        ],
      ),
    );
  }
}
