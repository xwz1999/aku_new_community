// Flutter imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/life_pay_model.dart';
import 'package:akuCommunity/pages/personal/widget/order_card.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/widget/buttons/bee_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// Package imports:
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/pages/life_pay/life_pay_record_page/life_pay_record_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class LifePayPage extends StatefulWidget {
  LifePayPage({Key key}) : super(key: key);

  @override
  _LifePayPageState createState() => _LifePayPageState();
}

class _LifePayPageState extends State<LifePayPage> {
  EasyRefreshController _controller;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String _getCustomYears(int year) {
    int dif = year - DateTime.now().year;
    if (dif < 0) {
      if (dif == -1) {
        return '去年';
      } else if (dif == -2) {
        return '前年';
      } else {
        return '${-dif}年前';
      }
    } else if (dif == 0) {
      return '今年';
    } else {
      if (dif == 1) {
        return '明年';
      } else {
        return '$dif年后';
      }
    }
  }

  Widget _buildCard(LifePayMolde model) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w), color: kForeGroundColor),
      child: Row(
        children: [
          BeeCheckBox.round(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              '${_getCustomYears(model.years)}(${model.years})'
                  .text
                  .color(ktextSubColor)
                  .size(28.sp)
                  .make(),
              24.w.heightBox,
              '待缴：${model.paymentNum}项'
                  .text
                  .color(ktextPrimary)
                  .size(28.sp)
                  .make(),
              24.w.heightBox,
              RichText(
                  text: TextSpan(
                      text: '合计：',
                      style: TextStyle(
                          color: ktextPrimary,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                        text: '¥',
                        style: TextStyle(
                            color: kDangerColor,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold)),
                  ]))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '生活缴费',
      actions: [
        InkWell(
          onTap: () {
            LifePayRecordPage().to();
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(32.w, 28.w, 32.w, 20.w),
            alignment: Alignment.center,
            child: '缴费记录'.text.black.size(28.sp).make(),
          ),
        ),
      ],
      body: BeeListView(
          path: API.manager.dailyPaymentList,
          controller: _controller,
          convert: (model) {
            return model.tableList
                .map((e) => LifePayMolde.fromJson(e))
                .toList();
          },
          builder: (items) {
            return Column(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    // return _buildCard(items[index]);
                    return _buildCard(items[index]);
                  },
                  itemCount: 1,
                ),
              ],
            );
          }),
    );
  }
}
