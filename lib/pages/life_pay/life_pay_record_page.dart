import 'package:flutter/material.dart';

import 'package:flustars/flustars.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/life_pay_record_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class LifePayRecordPage extends StatefulWidget {
  LifePayRecordPage({Key key}) : super(key: key);

  @override
  _LifePayRecordPageState createState() => _LifePayRecordPageState();
}

class _LifePayRecordPageState extends State<LifePayRecordPage> {
  EasyRefreshController _refreshController;
  Map<int, String> getPayType = {1: '支付宝', 2: '微信', 3: '现金', 4: 'pos'};
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
        controller: _refreshController,
        convert: (models) {
          return models.tableList
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
              ...items.map((e) => _buildRecordCard(e)).toList()
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
            '${S.of(context).tempPlotName} ${model.roomName}'
                .text
                .size(24.sp)
                .color(Color(0xFF999999))
                .make()
          ],
        ),
        50.w.heightBox,
        Row(
          children: [
            '${model.years}年'.text.color(ktextSubColor).size(24.sp).make(),
            Spacer(),
            '${model.paidPrice}'
                .text
                .color(Color(0xFFFC361D))
                .size(28.sp)
                .bold
                .make()
          ],
        ),
        Row(
          children: [
            '创建时间'.text.color(ktextSubColor).size(28.sp).make(),
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
      ],
    )
        .box
        .color(Colors.white)
        .padding(EdgeInsets.symmetric(vertical: 32.w, horizontal: 20.w))
        .make();
  }
}
