import 'package:aku_community/pages/life_pay/pay_util.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/manager/life_pay_model.dart';
import 'package:aku_community/pages/life_pay/life_pay_record_page.dart';
import 'package:aku_community/pages/life_pay/pay_finish_page.dart';
import 'package:aku_community/pages/life_pay/widget/life_pay_detail_page.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/ui/profile/house/pick_my_house_page.dart';
import 'package:aku_community/utils/bee_parse.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bee_check_radio.dart';

class LifePayPage extends StatefulWidget {
  LifePayPage({Key? key}) : super(key: key);

  @override
  _LifePayPageState createState() => _LifePayPageState();
}

class SelectPay {
  double payTotal; //费用
  int payCount; //项数
  List<int> ids; //存储选中的主键id数组
  SelectPay(
      {required this.payCount, required this.payTotal, required this.ids});
}

class _LifePayPageState extends State<LifePayPage> {
  EasyRefreshController? _controller;
  List<int> _selectYears = []; //选择的年份，存储其数组下标
  List<LifePayModel?> _models = [];
  List<SelectPay> _selectPay = []; //辅助计算总费用数组 储存下级页面传递出来的已选费用参数
  double _totalCost = 0; //总费用
  int _count = 0; //费用项数
  List _ids = []; //存储选中的主键id数组

  bool get allSelect =>
      ((_models.length == _selectYears.length) && (_models.length != 0));

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    BotToast.closeAllLoading();
    super.dispose();
  }

  Widget _buildHouseCard() {
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
                _controller!.callRefresh();
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
                            .of(context)!
                            .tempPlotName
                            .text
                            .black
                            .size(32.sp)
                            .bold
                            .make(),
                        10.w.heightBox,
                        appProvider.selectedHouse!.roomName.text.black
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
                      _totalCost -= (_selectPay[index].payTotal);
                      _count -= (_selectPay[index].payCount);
                      _selectPay[index].ids.forEach((element) {
                        _ids.remove(element);
                      });
                    } else {
                      _selectYears.add(index);
                      _totalCost += (_selectPay[index].payTotal);
                      _count += (_selectPay[index].payCount);
                      _ids.addAll(_selectPay[index].ids);
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
              '${BeeParse.getCustomYears(model.years!)}(${model.years})'
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
                        text:
                            '¥ ${_selectPay[index].payTotal.toStringAsFixed(2)}',
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
                  if (_selectYears.contains(index)) {
                    _totalCost -= _selectPay[index].payTotal;
                    _count -= _selectPay[index].payCount;
                    _selectPay[index].ids.forEach((element) {
                      _ids.remove(element);
                    });
                  }

                  List payMent = await (Get.to(
                      () => LifePayDetailPage(model: _models[index])));
                  _selectPay[index].payCount = payMent[0];
                  _selectPay[index].payTotal = payMent[1];
                  _selectPay[index].ids = payMent[2];
                  if (_selectYears.contains(index)) {
                    _totalCost += _selectPay[index].payTotal;
                    _count += _selectPay[index].payCount;
                  }
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

  double getPayTotal(LifePayModel list) {
    num total = 0;
    if (list.dailyPaymentTypeVos != null) {
      for (var item in list.dailyPaymentTypeVos!) {
        for (var v in item.detailedVoList!) {
          total += v.paymentPrice ?? 0;
        }
      }
    }
    return total as double;
  }

  List<int> getIds(LifePayModel list) {
    List<int> _list = [];
    if (list.dailyPaymentTypeVos != null) {
      for (var item in list.dailyPaymentTypeVos!) {
        for (var v in item.detailedVoList!) {
          _list.addAll(_findIds(v.detailsVoList ?? []));
        }
      }
    }
    return _list;
  }

  List<int> _findIds(List<DetailsVoList> list) {
    List<int> _list = [];
    list.forEach((element) {
      _list.add(element.id!);
    });
    return _list;
  }

  _allSelectOption() {
    //若已全选则清空已选年份数组
    if (_models.length == _selectYears.length) {
      _selectYears.clear();
      _ids.clear();
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
      _ids.clear();
      for (var item in _selectPay) {
        _totalCost += item.payTotal;
        _count += item.payCount;
        _ids.addAll(item.ids);
      }
    }
    setState(() {});
  }

  Widget _payButton() {
    return MaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(37.w)),
      color: kPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
      onPressed: () async {
        Function cancel = BotToast.showLoading();
        BaseModel baseModel =
            await NetUtil().post('/user/alipay/dailyPaymentAlipay', params: {
          "ids": _ids,
          "payType": 1, //暂时写死 等待后续补充
          "payPrice": _totalCost.toStringAsFixed(2)
        });
        if (baseModel.status ?? false) {
          bool result = await PayUtil()
              .callAliPay(baseModel.message!, API.pay.dailPayMentCheck);
          if (result) {
            Get.off(PayFinishPage());
          }
        }
        cancel();
      },
      child: '去缴费'.text.black.size(32.sp).bold.make(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
      title: '生活缴费',
      actions: [
        InkWell(
          onTap: () {
            Get.to(() => LifePayRecordPage());
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(32.w, 28.w, 32.w, 20.w),
            alignment: Alignment.center,
            child: '缴费记录'.text.black.size(28.sp).make(),
          ),
        ),
      ],

      //TODO:重构listview;
      body: BeeListView<LifePayModel>(
          path: API.manager.dailyPaymentList,
          controller: _controller,
          extraParams: {'estateId': appProvider.selectedHouse!.estateId},
          convert: (model) {
            List<LifePayModel> lifePayModels =
                model.tableList!.map((e) => LifePayModel.fromJson(e)).toList();
            _selectPay.clear();
            _selectPay.addAll(lifePayModels
                .map((e) => SelectPay(
                    payCount: e.dailyPaymentTypeVos!.length,
                    payTotal: getPayTotal(e),
                    ids: getIds(e)))
                .toList());
            return lifePayModels;
          },
          builder: (items) {
            if (items != null) _models = items as List<LifePayModel?>;
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
                _allSelectOption();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.w,
                        color: allSelect ? kPrimaryColor : kDarkSubColor),
                    color: allSelect ? kPrimaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.w)),
                curve: Curves.easeInOutCubic,
                width: 40.w,
                height: 40.w,
                child: allSelect
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
                          text: _totalCost.toStringAsFixed(2),
                          style: TextStyle(
                              color: kDangerColor,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold)),
                    ])),
                '已选$_count项'.text.color(ktextSubColor).size(20.sp).make(),
              ],
            ),
            24.w.widthBox,
            _payButton(),
          ],
        ),
      ),
    );
  }
}
