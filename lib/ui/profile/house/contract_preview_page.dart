import 'dart:io';
import 'dart:typed_data';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/ui/profile/house/download_contract_page.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/others/sign_name_board.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ContractPreviewPage extends StatefulWidget {
  ContractPreviewPage({Key? key}) : super(key: key);

  @override
  _ContractPreviewPageState createState() => _ContractPreviewPageState();
}

class _ContractPreviewPageState extends State<ContractPreviewPage> {
  Uint8List? _signName;
  File? _signFile;
  @override
  Widget build(BuildContext context) {
    var signName = GestureDetector(
      child: DottedBorder(
        child: Container(
          alignment: Alignment.center,
          width: 300.w,
          height: 300.w,
          color: Colors.white,
          child: _signName != null
              ? Image.memory(
                  _signName!,
                  fit: BoxFit.fitWidth,
                )
              : '签字区'.text.size(28.sp).bold.color(ktextPrimary).make(),
        ),
      ),
      onTap: () async {
        _signName = await SignNameBoard.defalutBoard();
        if (_signName != null) {
          _signFile = File.fromRawPath(_signName!);
        }
        setState(() {});
      },
    );
    return BeeScaffold(
      title: '合同预览',
      body: ListView(
        children: [
          Stack(
            children: [
              FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                  image: 'image'),
              Positioned(
                right: 70.w,
                bottom: 200.w,
                child: signName,
              ),
            ],
          ),
        ],
      ),
      bottomNavi: BottomButton(
          onPressed: () {
            Get.to(() => DownLoadContractPage(firstRoute: true));
          },
          child: '生成合同'.text.size(32.sp).color(ktextPrimary).make()),
    );
  }
}
