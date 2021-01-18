import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/industry_committee/committee_mailbox/committee_mailbox_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:velocity_x/velocity_x.dart';

class IndustryCommitteePage extends StatefulWidget {
  IndustryCommitteePage({Key key}) : super(key: key);

  @override
  _IndustryCommitteePageState createState() => _IndustryCommitteePageState();
}

class _IndustryCommitteePageState extends State<IndustryCommitteePage> {
  Widget _buildBottomNavi() {
    return [
      MaterialButton(
        onPressed: () {
          Get.dialog(CupertinoAlertDialog(
            //TODO 业委会电话, for test only
            title: '(0574) 8888 8888'.text.isIntrinsic.make(),
            actions: [
              CupertinoDialogAction(
                child: '取消'.text.isIntrinsic.make(),
                onPressed: Get.back,
              ),
              CupertinoDialogAction(
                child: '呼叫'.text.isIntrinsic.orange500.make(),
                onPressed: () {
                  launch('tel:10086');
                  Get.back();
                },
              ),
            ],
          ));
        },
        height: 98.w,
        color: Color(0xFF2A2A2A),
        child: '业委会电话'.text.white.size(32.sp).make(),
      )
          .box
          .color(Color(0xFF2A2A2A))
          .margin(EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom,
          ))
          .make()
          .expand(),
      MaterialButton(
        onPressed: CommitteeMailboxPage().to,
        height: 98.w,
        color: kPrimaryColor,
        child: '业委会信箱'.text.size(32.sp).color(ktextPrimary).make(),
      )
          .box
          .color(kPrimaryColor)
          .margin(EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom,
          ))
          .make()
          .expand(),
    ].row();
  }

  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '业委会',
      body: Stack(
        children: [],
      ),
      bottomNavi: _buildBottomNavi(),
    );
  }
}
