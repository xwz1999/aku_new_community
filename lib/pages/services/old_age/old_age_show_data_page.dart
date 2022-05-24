import 'dart:async';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/bracelet/bracelet_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OldAgeShowDataPage extends StatefulWidget {
  final String imei;

  const OldAgeShowDataPage({Key? key, required this.imei}) : super(key: key);

  @override
  _OldAgeShowDataPageState createState() => _OldAgeShowDataPageState();
}

class _OldAgeShowDataPageState extends State<OldAgeShowDataPage> {
  BraceletModel? _model;
  DateTime? _date;

  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _date = DateTime.now();
      getData();
    });
  }

  void _disposeTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future getData() async {
    BaseModel base = await NetUtil().get(SAASAPI.bracelet.data, params: {
      'imei': widget.imei,
    });
    if (base.data != null) {
      _model = BraceletModel.fromJson(base.data);
      _date = DateTime.now();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var cancel = BotToast.showLoading();
      await getData();
      cancel();
      _startTimer();
    });
  }

  @override
  void dispose() {
    BotToast.closeAllLoading();
    _disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var open = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.circle_fill,
          size: 16.w,
          color: Color(0xFF57DAD2),
        ),
        4.w.widthBox,
        '设备 ${_model?.switchTypeString}'
            .text
            .size(26.sp)
            .lineHeight(1.2)
            .color(Colors.black.withOpacity(0.45))
            .make(),
      ],
    );
    return BeeScaffold(
      title: 'X5手环',
      extendBody: true,
      // actions: [
      //   IconButton(
      //     icon: Icon(CupertinoIcons.repeat),
      //     iconSize: 30.w,
      //     color: Colors.black,
      //     onPressed: () {
      //       Get.to(() => EquipmentListPage());
      //     },
      //   )
      // ],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage(Assets.static.braceletHeader.path)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFFC0E5DC).withOpacity(0.355)]),
        ),
        child: _model == null
            ? Container()
            : SafeArea(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  children: [
                    400.w.heightBox,
                    open,
                    16.w.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        '数据更新自 ${DateUtil.formatDate(_date!, format: DateFormats.full)}'
                            .text
                            .size(22.sp)
                            .color(Colors.black.withOpacity(0.25))
                            .make(),
                        40.w.heightBox,
                      ],
                    ),
                    40.w.heightBox,
                    overview(),
                    24.w.heightBox,
                    statusCard(),
                    40.w.heightBox,
                    bottomCard(),
                    40.w.heightBox,
                  ],
                ),
              ),
      ),
    );
  }

  Container bottomCard() {
    var left = Column(
      children: [
        Row(
          children: [
            Assets.icons.bloodRessure.image(width: 40.w, height: 40.w),
            '血压监督'
                .text
                .size(26.sp)
                .bold
                .color(Colors.black.withOpacity(0.85))
                .make(),
          ],
        )
      ],
    );
    var mid = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '${_model?.sbp}'
            .richText
            .withTextSpanChildren([])
            .size(48.sp)
            .bold
            .color(_model!.sbpNormal ? Color(0xFF37C6BD) : Colors.red)
            .make(),
        8.w.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            16.w.heightBox,
            ' mmhg'
                .text
                .size(22.sp)
                .color(Colors.black.withOpacity(0.25))
                .make(),
            Spacer(),
            '收缩压'.text.size(22.sp).color(Colors.black.withOpacity(0.65)).make(),
            Spacer(),
            '90-139'
                .text
                .size(20.sp)
                .color(Colors.black.withOpacity(0.25))
                .make(),
          ],
        ),
      ],
    );
    var right = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '${_model?.dbp}'
            .richText
            .withTextSpanChildren([])
            .size(48.sp)
            .bold
            .color(_model!.dbpNormal ? Color(0xFF37C6BD) : Colors.red)
            .make(),
        8.w.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            16.w.heightBox,
            ' mmhg'
                .text
                .size(22.sp)
                .color(Colors.black.withOpacity(0.25))
                .make(),
            Spacer(),
            '舒张压'.text.size(22.sp).color(Colors.black.withOpacity(0.65)).make(),
            Spacer(),
            '60-89'
                .text
                .size(20.sp)
                .color(Colors.black.withOpacity(0.25))
                .make(),
          ],
        ),
      ],
    );
    return Container(
      width: double.infinity,
      height: 164.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: Row(
        children: [
          32.w.widthBox,
          left,
          Spacer(),
          mid,
          32.w.widthBox,
          right,
          24.w.widthBox,
        ],
      ),
    );
  }

  Column statusCard() {
    var heart = Container(
      width: 331.w,
      height: 204.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.heartbeat.image(width: 40.w, height: 40.w),
              8.w.widthBox,
              '心率'
                  .text
                  .size(26.sp)
                  .bold
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
            ],
          ),
          Spacer(),
          '${_model?.heartRate}'
              .richText
              .withTextSpanChildren([
                ' 次/分'
                    .textSpan
                    .size(22.sp)
                    .color(Colors.black.withOpacity(0.25))
                    .make()
              ])
              .size(56.sp)
              .bold
              .color(_model!.heartNormal ? Color(0xFF37C6BD) : Colors.red)
              .make(),
          Spacer(),
          '正常为60-100次/分'
              .text
              .size(20.sp)
              .color(Colors.black.withOpacity(0.25))
              .make()
        ],
      ),
    );
    var fallDown = Container(
      width: 331.w,
      height: 204.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.falldown.image(width: 40.w, height: 40.w),
              8.w.widthBox,
              '跌倒次数'
                  .text
                  .size(26.sp)
                  .bold
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
            ],
          ),
          Spacer(),
          '${_model?.fallNums}'
              .richText
              .withTextSpanChildren([
                ' 次'
                    .textSpan
                    .size(22.sp)
                    .color(Colors.black.withOpacity(0.25))
                    .make()
              ])
              .size(56.sp)
              .bold
              .color(Colors.red)
              .make(),
          Spacer(),
          '如跌倒会报警至物业后台'
              .text
              .size(20.sp)
              .color(Colors.black.withOpacity(0.25))
              .make()
        ],
      ),
    );
    var footSteps = Container(
      width: 331.w,
      height: 176.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.foot.image(width: 40.w, height: 40.w),
              8.w.widthBox,
              '今日步数'
                  .text
                  .size(26.sp)
                  .bold
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
            ],
          ),
          Spacer(),
          '${_model?.todaySteps}'
              .richText
              .withTextSpanChildren([
                ' 步'
                    .textSpan
                    .size(22.sp)
                    .color(Colors.black.withOpacity(0.25))
                    .make()
              ])
              .size(56.sp)
              .bold
              .color(Color(0xFF37C6BD))
              .make(),
        ],
      ),
    );
    var blood = Container(
      width: 331.w,
      height: 176.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.oxygen.image(width: 40.w, height: 40.w),
              8.w.widthBox,
              '血氧饱和度'
                  .text
                  .size(26.sp)
                  .bold
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
            ],
          ),
          Spacer(),
          Row(
            children: [
              '${_model?.bloodOxygen}'
                  .richText
                  .withTextSpanChildren([
                    ' %'
                        .textSpan
                        .size(22.sp)
                        .color(Colors.black.withOpacity(0.25))
                        .make()
                  ])
                  .size(56.sp)
                  .bold
                  .color(_model!.bloodOxygen >= 95
                      ? Color(0xFF37C6BD)
                      : Colors.red)
                  .make(),
              Spacer(),
              '正常为95%以上'
                  .text
                  .size(22.sp)
                  .color(Colors.black.withOpacity(0.25))
                  .make(),
            ],
          ),
        ],
      ),
    );
    return Column(
      children: [
        Row(
          children: [heart, 24.w.widthBox, fallDown],
        ),
        40.w.heightBox,
        Row(
          children: [footSteps, 24.w.widthBox, blood],
        )
      ],
    );
  }

  Container overview() {
    var left = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '剩余电量'.text.size(28.sp).color(Colors.black.withOpacity(0.65)).make(),
          '${_model?.remainingPower ?? 0}'
              .richText
              .withTextSpanChildren([
                ' %'
                    .textSpan
                    .size(22.sp)
                    .color(Colors.black.withOpacity(0.25))
                    .make(),
              ])
              .size(56.sp)
              .bold
              .color(Colors.black.withOpacity(0.85))
              .make(),
        ],
      ),
    );
    var mid = Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '检测天数'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.45))
                .make(),
            '${_model?.detectionDays}'
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
      ),
    );
    var right = Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '报警次数'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.45))
                .make(),
            '${_model?.alarmNums}'
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
        ),
      ),
    );
    return Container(
      width: 686.w,
      height: 160.w,
      padding: EdgeInsets.symmetric(vertical: 26.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Row(
        children: [
          40.w.widthBox,
          left,
          BeeDivider.vertical(),
          mid,
          BeeDivider.vertical(),
          right
        ],
      ),
    );
  }
}
