import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/const/resource.dart';
import 'package:aku_community/models/house/lease_detail_model.dart';
import 'package:aku_community/models/house/submit_model.dart';
import 'package:aku_community/ui/profile/house/contract_preview_page.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:power_logger/power_logger.dart';
import 'package:velocity_x/velocity_x.dart';

class HouseInformationCheckPage extends StatefulWidget {
  final SubmitModel submitModel;
  final LeaseDetailModel detailModel;
  HouseInformationCheckPage(
      {Key? key, required this.submitModel, required this.detailModel})
      : super(key: key);

  @override
  _HouseInformationCheckPageState createState() =>
      _HouseInformationCheckPageState();
}

class _HouseInformationCheckPageState extends State<HouseInformationCheckPage> {
  late SubmitModel _submitModel;
  @override
  void initState() {
    super.initState();
    _submitModel = widget.submitModel;
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '房屋信息核对',
      bodyColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(bottom: 24.w, left: 32.w, right: 32.w),
        children: [
          _houseHead(),
          _textTile('认定人才类型', HouseFunc.toType[widget.detailModel.type]!),
          _textTile('房屋户型', widget.detailModel.estateType),
          _textTile('房屋结构', '两房两卫一厅'),
          _textTile('建筑面积', '90平米'),
          _textTile('使用面积', '78平米'),
          _textTile('租赁期限',
              '${widget.detailModel.leaseDateStart}————${widget.detailModel.leaseDateEnd}'),
        ].sepWidget(separate: 24.w.heightBox),
      ),
      bottomNavi: BottomButton(
        onPressed: () async {
          Function cancel = BotToast.showLoading();
          try {
            _submitModel.idCardFrontImgUrl.add(await HouseFunc()
                .uploadIdCardFront(_submitModel.idCardFrontFile!));
            _submitModel.idCardFrontImgUrl.add(await HouseFunc()
                .uploadIdCardBack(_submitModel.idCardBackFile!));
            String result = await HouseFunc().submitLeaseInfo(_submitModel);
            if (result.isNotEmpty) {
              Get.back();
              Get.off(() => ContractPreviewPage(
                    url: result,
                  ));
            }
          } catch (e) {
            LoggerData.addData(e);
          }
          cancel();
        },
        child: '确认'.text.size(32.sp).bold.color(ktextPrimary).make(),
      ),
    );
  }

  Widget _textTile(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.text.size(28.sp).color(ktextPrimary).make(),
        24.w.heightBox,
        content.text.size(36.sp).color(ktextPrimary).bold.make(),
        16.w.heightBox,
        BeeDivider.horizontal()
      ],
    );
  }

  Widget _houseHead() {
    return Material(
      color: kForeGroundColor,
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '当前房屋'.text.black.size(28.sp).make(),
            32.w.heightBox,
            Row(
              children: [
                Image.asset(
                  R.ASSETS_ICONS_HOUSE_PNG,
                  width: 60.w,
                  height: 60.w,
                ),
                40.w.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      S
                          .of(context)!
                          .tempPlotName
                          .text
                          .black
                          .size(32.sp)
                          .bold
                          .make(),
                      10.w.heightBox,
                      widget.detailModel.roomName.text.black
                          .size(32.sp)
                          .bold
                          .make()
                    ],
                  ),
                ),
              ],
            ).material(color: Colors.transparent),
            24.w.heightBox,
          ],
        ),
      ),
    );
  }
}
