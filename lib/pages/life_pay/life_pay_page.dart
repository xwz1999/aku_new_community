import 'package:akuCommunity/constants/app_values.dart';
import 'package:akuCommunity/provider/app_provider.dart';
import 'package:akuCommunity/ui/profile/house/pick_my_house_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/life_pay_model.dart';
import 'package:akuCommunity/pages/life_pay/widget/life_pay_detail_page.dart';
import 'package:akuCommunity/pages/life_pay/widget/my_house_page.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/provider/user_provider.dart';
import 'package:akuCommunity/utils/bee_parse.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
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
  SelectPay({this.payCount, this.payTotal});
}

class _LifePayPageState extends State<LifePayPage> {
  EasyRefreshController _controller;
  List<int> _selectYears = [];
  List<LifePayModel> _models = [];
  List<SelectPay> _selectPay = [];
  double _totalCost = 0;
  int _count = 0;
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

  Widget _buildHouseCard() {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Material(
      color: kForeGroundColor,
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '当前房屋'.text.black.size(28.sp).make(),
            32.w.heightBox,
            GestureDetector(
              onTap: () {
                Get.to(() => PickMyHousePage());
              },
              child: Row(
                children: [
                  Image.asset(
                    R.ASSETS_ICONS_HOUSE_PNG,
                    width: 60.w,
                    height: 60.w,
                  ),
                  40.w.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        S
                            .of(context)
                            .tempPlotName
                            .text
                            .black
                            .size(32.sp)
                            .bold
                            .make(),
                        10.w.heightBox,
                        appProvider.selectedHouse.roomName.text.black
                            .size(32.sp)
                            .bold
                            .make()
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    size: 40.w,
                  ),
                ],
              ).material(color: Colors.transparent),
            ),
            24.w.heightBox,
          ],
        ),
      ),
    );
  }

  Widget _buildCard(LifePayModel model, int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w),
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
                  setState(() {
                    if (_selectYears.contains(index)) {
                      _selectYears.remove(index);
                      _totalCost -= (_selectPay[index].payTotal ?? 0.0);
                      _count -= (_selectPay[index].payCount ?? 0);
                      if (_count < 0) {
                        _count = 0;
                      }
                      if (_totalCost < 0) {
                        _totalCost = 0;
                      }
                    } else {
                      _selectYears.add(index);
                      _totalCost += (_selectPay[index].payTotal ?? 0.0);
                      _count += (_selectPay[index].payCount ?? 0);
                    }
                  });
                },
                child: BeeCheckRadio(
                  value: index,
                  groupValue: _selectYears,
                ),
              ),
            ],
          ),
          24.w.widthBox,
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
              '待缴：${model.paymentNum}项  已选${_selectPay[index].payCount}项'
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
                        text: '¥ ${_selectPay[index].payTotal}',
                        style: TextStyle(
                            color: kDangerColor,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold)),
                  ]))
            ],
          ).expand(),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  List payMent = await Get.to(
                      () => LifePayDetailPage(model: _models[index]));
                  _selectPay[index].payCount = payMent[0];
                  _selectPay[index].payTotal = payMent[1];
                  setState(() {});
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
        //TODO 缴费记录 无接口
        // InkWell(
        //   onTap: () {
        //     LifePayRecordPage().to();
        //   },
        //   child: Container(
        //     padding: EdgeInsets.fromLTRB(32.w, 28.w, 32.w, 20.w),
        //     alignment: Alignment.center,
        //     child: '缴费记录'.text.black.size(28.sp).make(),
        //   ),
        // ),
      ],
      body: BeeListView(
          path: API.manager.dailyPaymentList,
          controller: _controller,
          extraParams: {
            'estateId': userProvider.currentHouseId,
          },
          convert: (model) {
            _selectPay = List.generate(model.tableList.length,
                (index) => SelectPay(payCount: 0, payTotal: 0.0));
            return model.tableList
                .map((e) => LifePayModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            _models = items;
            return Column(
              children: [
                _buildHouseCard(),
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
                              (index) => _buildCard(items[index], index))
                          .sepWidget(separate: BeeDivider.horizontal()),
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
                '已选$_count项'.text.color(ktextSubColor).size(20.sp).make(),
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
