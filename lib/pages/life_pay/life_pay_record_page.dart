import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/life_pay/life_pay_record_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class LifePayRecordPage extends StatefulWidget {
  LifePayRecordPage({Key? key}) : super(key: key);

  @override
  _LifePayRecordPageState createState() => _LifePayRecordPageState();
}

class _LifePayRecordPageState extends State<LifePayRecordPage> {
  EasyRefreshController? _refreshController;
  Map<int, String> getPayType = {
    1: '支付宝',
    2: '微信',
    3: '现金',
    4: 'pos',
    5: '预缴扣除'
  };

  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '生活缴费',
      body: BeeListView(
        path: API.manager.paymentRecord,
        extraParams: {"estateId": UserTool.appProvider.selectedHouse!.estateId},
        controller: _refreshController,
        convert: (models) {
          return models.rows
              .map((e) => LifePayRecordModel.fromJson(e))
              .toList();
        },
        builder: (items) {
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
            children: [
              '如果有疑问，请联系物业客服 '
                  .richText
                  .withTextSpanChildren([
                    '400-6754322'
                        .textSpan
                        .color(Color(0xFFFF8200))
                        .size(24.sp)
                        .bold
                        .make()
                  ])
                  .size(24.sp)
                  .color(ktextSubColor)
                  .make(),
              32.w.heightBox,
              ...<Widget>[
                ...items
                    .map((e) => _buildRecordCard(e as LifePayRecordModel))
                    .toList()
              ].sepWidget(separate: 24.w.heightBox)
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecordCard(LifePayRecordModel model) {
    return Column(
      children: [
        Row(
          children: [
            model.chargesTemplateDetailName.text
                .size(30.sp)
                .color(ktextPrimary)
                .bold
                .make(),
            Spacer(),
            '${S.of(context)!.tempPlotName} ${model.roomName}'
                .text
                .size(24.sp)
                .color(Color(0xFF999999))
                .make()
          ],
        ),
        16.w.heightBox,
        Row(
          children: [
            '缴纳人'.text.color(ktextSubColor).size(24.sp).make(),
            Spacer(),
            '${model.createName}'
                .text
                .color(Color(0xFFFC361D))
                .size(28.sp)
                .bold
                .make()
          ],
        ),
        Row(
          children: [
            '缴纳金额'.text.color(ktextSubColor).size(28.sp).make(),
            Spacer(),
            '${model.paidPrice}'.text.color(ktextPrimary).size(28.sp).make(),
          ],
        ),
        Row(
          children: [
            '缴费时间'.text.color(ktextSubColor).size(28.sp).make(),
            Spacer(),
            '${DateUtil.formatDateStr(model.createDate, format: "yyyy/MM/dd HH:mm")}'
                .text
                .color(ktextPrimary)
                .size(28.sp)
                .make(),
          ],
        ),
        Row(
          children: [
            '付款方式'.text.color(ktextSubColor).size(28.sp).make(),
            Spacer(),
            '${getPayType[model.payType]}'
                .text
                .color(ktextPrimary)
                .size(28.sp)
                .make(),
          ],
        ),
        Row(
          children: [
            '订单号'.text.color(ktextSubColor).size(28.sp).make(),
            Spacer(),
            '${model.code}'.text.color(ktextPrimary).size(28.sp).make(),
          ],
        ),
      ].sepWidget(separate: 24.w.heightBox),
    )
        .box
        .color(Colors.white)
        .padding(EdgeInsets.symmetric(vertical: 32.w, horizontal: 20.w))
        .make();
  }
}
