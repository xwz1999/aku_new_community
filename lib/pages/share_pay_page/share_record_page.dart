import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/life_pay/share_pay_record_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';

class ShareRecordPage extends StatefulWidget {
  const ShareRecordPage({Key? key}) : super(key: key);

  @override
  _ShareRecordPageState createState() => _ShareRecordPageState();
}

class _ShareRecordPageState extends State<ShareRecordPage> {
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
      title: '公摊缴费记录',
      body: BeeListView(
        path: API.manager.sharePayRecord,
        extraParams: {"tel": UserTool.userProvider.userInfoModel!.tel},
        controller: _refreshController,
        convert: (models) {
          return models.rows
              .map((e) => SharePayRecordModel.fromJson(e))
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
                    .map((e) => _buildRecordCard(e as SharePayRecordModel))
                    .toList()
              ].sepWidget(separate: 24.w.heightBox)
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecordCard(SharePayRecordModel model) {
    return Column(
      children: [
        Row(
          children: [
            '公摊费用'.text.size(30.sp).color(ktextPrimary).bold.make(),
            Spacer(),
            '${UserTool.userProvider.userInfoModel!.tel}'
                .text
                .size(24.sp)
                .color(Color(0xFF999999))
                .make()
          ],
        ),
        16.w.heightBox,
        Row(
          children: [
            '建筑面积'.text.color(ktextSubColor).size(24.sp).make(),
            Spacer(),
            '${model.indoorArea}平方米'
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
            '${model.payPrice}'.text.color(ktextPrimary).size(28.sp).make(),
          ],
        ),
        Row(
          children: [
            '缴费时间'.text.color(ktextSubColor).size(28.sp).make(),
            Spacer(),
            '${DateUtil.formatDateStr(model.paymentTime, format: "yyyy/MM/dd HH:mm")}'
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
