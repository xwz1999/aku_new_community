import 'package:aku_new_community/models/life_pay/life_pay_model.dart';
import 'package:aku_new_community/pages/life_pay/life_pay_page_new.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/models/life_pay/life_pay_list_model.dart';
import 'package:aku_new_community/pages/life_pay/life_pay_page.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/utils/bee_parse.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_check_radio.dart';

class LifePayDetailPageNew extends StatefulWidget {
  final MonthPay model;

  LifePayDetailPageNew({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _LifePayDetailPageNewState createState() => _LifePayDetailPageNewState();
}

class _LifePayDetailPageNewState extends State<LifePayDetailPageNew> {
 //已选择的model
  List<int> _selectModelIndex = []; //选择的月份model，存储其数组下标
  List<LifePayModel> _list = [];


  SelectPay get total {
    int count = 0;
    double price = 0;
    List<int> ids = [];

    widget.model.selectIds.forEach((element) {
          count++;
          price += (element.defaultAmount + element.payPrincipal);
          ids.add(element.id);
    });
    widget.model.payTotal = price;
    return SelectPay(payCount: count, payTotal: price, ids: ids);
  }

  bool get isAllSelect {
    return _selectModelIndex.length == widget.model.ids.length && _selectModelIndex != 0;
  }

  @override
  void initState() {
    super.initState();

    for(int i=0;i<widget.model.selectIds.length;i++){

      _selectModelIndex.add(widget.model.ids.indexOf(widget.model.selectIds[i]));
    }
    for(int i=0;i<widget.model.ids.length;i++){

      _list.add(widget.model.ids[i]);
    }



  }


  Widget _buildCard(LifePayModel model, int index) {

    return Container(
      padding: EdgeInsets.symmetric(vertical:32.w,horizontal: 32.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w), color: kForeGroundColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {



                    if (_selectModelIndex.contains(index)) {
                      _selectModelIndex.remove(index);
                      widget.model.selectIds.remove(model);
                    } else {
                      _selectModelIndex.add(index);
                      widget.model.selectIds.add(model);
                    }
                    print(widget.model.ids);
                    print(widget.model.selectIds);
                  });
                },
                child: Container(
                  padding:  EdgeInsets.only(left: 10.w,right: 10.w,top: 5.w,bottom: 50.w),
                  color: Colors.transparent,
                  child: BeeCheckRadio(
                    value: index,
                    groupValue: _selectModelIndex,
                  ),
                ),
              ),
            ],
          ),
          24.w.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              model.chargesName.text.color(ktextSubColor).size(28.sp).make(),
              24.w.heightBox,
              DateUtil.formatDate(DateTime.parse(model.billDateStart),
                  format: 'yyyy/MM/dd')
                  .richText
                  .withTextSpanChildren([
                ' - '
                    .textSpan
                    .color(Colors.black.withOpacity(0.45))
                    .size(24.sp)

                    .make(),
                DateUtil.formatDate(DateTime.parse(model.billDateEnd),
                    format: 'yyyy/MM/dd')
                    .textSpan
                    .color(Colors.black.withOpacity(0.45))
                    .size(24.sp)

                    .make(),
              ])
                  .color(Colors.black.withOpacity(0.45))
                  .size(24.sp)
                  .make(),

            ],
          ).expand(),

          RichText(
              text: TextSpan(
                  text: '¥ ',
                  style: TextStyle(
                      color: kDangerColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '${model.payPrincipal+model.defaultAmount}',
                        style: TextStyle(
                            color: kDangerColor,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold)),
                  ])),
        ],
      ),
    );
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
      leading: IconButton(
        onPressed: () {
          ///返回按钮不会改变数据
          widget.model.selectIds = _list;
          Get.back(result: false);
        },
        icon: Icon(
          CupertinoIcons.chevron_back,
          color: Colors.black,
        ),
      ),
      title: widget.model.timeTitle,
      body: WillPopScope(

        onWillPop: () async{
          ///返回按钮不会改变数据
          widget.model.selectIds = _list;
          Get.back(result: false);
          return false;
        },
        child: ListView(
            padding: EdgeInsets.only(top: 16.w),
            children: List.generate(widget.model.ids.length,
                (index) => _buildCard(widget.model.ids[index], index)).sepWidget(separate: BeeDivider.horizontal(indent: 100.w,)),),
      ),
      bottomNavi: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(
            32.w, 16.w, 32.w, 12.w + MediaQuery.of(context).padding.bottom),
        child: Row(
          children: [

            GestureDetector(
              onTap: () {
                if (isAllSelect) {
                  _selectModelIndex.clear();
                  widget.model.selectIds.clear();
                  setState(() {});
                } else {

                  _selectModelIndex.clear();
                  for (var i = 0; i < widget.model.ids.length; i++) {
                    _selectModelIndex.add(i);
                    widget.model.selectIds.add(widget.model.ids[i]);
                  }
                  setState(() {});
                }

              },
              child: animatedContainer,
            ),
            16.wb,
            '全选'
                .text
                .color(ktextSubColor)
                .size(28.sp)
                .bold
                .make(),
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
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: ' ¥',
                              style: TextStyle(
                                  color: kDangerColor,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: '${total.payTotal.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: kDangerColor,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold)),
                        ])),

                '已选${total.payCount}项'
                    .text
                    .color(ktextSubColor)
                    .size(20.sp)
                    .make(),
              ],
            ),
            20.w.widthBox,
            MaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(37.w)),
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
              onPressed: () {
                Get.back(result: true);
              },
              child: '确定'.text.black.size(32.sp).bold.make(),
            ),
          ],
        ),
      ),
    );
  }
}
