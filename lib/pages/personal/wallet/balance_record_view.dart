import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/models/wallet/trade_record_list_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/picker/bee_date_picker.dart';
import 'package:aku_new_community/widget/picker/bee_picker_box.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class BalanceRecordView extends StatefulWidget {
  const BalanceRecordView({Key? key}) : super(key: key);

  @override
  _BalanceRecordViewState createState() => _BalanceRecordViewState();
}

class _BalanceRecordViewState extends State<BalanceRecordView> {
  EasyRefreshController _refreshController = EasyRefreshController();

  List<TradeRecordListModel> _models = [];
  int _pageNum = 1;
  int _size = 10;
  DateTime _pickTime = DateTime.now();
  int _pickType = 0;

  Map<int, String> _types = {
    1: '支付',
    2: '退还',
    3: '充值',
    4: '收入',
    5: '提现',
    6: '抵扣',
  };

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  var date = await BeeDatePicker.monthPicker(
                      DateTime.now().subtract(Duration(days: 365)));
                  if (date != null) {
                    _pickTime = date;
                  }
                  setState(() {});
                },
                child: Row(
                  children: [
                    '${_pickTime.year}年${_pickTime.month}月'
                        .text
                        .size(28.sp)
                        .color(Colors.black.withOpacity(0.85))
                        .make(),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 32.w,
                      color: Colors.black.withOpacity(0.45),
                    )
                  ],
                ),
              ),
              Spacer(),
              MaterialButton(
                color: Colors.black.withOpacity(0.06),
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BeePickerBox(
                        onPressed: () {
                          Get.back();
                          setState(() {});
                        },
                        child: CupertinoPicker.builder(
                          itemExtent: 60.w,
                          childCount: _types.values.length,
                          onSelectedItemChanged: (index) {
                            _pickType = _types.keys.toList()[index];
                          },
                          itemBuilder: (context, index) {
                            var str = _types.values.toList()[index];
                            return Center(
                              child: str.text.size(32.sp).isIntrinsic.make(),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                shape: StadiumBorder(),
                elevation: 0,
                child: Row(
                  children: [
                    '${_pickType == 0 ? '全部类型' : _types[_pickType]}'
                        .text
                        .size(24.sp)
                        .color(Colors.black.withOpacity(0.45))
                        .make(),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 24.w,
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Container(
            color: Colors.white,
            child: EasyRefresh(
              header: MaterialHeader(),
              footer: MaterialFooter(),
              firstRefresh: true,
              controller: _refreshController,
              onRefresh: () async {
                _pageNum = 1;
                var baseList = await NetUtil()
                    .getList(SAASAPI.balance.tradeRecordList, params: {
                  'pageNum': _pageNum,
                  'size': _size,
                  'modelType': 0,
                  'type': _pickType,
                  'createDate': _pickTime,
                });

                _models = baseList.rows
                    .map((e) => TradeRecordListModel.fromJson(e))
                    .toList();

                setState(() {});
              },
              onLoad: () async {
                _pageNum++;
                var baseList = await NetUtil()
                    .getList(SAASAPI.balance.tradeRecordList, params: {
                  'pageNum': _pageNum,
                  'size': _size,
                  'modelType': 0,
                  'type': _pickType,
                  'createDate': _pickTime,
                });
                if (baseList.total > _models.length) {
                  _models.addAll(baseList.rows
                      .map((e) => TradeRecordListModel.fromJson(e))
                      .toList());
                } else {
                  _refreshController.finishLoad(noMore: true);
                }
                setState(() {});
              },
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
                children: _models.map((e) => _buildCard(e)).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool incom(type) => [2, 3, 4].contains(type);

  Widget _buildCard(TradeRecordListModel model) {
    return Column(
      children: [
        Row(
          children: [
            '${_types[model.type]}-${model.content}'
                .text
                .size(28.sp)
                .color(Colors.black.withOpacity(0.85))
                .make(),
            Spacer(),
            '${incom(model.type) ? '+' : '-'}¥${model.payAmount}'
                .text
                .size(28.sp)
                .color(incom(model.type)
                    ? Colors.red
                    : Colors.black.withOpacity(0.85))
                .make(),
          ],
        ),
        8.hb,
        '${DateUtil.formatDateStr(model.createDate, format: 'MM/dd HH:mm')}'
            .text
            .size(28.sp)
            .color(Colors.black.withOpacity(0.85))
            .make(),
      ],
    );
  }
}
