import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/const/resource.dart';
import 'package:aku_new_community/models/house/lease_list_model.dart';
import 'package:aku_new_community/ui/profile/house/lease_relevation/contract_pay_page.dart';
import 'package:aku_new_community/ui/profile/house/lease_relevation/supplement_information_page.dart';
import 'package:aku_new_community/ui/profile/house/lease_relevation/upload_contracts_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/buttons/card_bottom_button.dart';

class LeaseHouseCard extends StatelessWidget {
  final LeaseListModel model;

  const LeaseHouseCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttons = getButtons(model.status);
    var bottom = Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            model.getTypeString.text.size(28.sp).color(ktextSubColor).make(),
            8.w.heightBox,
            model.estateType.text.size(28.sp).color(ktextSubColor).make(),
          ],
        ).expand(),
        buttons
      ],
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        gradient: LinearGradient(
            colors: _getColors(1),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                R.ASSETS_ICONS_LEASE_HOUSE_PNG,
                width: 40.w,
                height: 40.w,
              ),
              16.w.widthBox,
              S
                  .of(context)!
                  .tempPlotName
                  .text
                  .size(32.sp)
                  .color(ktextPrimary)
                  .make()
                  .expand(),
              model.statusString.text
                  .size(32.sp)
                  .color(ktextPrimary)
                  .bold
                  .make(),
            ],
          ),
          12.w.heightBox,
          Row(
            children: [
              model.roomName.text
                  .size(40.sp)
                  .color(ktextPrimary)
                  .bold
                  .make()
                  .expand(),
            ],
          ),
          56.w.heightBox,
          bottom,
        ],
      ),
    );
  }

  Row getButtons(int status) {
    switch (status) {
      case 1:
        return Row(
          children: [
            CardBottomButton.yellow(
                text: '填写信息',
                onPressed: () {
                  Get.to(() => SupplementInformationPage(
                        leaseId: model.id,
                      ));
                })
          ],
        );
      case 2:
        return Row(
          children: [
            CardBottomButton.yellow(
                text: '重新填写',
                onPressed: () {
                  Get.to(() => SupplementInformationPage(
                        leaseId: model.id,
                      ));
                }),
            CardBottomButton.yellow(
                text: '上传合同',
                onPressed: () {
                  Get.to(() => UploadContractsPage(
                        id: model.id,
                      ));
                }),
            CardBottomButton.white(
                text: '下载合同',
                onPressed: () async {
                  //TODO:待接口中添加完合同路径字段后取消注释
                  //  String? result = await Get.dialog(BeeDownloadView(
                  //         file:
                  //       ));
                  //       if (result != null) OpenFile.open(result);
                }),
          ],
        );

      case 3:
        return Row(
          children: [],
        );
      case 4:
        return Row(
          children: [
            CardBottomButton.yellow(
                text: '重新上传',
                onPressed: () {
                  Get.to(() => UploadContractsPage(
                        id: model.id,
                      ));
                }),
            CardBottomButton.white(
                text: '修改信息',
                onPressed: () {
                  Get.to(() => SupplementInformationPage(
                        leaseId: model.id,
                      ));
                }),
          ],
        );
      case 5:
        return Row(
          children: [
            CardBottomButton.yellow(
                text: '去支付',
                onPressed: () {
                  Get.to(() => ContractPayPage(
                        id: model.id,
                      ));
                })
          ],
        );
      case 6:
        return Row(
          children: [
            CardBottomButton.yellow(
                text: '租户页面',
                onPressed: () {
                  Get.back();
                })
          ],
        );
      default:
        return Row();
    }
  }

  List<Color> _getColors(int type) {
    switch (type) {
      case 1:
        return [
          Color(0xFFFFE5D2),
          Color(0xFFFFFFFF),
        ];
      case 2:
        return [
          Color(0xFFFFEEBB),
          Color(0xFFFFF4D2),
        ];
      case 3:
        return [
          Color(0xFFFFEEBB),
          Color(0xFFFFF4D2),
        ];
      case 4:
        return [
          Color(0xFFFFEEBB),
          Color(0xFFFFF4D2),
        ];
      case 5:
        return [
          Color(0xFFFFEEBB),
          Color(0xFFFFF4D2),
        ];
      case 6:
        return [
          Color(0xFFFFEEBB),
          Color(0xFFFFF4D2),
        ];
      default:
        return [Colors.white, Colors.white];
    }
  }
}
