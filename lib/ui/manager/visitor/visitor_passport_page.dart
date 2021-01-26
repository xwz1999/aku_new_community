// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_back_button.dart';

class VisitorPassportPage extends StatefulWidget {
  VisitorPassportPage({Key key}) : super(key: key);

  @override
  _VisitorPassportPageState createState() => _VisitorPassportPageState();
}

class _VisitorPassportPageState extends State<VisitorPassportPage> {
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
      body: ListView(
        children: [
          64.hb,
          '宁波华茂悦峰'.text.size(40.sp).white.bold.make().centered(),
          '1幢-1单元-702室'.text.size(30.sp).white.make().centered(),
          32.hb,
          Container(
            height: 600.w,
            width: 600.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.w),
            ),
            // child: ,
            //TODO 二维码显示
          ).centered(),
        ],
      ),
    );
  }
}
