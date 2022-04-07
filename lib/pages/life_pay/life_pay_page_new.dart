import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/life_pay/life_pay_model.dart';
import 'package:aku_new_community/pages/life_pay/life_pay_record_page.dart';
import 'package:aku_new_community/pages/life_pay/life_pre_pay_page.dart';
import 'package:aku_new_community/pages/life_pay/pay_finish_page.dart';
import 'package:aku_new_community/pages/life_pay/pay_util.dart';
import 'package:aku_new_community/pages/life_pay/widget/life_pay_detail_page_new.dart';
import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/ui/profile/new_house/my_house_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bee_check_radio.dart';
import 'package:aku_new_community/widget/others/house_head_card.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';

class LifePayPageNew extends StatefulWidget {
  LifePayPageNew({Key? key}) : super(key: key);

  @override
  _LifePayPageNewState createState() => _LifePayPageNewState();
}

class MonthPay {
  double payTotal; //费用
  List<LifePayModel> selectIds; //存储选中的主键id数组
  List<LifePayModel> ids; //存储原先全部主键id数组
  String itemNames; //选择的费用名称
  String timeTitle;
  //月份
  MonthPay(
      {required this.payTotal,
      required this.ids,
      required this.itemNames,
      required this.selectIds,
      required this.timeTitle});
}

class _LifePayPageNewState extends State<LifePayPageNew> {
  EasyRefreshController? _controller;
  List<MonthPay> _selectMonths = []; //选择的月份
  List<LifePayModel> _models = []; //原model,禁止修改
  int _page = 0;
  int _size = 10;
  double _prePrice = 0;

  List<int> _selectModelIndex = []; //选择的月份model，存储其数组下标

  bool get allSelect => ((_selectMonths.length == _selectModelIndex.length) &&
      (_selectMonths.length != 0));

  MonthPay get total {
    double price = 0;
    List<LifePayModel> ids = [];
    for (var i in _selectModelIndex) {
      MonthPay model = _selectMonths[i];

      price += model.payTotal;
      ids.addAll(model.selectIds);
    }
    return MonthPay(
        payTotal: price, ids: [], selectIds: ids, itemNames: '', timeTitle: '');
  }

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();

    Future.delayed(Duration.zero, () {
      if (UserTool.userProvider.defaultHouse == null) {
        Get.off(() => MyHousePage());
        BotToast.showText(text: '请先选择您的房屋');
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    BotToast.closeAllLoading();
    super.dispose();
  }

  Widget _buildCard(MonthPay model, int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
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
                    } else {
                      _selectModelIndex.add(index);
                    }
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10.w, right: 10.w, bottom: 50.w),
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
              model.timeTitle.text
                  .color(Colors.black.withOpacity(0.8))
                  .bold
                  .size(32.sp)
                  .make(),
              13.w.heightBox,
              '已选择：'
                  .richText
                  .withTextSpanChildren([
                    '${model.selectIds.length}'
                        .textSpan
                        .color(Colors.black.withOpacity(0.85))
                        .size(32.sp)
                        .bold
                        .make(),
                    ' / ${model.ids.length}'
                        .textSpan
                        .color(Colors.black.withOpacity(0.25))
                        .size(32.sp)
                        .bold
                        .make(),
                  ])
                  .color(Colors.black.withOpacity(0.65))
                  .size(26.sp)
                  .make(),
              13.w.heightBox,
              SizedBox(
                width: 400.w,
                child: Text(
                  model.itemNames,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ktextSubColor,
                    fontSize: 28.sp,
                  ),
                ),
              ),
              13.w.heightBox,
              RichText(
                  text: TextSpan(
                      text: '合计：',
                      style: TextStyle(
                          color: ktextPrimary,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                        text: '¥ ',
                        style: TextStyle(
                            color: kDangerColor,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: '${model.payTotal.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: kDangerColor,
                            fontSize: 32.sp,
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
                  dynamic back = await Get.to(() => LifePayDetailPageNew(
                        model: model,
                      ));
                  if (back) {
                    for (int i = 0; i < _selectMonths.length; i++) {
                      if (_selectMonths[i].selectIds.isEmpty) {
                        _selectModelIndex
                            .remove(_selectMonths.indexOf(_selectMonths[i]));
                      }
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(22.w),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                  child: '选择明细'
                      .text
                      .color(Colors.black.withOpacity(0.85))
                      .size(22.sp)
                      .bold
                      .make(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _payButton() {
    return MaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(37.w)),
      color: kPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
      onPressed: () async {
        Function cancel = BotToast.showLoading();
        BaseModel baseModel = await NetUtil()
            .post(SAASAPI.pay.createLivingExpensesOrder, params: {
          "chargesBillIds": total.selectIds.map((e) => e.id).toList(),
          "paymentAmount": total.payTotal
        });
        if (baseModel.success) {
          bool result = await PayUtil().callAliPay((baseModel.data as String),
              SAASAPI.pay.livingExpensesOrderCheckAlipay);
          if (result) {
            Get.off(() => PayFinishPage());
          } else {
            ///跳到待付款页面
            BotToast.showText(text: '缴费失败');
          }
        }
        cancel();
      },
      child: '去缴费'.text.black.size(32.sp).bold.make(),
    );
  }

  Widget _buildPrePayment() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '当前预缴'.text.size(28.sp).color(ktextSubColor).make(),
          30.w.heightBox,
          Row(
            children: [
              '¥'.text.size(28.sp).black.make(),
              16.w.widthBox,
              _prePrice.text.size(40.sp).black.bold.make(),
              Spacer(),
              MaterialButton(
                elevation: 0,
                height: 50.w,
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 25.w),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.w),
                    side: BorderSide(color: Color(0xFF979797), width: 1.w)),
                color: Colors.white,
                onPressed: () {
                  Get.to(() => LifePrePayPage(
                        prePay: _prePrice,
                      ));
                },
                child: '预缴充值'.text.size(28.sp).black.make(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<double> _dailyPaymentPrePay() async {
    BaseModel baseModel = await NetUtil().get(SAASAPI.lifePay.findEstateBalance,
        params: {"estateId": UserTool.userProvider.defaultHouse!.id});
    if (baseModel.success) {
      return (baseModel.data as num).toDouble();
    } else {
      return 0;
    }
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
              child: Image.asset(
                Assets.icons.lifePayRecord.path,
                width: 48.w,
                height: 48.w,
              )),
        ),
      ],
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        controller: _controller,
        onRefresh: () async {
          _prePrice = await _dailyPaymentPrePay();
          _selectMonths.clear();

          BaseModel model = await NetUtil().get(
              SAASAPI.lifePay.livingExpensesList,
              params: {'estateId': UserTool.userProvider.defaultHouse!.id});
          if (model.success) {
            if (model.data != null)
              _models = (model.data as List)
                  .map((e) => LifePayModel.fromJson(e))
                  .toList();
          }

          ///先按月份分好
          if (_models.isNotEmpty)
            _models.forEach((element) {
              if (_selectMonths.isEmpty) {
                _selectMonths.add(MonthPay(
                  payTotal: element.payPrincipal + element.defaultAmount,
                  ids: [element],
                  itemNames: element.chargesName ?? '',
                  timeTitle: DateUtil.formatDate(
                      DateTime.parse(element.billDateStart),
                      format: 'yyyy-MM'),
                  selectIds: [element],
                ));
              } else {
                bool same = false;
                for (int i = 0; i < _selectMonths.length; i++) {
                  if (DateUtil.formatDate(DateTime.parse(element.billDateStart),
                          format: 'yyyy-MM') ==
                      _selectMonths[i].timeTitle) {
                    _selectMonths[i].payTotal +=
                        element.defaultAmount + element.payPrincipal;
                    _selectMonths[i].ids.add(element);
                    _selectMonths[i].itemNames +=
                        '、' + (element.chargesName ?? '');

                    _selectMonths[i].selectIds.add(element);
                    same = true;
                  }
                }
                if (!same) {
                  _selectMonths.add(MonthPay(
                      payTotal: element.payPrincipal + element.defaultAmount,
                      ids: [element],
                      selectIds: [element],
                      itemNames: element.chargesName ?? '',
                      timeTitle: DateUtil.formatDate(
                          DateTime.parse(element.billDateStart),
                          format: 'yyyy-MM')));
                }
              }
            });
          if (mounted) setState(() {});
        },
        child: Column(
          children: [
            HouseHeadCard(
                onChanged: () {
                  _controller!.callRefresh();
                },
                context: context),
            16.w.heightBox,
            _buildPrePayment(),
            16.w.heightBox,
            Container(
              //padding: EdgeInsets.all(32.w),
              width: double.infinity,
              color: kForeGroundColor,
              constraints: BoxConstraints(minHeight: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
                    child: '当前账单'.text.color(ktextPrimary).size(28.sp).make(),
                  ),
                  BeeDivider.horizontal(),
                  ...List.generate(_selectMonths.length,
                          (index) => _buildCard(_selectMonths[index], index))
                      .sepWidget(separate: BeeDivider.horizontal()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavi: Container(
        color: kForeGroundColor,
        padding: EdgeInsets.fromLTRB(
            32.w, 16.w, 32.w, 12.w + MediaQuery.of(context).padding.bottom),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (allSelect) {
                  _selectModelIndex.clear();
                  setState(() {});
                } else {
                  _selectModelIndex.clear();
                  for (var i = 0; i < _selectMonths.length; i++) {
                    _selectModelIndex.add(i);
                  }
                  setState(() {});
                }
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
            16.wb,
            '全选'.text.color(ktextSubColor).size(28.sp).bold.make(),
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
                '已选${_selectModelIndex.length}项'
                    .text
                    .color(ktextSubColor)
                    .size(24.sp)
                    .make(),
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
