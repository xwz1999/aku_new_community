import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/models/life_pay/life_pay_list_model.dart';
import 'package:aku_community/pages/life_pay/life_pay_page.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/utils/bee_parse.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bee_check_radio.dart';

class LifePayDetailPage extends StatefulWidget {
  final LifePayListModel model;
  final LifePayListModel selectModel;
  final int year;
  LifePayDetailPage({
    Key? key,
    required this.model,
    required this.selectModel,
    required this.year,
  }) : super(key: key);

  @override
  _LifePayDetailPageState createState() => _LifePayDetailPageState();
}

class _LifePayDetailPageState extends State<LifePayDetailPage> {
  late LifePayListModel _selectModel; //已选择的model
  late LifePayListModel _model;
  SelectPay get total {
    int count = 0;
    double price = 0;
    List<int> ids = [];
    _selectModel.dailyPaymentTypeVos.forEach((element) {
      element.detailedVoList.forEach((element) {
        element.detailsVoList.forEach((element) {
          count++;
          price += (element.paymentPrice+element.overdueFine);
          ids.add(element.id);
        });
      });
    });
    return SelectPay(payCount: count, payTotal: price, ids: ids);
  }

  bool get isAllSelect {
    return total.payCount == widget.model.paymentNum && total.payCount != 0;
  }

  @override
  void initState() {
    super.initState();
    _selectModel = LifePayListModel.fromJson(widget.selectModel.toJson());
    _model = widget.model;
  }

  Widget _expandedTile(DetailedVoList model, int index1, int index2) {
    return ExpandablePanel(
      theme: ExpandableThemeData.combine(
          ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center),
          ExpandableThemeData.defaults),
      header: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          12.w.widthBox,
          model.groupId == 1
              ? '${widget.year}上半年'.text.black.size(28.sp).make()
              : '${widget.year}下半年'.text.black.size(28.sp).make(),
          Spacer(),
          '¥${(model.paymentPrice+model.overdueFine).toStringAsFixed(2)}'
              .text
              .color(kDangerColor)
              .size(28.sp)
              .bold
              .make(),
          24.w.widthBox,
        ],
      ).material(color: Colors.transparent),
      collapsed: SizedBox(),
      expanded: Column(
          children: model.detailsVoList
              .map((e) => _expandedChild(e, index1, index2))
              .toList()),
    );
  }

  Widget _expandedChild(DetailsVoList model, int index1, int index2) {
    return GestureDetector(
      onTap: () {
        if (_selectModel
            .dailyPaymentTypeVos[index1].detailedVoList[index2].detailsVoList
            .contains(model)) {
          _selectModel
              .dailyPaymentTypeVos[index1].detailedVoList[index2].detailsVoList
              .remove(model);
          setState(() {});
        } else {
          _selectModel
              .dailyPaymentTypeVos[index1].detailedVoList[index2].detailsVoList
              .add(model);
          setState(() {});
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          children: [
            BeeCheckRadio(
              value: model.id,
              groupValue: total.ids,
            ),
            12.w.widthBox,
            model.month.toString().text.size(26.sp).black.make(),
            Spacer(),
            '¥${(model.paymentPrice+model.overdueFine).toStringAsFixed(2)}'
                .text
                .size(26.sp)
                .black
                .make(),
            40.w.widthBox,
          ],
        ),
      ),
    );
  }

  Widget _buildCard(DailyPaymentTypeVos model, int index1) {
    final appProvider = Provider.of<AppProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              model.name.text.black.size(30.sp).bold.make(),
              Spacer(),
              '${S.of(context)!.tempPlotName} ${appProvider.selectedHouse!.estateId}'
                  .text
                  .color(ktextSubColor)
                  .size(24.sp)
                  .make(),
            ],
          ),
          ...List.generate(
              model.detailedVoList.length,
              (index) =>
                  _expandedTile(model.detailedVoList[index], index1, index)),
        ],
      ),
    );
  }

  LifePayListModel clearModel(LifePayListModel model) {
    model.dailyPaymentTypeVos.forEach((element) {
      element.detailedVoList.forEach((element) {
        element.detailsVoList.clear();
      });
    });
    return model;
  }

  @override
  Widget build(BuildContext context) {
    var animatedContainer = AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1.w, color: isAllSelect ? kPrimaryColor : kDarkSubColor),
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
    );
    return BeeScaffold(
      title:
          '${BeeParse.getCustomYears(widget.model.years)}-${widget.model.years}年明细',
      body: ListView(
          padding: EdgeInsets.only(top: 16.w),
          children: List.generate(_model.dailyPaymentTypeVos.length,
              (index) => _buildCard(_model.dailyPaymentTypeVos[index], index))),
      bottomNavi: Container(
        padding: EdgeInsets.fromLTRB(
            32.w, 16.w, 32.w, 12.w + MediaQuery.of(context).padding.bottom),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (isAllSelect) {
                  clearModel(_selectModel);
                } else {
                  _selectModel = LifePayListModel.fromJson(_model.toJson());
                }
                setState(() {});
              },
              child: animatedContainer,
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
                          text: '${total.payTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: kDangerColor,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold)),
                    ])),
                '已选${total.payCount}'
                    .text
                    .color(ktextSubColor)
                    .size(20.sp)
                    .make(),
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
                Get.back(result: _selectModel);
              },
              child: '选好了'.text.black.size(32.sp).bold.make(),
            ),
          ],
        ),
      ),
    );
  }
}
