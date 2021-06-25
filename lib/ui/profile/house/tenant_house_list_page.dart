import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/models/house/lease_list_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/ui/profile/house/contract_pay_page.dart';
import 'package:aku_community/ui/profile/house/download_contract_page.dart';
import 'package:aku_community/ui/profile/house/supplement_information_page.dart';
import 'package:aku_community/ui/profile/house/upload_contracts_page.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/card_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TenantHouseListPage extends StatefulWidget {
  TenantHouseListPage({Key? key}) : super(key: key);

  @override
  _TenantHouseListPageState createState() => _TenantHouseListPageState();
}

class _TenantHouseListPageState extends State<TenantHouseListPage> {
  bool _onload = true;
  late EasyRefreshController _refreshController;
  @override
  void initState() {
    _refreshController = EasyRefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '可选房屋',
      // body: EasyRefresh(
      //   firstRefresh: true,
      //   header: MaterialHeader(),
      //   controller: _refreshController,
      //   onRefresh: () async {
      //     _onload = false;
      //     setState(() {});
      //   },
      //   child: _onload
      //       ? Container()
      //       : ListView(
      //           padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
      //           children: [houseCard()],
      //         ),
      // ),
      body: BeeListView(
          path: API.house.leaseList,
          controller: _refreshController,
          convert: (models) {
            return models.tableList!
                .map((e) => LeaseListModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
                itemBuilder: (context, index) {
                  return houseCard(items[index]);
                },
                separatorBuilder: (_, __) {
                  return 24.w.heightBox;
                },
                itemCount: items.length);
          }),
    );
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

  Widget houseCard(LeaseListModel model) {
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
                R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                width: 40.w,
                height: 40.w,
              ),
              16.w.widthBox,
              '南宁金融人才公寓'.text.size(32.sp).color(ktextPrimary).make().expand(),
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
                  Get.to(() => SupplementInformationPage());
                })
          ],
        );
      case 2:
        return Row(
          children: [
            CardBottomButton.yellow(
                text: '上传合同',
                onPressed: () {
                  Get.to(() => UploadContractsPage());
                }),
            CardBottomButton.white(
                text: '下载合同',
                onPressed: () {
                  Get.to(() => DownLoadContractPage(firstRoute: false));
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
                  Get.to(() => UploadContractsPage());
                }),
            CardBottomButton.white(
                text: '修改信息',
                onPressed: () {
                  Get.to(() => SupplementInformationPage());
                }),
          ],
        );
      case 5:
        return Row(
          children: [
            CardBottomButton.yellow(
                text: '去支付',
                onPressed: () {
                  Get.to(() => ContractPayPage());
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
}
