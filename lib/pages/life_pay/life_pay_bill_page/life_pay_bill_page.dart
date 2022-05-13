import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/models/life_pay/life_pay_record_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'widget/bill_card.dart';

class LifePayBillPage extends StatefulWidget {
  final LifePayRecordModel model;

  LifePayBillPage({Key? key, required this.model}) : super(key: key);

  @override
  _LifePayBillPageState createState() => _LifePayBillPageState();
}

class _LifePayBillPageState extends State<LifePayBillPage> {
  Widget _cardList(String title, subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 28.sp,
            color: Color(0xff666666),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28.sp,
            color: Color(0xff333333),
          ),
        ),
      ],
    );
  }


  Map<int, String> getPayType = {
    1: '支付宝',
    2: '微信',
    3: '现金',
    4: 'pos',
    5: '预缴扣除'
  };
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '账单详情',
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 32.w, left: 32.w, right: 32.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 32.w,
            ),
            child: Column(
              children: [
                _cardList('收费项目', widget.model.chargesName),
                SizedBox(height: 30.w),
                _cardList('收费地址',
                    '${widget.model.buildingName + '栋' + widget.model.unitName + '单元' + widget.model.estateName}'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 32.w,
              left: 32.w,
              right: 32.w,
            ),
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: 32.w,
              top: 2.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _billItem('账单月份',DateUtil.formatDate(DateUtil.getDateTime(widget.model.billDateStart),
                    format: 'yyyy-MM'),),
                _billItem('缴纳金额','¥'+widget.model.payAmount.toStringAsFixed(2),isRed: true),

                _billItem('缴费时间',DateUtil.formatDate(DateUtil.getDateTime(widget.model.createDate),
                    format: 'yyyy/MM/dd HH:mm'),),
                _billItem('付款方式',  '${getPayType[widget.model.payType]}'),
                _billItem('账单创建时间',DateUtil.formatDate(DateUtil.getDateTime(widget.model.billCreateDate),
                    format: 'yyyy/MM/dd HH:mm'),),
                _billItem('流水号',widget.model.code,),

              ]
            ),
          ),
        ],
      ),
    );
  }
  Container _billItem(String title,String value, { bool isRed = false}) {
    return Container(
      margin: EdgeInsets.only(top: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: ktextSubColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize28,
              color: isRed?Color(0xFFF5222D) :ktextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
