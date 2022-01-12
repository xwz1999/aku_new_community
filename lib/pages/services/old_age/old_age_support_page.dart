import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/widget/bee_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

@Deprecated('第一版带图表，暂时不做')
class OldAgeSupportPage extends StatefulWidget {
  const OldAgeSupportPage({Key? key}) : super(key: key);

  @override
  _OldAgeSupportPageState createState() => _OldAgeSupportPageState();
}

class _OldAgeSupportPageState extends State<OldAgeSupportPage> {
  @override
  Widget build(BuildContext context) {
    var date = Row(
      children: [
        Container(
          height: 52.w,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(52.w),
              color: Colors.white.withOpacity(0.25)),
          child: '数据更新自 2022年1月1日 18:21:15'
              .text
              .size(26.sp)
              .color(Colors.black.withOpacity(0.85))
              .make(),
        ),
      ],
    );
    var data = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        10.w.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '58 %'
                .text
                .size(40.sp)
                .color(Colors.black.withOpacity(0.85))
                .make(),
            '剩余电量'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.65))
                .make(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.circle_fill,
                  size: 12.sp,
                  color: Color(0xFF57DAD2),
                ),
                4.w.widthBox,
                '设备 已开机'
                    .text
                    .size(22.sp)
                    .lineHeight(1.2)
                    .color(Colors.black.withOpacity(0.45))
                    .make()
              ],
            )
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '检测天数'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.45))
                .make(),
            '58'
                .richText
                .withTextSpanChildren([
                  ' 天'
                      .textSpan
                      .size(22.sp)
                      .color(Colors.black.withOpacity(0.45))
                      .make(),
                ])
                .size(56.sp)
                .color(Color(0xFF17928A))
                .make()
          ],
        ),
        80.w.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '报警次数'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.45))
                .make(),
            '5'
                .richText
                .withTextSpanChildren([
                  ' 次'
                      .textSpan
                      .size(22.sp)
                      .color(Colors.black.withOpacity(0.45))
                      .make(),
                ])
                .size(56.sp)
                .color(Color(0xFFF5222D))
                .make()
          ],
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: 'x5手环'.text.size(32.sp).black.make(),
        backgroundColor: Colors.transparent,
        leading: BeeBackButton(),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.repeat),
            iconSize: 24.w,
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(Assets.static.oldAgeBack.path))),
        child: SafeArea(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          children: [
            38.w.heightBox,
            date,
            48.w.heightBox,
            data,
            50.w.heightBox,
            Container(
              width: 331.w,
              height: 204.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.w)),
              child: Column(
                children: [],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
