import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/model/manager/life_pay_model.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/utils/bee_parse.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/bee_check_radio.dart';

class LifePayDetailPage extends StatefulWidget {
  final LifePayModel model;
  LifePayDetailPage({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  _LifePayDetailPageState createState() => _LifePayDetailPageState();
}

class _LifePayDetailPageState extends State<LifePayDetailPage> {
  List<String> _selectItems = [];
  double _payTotal = 0;
  int _payNum = 0;
  int get listLength {
    int count = 0;
    widget.model.dailyPaymentTypeVos.forEach((element) {
      element.detailedVoList.forEach((element) {
        count++;
      });
    });
    return count;
  }

  bool get isAllSelect {
    return listLength == _selectItems.length;
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.model.dailyPaymentTypeVos.length; i++) {
      for (var j = 0;
          j < widget.model.dailyPaymentTypeVos[i].detailedVoList.length;
          j++) {
        String id = widget.model.dailyPaymentTypeVos[i].id.toString() +
            widget.model.dailyPaymentTypeVos[i].detailedVoList[j].groupId
                .toString();
        if (!_selectItems.contains(id)) {
          _selectItems.add(id);
          _payNum += 1;
          _payTotal += widget
              .model.dailyPaymentTypeVos[i].detailedVoList[j].paymentPrice
              .toDouble();
        }
      }
    }
  }

  Widget _buildTile(int groupId, int id, int years, double price) {
    return GestureDetector(
      onTap: () {
        String item = id.toString() + groupId.toString();
        if (_selectItems.contains(item)) {
          _selectItems.remove(item);
          _payNum -= 1;
          _payTotal -= price.toDouble();
        } else {
          _selectItems.add(item);
          _payNum += 1;
          _payTotal += price.toDouble();
        }

        setState(() {});
      },
      child: Row(
        children: [
          BeeCheckRadio(
              value: id.toString() + groupId.toString(),
              groupValue: _selectItems),
          24.w.widthBox,
          groupId == 1
              ? '$years上半年'.text.black.size(28.sp).make()
              : '$years下半年'.text.black.size(28.sp).make(),
          Spacer(),
          '¥${price.toString()}'
              .text
              .color(kDangerColor)
              .size(28.sp)
              .bold
              .make(),
          24.w.widthBox,
        ],
      ).material(color: Colors.transparent),
    );
  }

  Widget _buildCard(DailyPaymentTypeVos model) {
    final appProvider = Provider.of<AppProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              model.name.text.black.size(30.sp).bold.make(),
              Spacer(),
              '${S.of(context).tempPlotName} ${appProvider.selectedHouse.estateId}'
                  .text
                  .color(ktextSubColor)
                  .size(24.sp)
                  .make(),
            ],
          ),
          50.w.heightBox,
          ...model.detailedVoList
              .map((e) => _buildTile(
                  e.groupId, model.id, widget.model.years, e.paymentPrice))
              .toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title:
          '${BeeParse.getCustomYears(widget.model.years)}-${widget.model.years}年明细',
      body: ListView(
        padding: EdgeInsets.only(top: 16.w),
        children: [
          ...widget.model.dailyPaymentTypeVos
              .map((e) => _buildCard(e))
              .toList(),
        ],
      ),
      bottomNavi: Container(
        padding: EdgeInsets.fromLTRB(
            32.w, 16.w, 32.w, 12.w + MediaQuery.of(context).padding.bottom),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (isAllSelect) {
                  _selectItems.clear();
                  _payNum = 0;
                  _payTotal = 0;
                } else {
                  for (var i = 0;
                      i < widget.model.dailyPaymentTypeVos.length;
                      i++) {
                    for (var j = 0;
                        j <
                            widget.model.dailyPaymentTypeVos[i].detailedVoList
                                .length;
                        j++) {
                      String id =
                          widget.model.dailyPaymentTypeVos[i].id.toString() +
                              widget.model.dailyPaymentTypeVos[i]
                                  .detailedVoList[j].groupId
                                  .toString();
                      if (!_selectItems.contains(id)) {
                        _selectItems.add(id);
                        _payNum += 1;
                        _payTotal += widget.model.dailyPaymentTypeVos[i]
                            .detailedVoList[j].paymentPrice
                            .toDouble();
                      }
                    }
                  }
                }
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.w,
                        color: isAllSelect ? kPrimaryColor : kDarkSubColor),
                    color: isAllSelect ? kPrimaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.w)),
                curve: Curves.easeInOutCubic,
                width: 40.w,
                height: 40.w,
                child: isAllSelect
                    ? Icon(
                        CupertinoIcons.check_mark,
                        size: 25.w,
                        color: Colors.white,
                      )
                    : SizedBox(),
              ),
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                    text: TextSpan(
                        text: '合计：',
                        style: TextStyle(
                            color: ktextPrimary,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                          text: '$_payTotal',
                          style: TextStyle(
                              color: kDangerColor,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold)),
                    ])),
                '已选$_payNum项'.text.color(ktextSubColor).size(20.sp).make(),
              ],
            ),
            8.w.widthBox,
            MaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(37.w)),
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
              onPressed: () {
                Get.back(result: [_payNum, _payTotal]);
              },
              child: '选好了'.text.black.size(32.sp).bold.make(),
            ),
          ],
        ),
      ),
    );
  }
}
