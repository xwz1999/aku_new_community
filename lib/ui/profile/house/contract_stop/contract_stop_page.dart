import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/ui/profile/house/contract_stop/upload_empty_list_page.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';

class ContractStopPage extends StatefulWidget {
  ContractStopPage({
    Key? key,
  }) : super(key: key);

  @override
  _ContractStopPageState createState() => _ContractStopPageState();
}

class _ContractStopPageState extends State<ContractStopPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '联系物业',
      body: Center(
        child: Column(
          children: [
            192.w.heightBox,
            Image.asset(
              R.ASSETS_IMAGES_CONTACT_MANAGER_PNG,
              width: 400.w,
              height: 400.w,
            ),
            40.w.heightBox,
            '物业中心电话'.text.size(44.sp).color(ktextPrimary).bold.make(),
            32.w.heightBox,
            '需沟通物业人员检查房屋\n并填写腾空单后拍照\n方可进行下一步'
                .text
                .size(30.w)
                .color(ktextSubColor)
                .align(TextAlign.center)
                .make(),
          ],
        ),
      ),
      bottomNavi: BottomButton(
          onPressed: () {
            Get.off(() => UploadEmptyListPage());
          },
          child: '检查完成，上传腾空单'.text.size(32.sp).bold.color(ktextPrimary).make()),
    );
  }
}
