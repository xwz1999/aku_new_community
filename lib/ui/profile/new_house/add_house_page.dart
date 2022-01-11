import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AddHousePage extends StatefulWidget {
  const AddHousePage({Key? key}) : super(key: key);

  @override
  _AddHousePageState createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  @override
  Widget build(BuildContext context) {
    var identify = Padding(
      padding: EdgeInsets.only(bottom: 24.w),
      child: Row(
        children: [
          SizedBox(
            width: 170.w,
            child: '认证身份'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                BotToast.showText(text: 'text');
              },
              child: Material(
                color: Colors.transparent,
                child: Row(
                  children: [
                    '业主'
                        .text
                        .size(28.sp)
                        .color(Colors.black.withOpacity(0.65))
                        .make(),
                    Spacer(),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 20.w,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    var name = Padding(
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: Row(
        children: [
          SizedBox(
            width: 170.w,
            child: '姓名'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
          ),
          Expanded(
            child: Row(
              children: [
                '${UserTool.userProvider.userInfoModel!.name}'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
              ],
            ),
          ),
        ],
      ),
    );
    var code = Padding(
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: Row(
        children: [
          SizedBox(
            width: 170.w,
            child: '身份证号'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
          ),
          Expanded(
            child: Row(
              children: [
                '${UserTool.userProvider.userInfoModel!.idCard}'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
              ],
            ),
          ),
        ],
      ),
    );
    var tel = Padding(
      padding: EdgeInsets.only(top: 24.w),
      child: Row(
        children: [
          SizedBox(
            width: 170.w,
            child: '手机号'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
          ),
          Expanded(
            child: Row(
              children: [
                '${UserTool.userProvider.userInfoModel!.tel}'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.65))
                    .make(),
              ],
            ),
          ),
        ],
      ),
    );
    return BeeScaffold(
      title: '身份认证',
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        children: [
          Container(
            width: 686.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
                  child: '身份信息'.text.size(32.sp).black.bold.make(),
                ),
                BeeDivider.horizontal(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      identify,
                      BeeDivider.horizontal(),
                      name,
                      BeeDivider.horizontal(),
                      code,
                      BeeDivider.horizontal(),
                      tel
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
