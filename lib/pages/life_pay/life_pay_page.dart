// Flutter imports:
import 'package:akuCommunity/widget/others/bee_header_house.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/life_pay_model.dart';
import 'package:akuCommunity/pages/life_pay/life_pay_record_page/life_pay_record_page.dart';
import 'package:akuCommunity/pages/life_pay/widget/life_pay_detail_page.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/bee_parse.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/bee_check_radio.dart';

class LifePayPage extends StatefulWidget {
  LifePayPage({Key key}) : super(key: key);

  @override
  _LifePayPageState createState() => _LifePayPageState();
}

class SelectPay {
  double payTotal;
  int payCount;
  SelectPay();
}

class _LifePayPageState extends State<LifePayPage> {
  EasyRefreshController _controller;
  // List<SelectList> selectItems = [];
  List<int> _selectYears = [];
  List<LifePayModel> _models = [];
  List<SelectPay> _selectPay = [];
  double _totalCost = 0;
  int _count = 0;
  // int _getLength(LifePayModel model) {
  //   int count = 0;
  //   model.dailyPaymentTypeVos.forEach((element) {
  //     element.detailedVoList.forEach((element) {
  //       count++;
  //     });
  //   });
  //   return count;
  // }

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

  // Widget _buildHouseCard(
  //   String title,
  //   String detail,
  // ) {
  //   return Material(
  //     color: kForeGroundColor,
  //     child: Padding(
  //       padding: EdgeInsets.all(32.w),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           '当前房屋'.text.black.size(28.sp).make(),
  //           32.w.heightBox,
  //           GestureDetector(
  //             onTap: () {
  //               MyHousePage(
  //                 needFindPayTag: true,
  //               ).to();
  //             },
  //             child: Row(
  //               children: [
  //                 Image.asset(
  //                   R.ASSETS_ICONS_HOUSE_PNG,
  //                   width: 60.w,
  //                   height: 60.w,
  //                 ),
  //                 40.w.widthBox,
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       title.text.black.size(32.sp).bold.make(),
  //                       10.w.heightBox,
  //                       detail.text.black.size(32.sp).bold.make()
  //                     ],
  //                   ),
  //                 ),
  //                 Icon(
  //                   CupertinoIcons.chevron_forward,
  //                   size: 40.w,
  //                 ),
  //               ],
  //             ).material(color: Colors.transparent),
  //           ),
  //           24.w.heightBox,
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCard(LifePayModel model, int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w), color: kForeGroundColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // if (selectItems[index].selected.length ==
                  //     _getLength(model)) {
                  //   selectItems[index].value = false;
                  //   selectItems[index].selected.clear();
                  //   _selectYears.remove(index);
                  // } else {
                  //   selectItems[index].value = true;
                  //   _selectYears.add(index);
                  //   for (var i = 0; i < model.dailyPaymentTypeVos.length; i++) {
                  //     for (var j = 0;
                  //         i <
                  //             model
                  //                 .dailyPaymentTypeVos[i].detailedVoList.length;
                  //         i++) {
                  //       String id = model.dailyPaymentTypeVos[i].id.toString() +
                  //           model.dailyPaymentTypeVos[i].detailedVoList[j]
                  //               .groupId
                  //               .toString();
                  //       if (!selectItems[index].selected.contains(id)) {
                  //         selectItems[index].selected.add(id);
                  //       }
                  //     }
                  //   }
                  // }
                  // setState(() {});
                  if (_selectYears.contains(index)) {
                    _selectYears.remove(index);
                    _totalCost -= _selectPay[index].payTotal;
                    _count -= _selectPay[index].payCount;
                  } else {
                    _selectYears.add(index);
                    _totalCost += _selectPay[index].payTotal;
                    _count += _selectPay[index].payCount;
                  }
                  setState(() {});
                },
                child: BeeCheckRadio(
                  value: index,
                  groupValue: _selectYears,
                  // onChange: (value) {
                  //   if (value) {
                  //     selectItems[index].value=false;
                  //     selectItems[index].selected.clear();
                  //   } else {
                  //     selectItems[index].value=true;
                  //     for (var i = 0; i < model.dailyPaymentTypeVos.length; i++) {
                  //       for (var j = 0;
                  //           i <
                  //               model
                  //                   .dailyPaymentTypeVos[i].detailedVoList.length;
                  //           i++) {
                  //         selectItems[index].selected.add(
                  //             model.dailyPaymentTypeVos[i].id.toString() +
                  //                 model.dailyPaymentTypeVos[i].detailedVoList[j]
                  //                     .groupId
                  //                     .toString());
                  //       }
                  //     }
                  //   }
                  // },
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              '${BeeParse.getCustomYears(model.years)}(${model.years})'
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
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  List payMent = LifePayDetailPage(
                    model: _models[index],
                    // selectItems: selectItems[index].selected,
                  ).to();
                  _selectPay[index].payCount = payMent[0];
                  _selectPay[index].payTotal = payMent[1];
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(22.w),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                  child: '选择明细'.text.color(Colors.white).size(22.sp).make(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
          extraParams: {
            'estateId': userProvider.currentHouseId,
          },
          convert: (model) {
            return model.tableList
                .map((e) => LifePayModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            _models = items;
            return Column(
              children: [
                // _buildHouseCard(
                //     kEstateName,
                //     userProvider.userDetailModel.estateNames.isEmpty
                //         ? ''
                //         : BeeParse.getEstateName(
                //             userProvider.userDetailModel.estateNames[0])),
                BeeHeaderHouse(),
                16.w.heightBox,
                Container(
                  padding: EdgeInsets.all(32.w),
                  width: double.infinity,
                  color: kForeGroundColor,
                  constraints: BoxConstraints(minHeight: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      '缴费账单'.text.color(ktextPrimary).size(28.sp).make(),
                      ...List.generate(items.length,
                          (index) => _buildCard(items[index], index)),
                    ],
                  ),
                ),
              ],
            );
          }),
      bottomNavi: Container(
        color: kForeGroundColor,
        padding: EdgeInsets.fromLTRB(
            32.w, 16.w, 32.w, 12.w + MediaQuery.of(context).padding.bottom),
        child: Row(
          children: [
            // BeeCheckBox.round(
            //   onChange: (value) {
            //     if (value) {
            //       _selectYears.clear();
            //     } else {
            //       for (var i = 0; i < _models.length; i++) {
            //         _selectYears.add(i);
            //       }
            //     }
            //     setState(() {});
            //   },
            //   size: 40.w,
            // ),
            GestureDetector(
              onTap: () {
                if (_models.length == _selectYears.length) {
                  _selectYears.clear();
                  _totalCost = 0;
                  _count = 0;
                } else {
                  for (var i = 0; i < _models.length; i++) {
                    if (!_selectYears.contains(i)) {
                      _selectYears.add(i);
                    }
                  }
                  _totalCost = 0;
                  _count = 0;
                  for (var item in _selectPay) {
                    _totalCost += item.payTotal;
                    _count += item.payCount;
                  }
                }
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.w,
                        color: _models.length == _selectYears.length
                            ? kPrimaryColor
                            : kDarkSubColor),
                    color: _models.length == _selectYears.length
                        ? kPrimaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.w)),
                curve: Curves.easeInOutCubic,
                width: 40.w,
                height: 40.w,
                child: _models.length == _selectYears.length
                    ? Icon(
                        CupertinoIcons.check_mark,
                        size: 25.w,
                        color: Colors.white,
                      )
                    : SizedBox(),
              ).material(color: Colors.transparent),
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
                          text: '$_totalCost',
                          style: TextStyle(
                              color: kDangerColor,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold)),
                    ])),
                '$_count'.text.color(ktextSubColor).size(20.sp).make(),
              ],
            ),
            24.w.widthBox,
            MaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(37.w)),
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
              onPressed: () {},
              child: '去缴费'.text.black.size(32.sp).bold.make(),
            ),
          ],
        ),
      ),
    );
  }
}
