import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/model/manager/mine_goods_model.dart';
import 'package:aku_new_community/pages/goods_manage_page/borrow/borrow_examine_page.dart';
import 'package:aku_new_community/pages/manager_func.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/utils/bee_map.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class MineGoodsPage extends StatefulWidget {
  MineGoodsPage({Key? key}) : super(key: key);

  @override
  _MineGoodsPageState createState() => _MineGoodsPageState();
}

class _MineGoodsPageState extends State<MineGoodsPage> {
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  InkWell _frmLoss(int? id) {
    return InkWell(
      onTap: () async {
        await ManagerFunc.fromLoss(id);
        _controller.callRefresh();
      },
      child: Container(
        width: 120.w,
        height: 44.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 7.w),
        decoration: BoxDecoration(
          color: Color(0xff2a2a2a),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          '报损',
          style: TextStyle(fontSize: 22.sp, color: Colors.white),
        ),
      ),
    );
  }

  InkWell _frmBorrow(int? id) {
    List<int> _list = [];
    _list.add(id!);
    return InkWell(
      onTap: () async {
        BaseModel baseModel = await NetUtil().post(
            API.manager.articleBorrowGoods,
            params: {"ids": _list},
            showMessage: false);
        Get.to(BorrowExaminePage());
      },
      child: Container(
        width: 120.w,
        height: 44.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 7.w),
        decoration: BoxDecoration(
          color: Color(0xff2a2a2a),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          '借用',
          style: TextStyle(fontSize: 22.sp, color: Colors.white),
        ),
      ),
    );
  }

  InkWell _frmReturn(int? id) {
    List<int> _list = [];
    _list.add(id!);
    return InkWell(
      onTap: () async {
        BaseModel baseModel =
            await NetUtil().post(API.manager.articleReturnGoods,
                params: {
                  'ids': _list,
                },
                showMessage: true);
        Get.to(BorrowExaminePage());
      },
      child: Container(
        width: 120.w,
        height: 44.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 7.w),
        decoration: BoxDecoration(
          color: Color(0xff2a2a2a),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          '归还',
          style: TextStyle(fontSize: 22.sp, color: Colors.white),
        ),
      ),
    );
  }

  String _getDatelength(int date) {
    if (date >= 24) {
      return '${(date ~/ 24)}天' + '${date % 24}小时';
    } else {
      return '$date';
    }
  }

  Container _goodsCard(MineGoodsModel model) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.w,
        left: 32.w,
        right: 32.w,
      ),
      padding: EdgeInsets.only(
        top: 30.w,
        left: 38.w,
        right: 34.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '物品名称：${model.name}',
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: Color(0xff4a4b51),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 16.w),
                //   child: Text(
                //     '借还数量：10个',
                //     style: TextStyle(
                //       fontSize: 24.sp,
                //       color: Color(0xff333333),
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  child: Text(
                    '借用时间: ${model.beginDate}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  child: Text(
                    '借用时长: ${_getDatelength(model.borrowDate!)}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '借用状态：',
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Color(0xff999999),
                        ),
                      ),
                      Text(
                        '${BeeMap.borrowStatus[model.borrowStatus]}',
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: BeeMap.borrowStatusColor[model.borrowStatus],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      model.borrowStatus == 1 || model.borrowStatus == 4
                          ? _frmLoss(model.id)
                          : SizedBox(),
                      model.borrowStatus == 0 || model.borrowStatus == 2
                          ? SizedBox(width: 16.w)
                          : SizedBox(),
                      model.borrowStatus == 0 || model.borrowStatus == 2
                          ? _frmBorrow(model.id)
                          : SizedBox(),
                      model.borrowStatus == 1 || model.borrowStatus == 4
                          ? SizedBox(width: 16.w)
                          : SizedBox(),
                      model.borrowStatus == 1 || model.borrowStatus == 4
                          ? _frmReturn(model.id)
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(height: 12.w),
                Divider(color: Color(0xfff9f9f9)),
                model.borrowStatus == 1
                    ? Container(
                        margin: EdgeInsets.only(bottom: 9.w),
                        child: Text(
                          '温馨提示：您的物品已借用${_getDatelength(model.borrowDate!)},如果用完，请及时归还',
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: Color(0xff999999),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '我的借还物品',
      body: BeeListView<MineGoodsModel>(
          path: API.manager.articleBorrowMylist,
          controller: _controller,
          convert: (model) {
            return model.rows.map((e) => MineGoodsModel.fromJson(e)).toList();
          },
          builder: (items) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return _goodsCard(items[index]);
              },
              itemCount: items.length,
            );
          }),
    );
  }
}
