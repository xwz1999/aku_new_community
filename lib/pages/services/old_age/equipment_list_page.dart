import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/pages/services/old_age/add_equipment_page.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class bracelet {
  String title;
  String describe;
  bool open;
  String path;

  bracelet({
    required this.title,
    required this.describe,
    required this.open,
    required this.path,
  });
}

class EquipmentListPage extends StatefulWidget {
  const EquipmentListPage({Key? key}) : super(key: key);

  @override
  _EquipmentListPageState createState() => _EquipmentListPageState();
}

class _EquipmentListPageState extends State<EquipmentListPage> {
  List<bracelet> _connects = [
    bracelet(
        title: 'x5手环',
        describe: '爱牵挂',
        open: true,
        path: Assets.bracelet.x5.path),
  ];
  List<bracelet> _bracelets = [
    bracelet(
        title: 'x8手环 旗舰型',
        describe: '爱牵挂',
        open: false,
        path: Assets.bracelet.x8.path),
  ];

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
          ..._connects
              .map((e) => Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                        color: Color(0xFF6395D7),
                        borderRadius: BorderRadius.circular(16.w)),
                    child: Row(
                      children: [
                        Image.asset(
                          e.path,
                          width: 100.w,
                          height: 100.w,
                        ),
                        12.w.widthBox,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            '${e.title}'.text.size(24.sp).white.make(),
                            16.w.heightBox,
                            '${e.describe}'.text.size(24.sp).white.make(),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 15.w,
                          height: 16.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.w),
                          ),
                        ),
                        24.w.widthBox,
                        '${e.open ? '已连接' : '未开启'}'
                            .text
                            .size(24.sp)
                            .white
                            .make(),
                      ],
                    ),
                  ))
              .toList()
              .sepWidget(separate: 24.w.heightBox),
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
              .map((e) => Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(16.w)),
                    child: Row(
                      children: [
                        Image.asset(
                          e.path,
                          width: 100.w,
                          height: 100.w,
                        ),
                        12.w.widthBox,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            '${e.title}'
                                .text
                                .size(24.sp)
                                .color(Colors.black.withOpacity(0.65))
                                .make(),
                            16.w.heightBox,
                            '${e.describe}'
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
                        '${e.open ? '已连接' : '未开启'}'
                            .text
                            .size(24.sp)
                            .color(Colors.black.withOpacity(0.65))
                            .make(),
                      ],
                    ),
                  ))
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Get.to(() => AddEquipmentPage());
                  },
                  child: '添加智能设备'
                      .text
                      .size(28.sp)
                      .color(Color(0xFF6395D7))
                      .make()),
            ],
          )
        ],
      )),
    );
  }
}
