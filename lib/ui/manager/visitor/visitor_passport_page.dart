// Dart imports:
import 'dart:typed_data';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fluwx/fluwx.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/model/manager/visitor_list_item_model.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_back_button.dart';
import 'package:akuCommunity/widget/buttons/bottom_button.dart';

class VisitorPassportPage extends StatefulWidget {
  final VisitorListItemModel model;
  VisitorPassportPage({Key key, @required this.model}) : super(key: key);

  @override
  _VisitorPassportPageState createState() => _VisitorPassportPageState();
}

class _VisitorPassportPageState extends State<VisitorPassportPage> {
  GlobalKey _repaintKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333333),
      appBar: AppBar(
        leading: BeeBackButton(color: Colors.white),
        backgroundColor: Color(0xFF333333),
        elevation: 0,
        centerTitle: true,
        title: '访客通行证'.text.white.make(),
      ),
      body: RepaintBoundary(
        key: _repaintKey,
        child: ListView(
          children: [
            64.hb,
            '宁波华茂悦峰'.text.size(40.sp).white.bold.make().centered(),
            '1幢-1单元-702室'.text.size(30.sp).white.make().centered(),
            32.hb,
            Container(
              width: 600.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  32.hb,
                  [
                    32.wb,
                    [
                      Image.asset(
                        R.ASSETS_ICONS_USER_ICON_WDFK_PNG,
                        color: ktextSubColor,
                        height: 40.w,
                        width: 40.w,
                      ),
                      16.wb,
                      widget.model.name.text
                          .size(36.sp)
                          .bold
                          .overflow(TextOverflow.ellipsis)
                          .make()
                          .expand(),
                    ].row().expand(),
                    [
                      Image.asset(
                        R.ASSETS_ICONS_USER_ICON_WDC_PNG,
                        color: ktextSubColor,
                        height: 40.w,
                        width: 40.w,
                      ),
                      16.wb,
                      (widget.model.drive ? '无车辆信息' : widget.model.carNum)
                          .text
                          .size(36.sp)
                          .bold
                          .overflow(TextOverflow.ellipsis)
                          .make()
                          .expand(),
                    ].row().expand(),
                    32.wb,
                  ].row(),
                  16.hb,
                  '有效时间：${DateUtil.formatDate(
                    widget.model.date,
                    format: 'yyyy-MM-dd',
                  )}'
                      .text
                      .color(Color(0xFF999999))
                      .size(24.sp)
                      .make()
                      .pSymmetric(h: 32.w),
                  20.hb,
                  Divider(height: 1.w),
                  32.hb,
                  SizedBox(
                    height: 260.w,
                    width: 260.w,
                    child: QrImage(
                      data: widget.model.accessCode.toString(),
                    ),
                  ).centered(),
                  32.hb,
                  Divider(height: 1.w),
                  '进入小区时，请出示此通行证给门岗'
                      .text
                      .size(24.sp)
                      .color(Color(0xFF999999))
                      .make()
                      .centered()
                      .box
                      .height(64.w)
                      .make(),
                ],
              ),
              //TODO 二维码显示
            ).centered(),
          ],
        ).box.color(Color(0xFF333333)).make(),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: () async {
          VoidCallback cancel = BotToast.showLoading();
          RenderRepaintBoundary boundary =
              _repaintKey.currentContext.findRenderObject();
          ui.Image image = await boundary.toImage(pixelRatio: 3);
          ByteData byteData =
              await image.toByteData(format: ui.ImageByteFormat.png);
          Uint8List png = byteData.buffer.asUint8List();
          cancel();
          shareToWeChat(WeChatShareImageModel(
            WeChatImage.binary(png, suffix: '.png'),
            scene: WeChatScene.SESSION,
          ));
        },
        child: '发送给访客'.text.bold.make(),
      ),
    );
  }
}
