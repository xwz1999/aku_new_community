import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/models/life_pay/share_pay_list_model.dart';
import 'package:aku_new_community/pages/life_pay/life_pay_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_check_radio.dart';

class SharePayDetailPage extends StatefulWidget {
  final SharePayListModel model;
  final SharePayListModel selectModel;
  final String months;

  const SharePayDetailPage(
      {Key? key,
      required this.model,
      required this.selectModel,
      required this.months})
      : super(key: key);

  @override
  _SharePayDetailPageState createState() => _SharePayDetailPageState();
}

class _SharePayDetailPageState extends State<SharePayDetailPage> {
  late SharePayListModel _selectModel; //已选择的model
  late SharePayListModel _model;

  SelectPay get total {
    int count = 0;
    double price = 0;
    List<int> ids = [];
    _selectModel.appMeterShareDetailsVos.forEach((element) {
      count++;
      price += element.remainingUnpaidAmount;
      ids.add(element.id);
    });
    return SelectPay(payCount: count, payTotal: price, ids: ids);
  }

  bool get isAllSelect {
    return total.payCount == widget.model.num && total.payCount != 0;
  }

  @override
  void initState() {
    super.initState();
    _selectModel =
        SharePayListModel.fromJson(jsonDecode(jsonEncode(widget.selectModel)));
    _model = widget.model;
  }

  // Widget _expandedTile(AppMeterShareDetailsVos model, int index) {
  //   return ExpandablePanel(
  //     theme: ExpandableThemeData.combine(
  //         ExpandableThemeData(
  //             headerAlignment: ExpandablePanelHeaderAlignment.center),
  //         ExpandableThemeData.defaults),
  //     header: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         12.w.widthBox,
  //         Spacer(),
  //         '¥${(model.remainingUnpaidAmount ).toStringAsFixed(2)}'
  //             .text
  //             .color(kDangerColor)
  //             .size(28.sp)
  //             .bold
  //             .make(),
  //         24.w.widthBox,
  //       ],
  //     ).material(color: Colors.transparent),
  //     collapsed: SizedBox(),
  //     expanded: Column(
  //         children: model.detailsVoList
  //             .map((e) => _expandedChild(e, index1, index2))
  //             .toList()),
  //   );
  // }

  Widget _expandedChild(AppMeterShareDetailsVos model, int index) {
    return GestureDetector(
      onTap: () {
        if (_selectModel.appMeterShareDetailsVos.contains(model)) {
          _selectModel.appMeterShareDetailsVos.remove(model);
          setState(() {});
        } else {
          _selectModel.appMeterShareDetailsVos.add(model);
          setState(() {});
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          children: [
            Row(
              children: [
                BeeCheckRadio(
                  value: model.id,
                  groupValue: total.ids,
                ),
                12.w.widthBox,
                '房屋面积'.text.size(26.sp).black.make(),
                12.wb,
                ('${model.houseArea}平方米')
                    .toString()
                    .text
                    .size(26.sp)
                    .black
                    .make(),
                Spacer(),
                '未缴金额'.text.size(26.sp).red500.make(),
                12.wb,
                '¥${(model.remainingUnpaidAmount).toStringAsFixed(2)}'
                    .text
                    .size(26.sp)
                    .black
                    .make(),
                40.w.widthBox,
              ],
            ),
            Row(
              children: [
                52.w.widthBox,
                '应缴金额'.text.size(26.sp).black.make(),
                12.wb,
                '¥${model.amountPayable}'
                    .toString()
                    .text
                    .size(26.sp)
                    .black
                    .make(),
                Spacer(),
              ],
            ),
            Row(
              children: [
                52.w.widthBox,
                '已缴金额'.text.size(26.sp).black.make(),
                12.wb,
                '¥${model.paidAmount}'.toString().text.size(26.sp).black.make(),
                Spacer(),
              ],
            ),
            // Row(
            //   children: [
            //     52.w.widthBox,
            //     '缴费期限'.text.size(26.sp).black.make(),
            //     12.wb,
            //     model.paidAmount.toString().text.size(26.sp).black.make(),
            //     Spacer(),
            //   ],
            // )
          ].sepWidget(separate: 24.w.heightBox),
        ),
      )
          .box
          .color(Colors.white)
          .padding(EdgeInsets.symmetric(vertical: 32.w, horizontal: 20.w))
          .make(),
    );
  }

  Widget _buildCard(AppMeterShareDetailsVos model, int index) {
    final appProvider = Provider.of<AppProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              model.houseArea.text.black.size(30.sp).bold.make(),
              Spacer(),
              '${S.of(context)!.tempPlotName} ${appProvider.selectedHouse!.estateId}'
                  .text
                  .color(ktextSubColor)
                  .size(24.sp)
                  .make(),
              _expandedChild(
                model,
                index,
              )
            ],
          ),
        ],
      ),
    );
  }

  SharePayListModel clearModel(SharePayListModel model) {
    model.appMeterShareDetailsVos.clear();
    return model;
  }

  Map<int, String> getType = {
    1: '水费',
    2: '电费',
  };

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
      title: '公摊${getType[widget.model.type]}(${widget.months})',
      body: ListView(
          padding: EdgeInsets.only(top: 16.w),
          children: List.generate(
              _model.appMeterShareDetailsVos.length,
              (index) => _expandedChild(
                  _model.appMeterShareDetailsVos[index], index))),
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
                  _selectModel = SharePayListModel.fromJson(
                      jsonDecode(jsonEncode(_model)));
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
