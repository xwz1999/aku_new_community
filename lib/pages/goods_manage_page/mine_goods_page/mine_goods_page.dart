// Flutter imports:
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/mine_goods_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/utils/bee_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// Project imports:
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class MineGoodsPage extends StatefulWidget {
  MineGoodsPage({Key key}) : super(key: key);

  @override
  _MineGoodsPageState createState() => _MineGoodsPageState();
}

class _MineGoodsPageState extends State<MineGoodsPage> {
  EasyRefreshController _controller;

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

  InkWell _frmLoss() {
    return InkWell(
      onTap: () {},
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

  String _getDatelength(int date) {
    if (date >= 24) {
      return '${date / 24}' + '${date % 24}';
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
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  child: Text(
                    '借还数量：10个',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Color(0xff333333),
                    ),
                  ),
                ),
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
                    '借用时长: ${_getDatelength(model.borrowDate)}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '借用状态: ${BeeMap.borrowStatus}',
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Color(0xff999999),
                        ),
                      ),
                      _frmLoss(),
                    ],
                  ),
                ),
                SizedBox(height: 12.w),
                Divider(color: Color(0xfff9f9f9)),
                model.borrowStatus == 1
                    ? Container(
                        margin: EdgeInsets.only(bottom: 9.w),
                        child: Text(
                          '温馨提示：您的物品已借用${_getDatelength(model.borrowDate)},如果用完，请及时归还',
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
      // body: RefreshConfiguration(
      //   child: SmartRefresher(
      //     controller: _refreshController,
      //     header: WaterDropHeader(),
      //     footer: ClassicFooter(),
      //     onRefresh: _onRefresh,
      //     onLoading: _onLoading,
      //     enablePullUp: true,
      //     child: ListView.builder(
      //       itemBuilder: (BuildContext context, int index) => _goodsCard(
      //         _listGoods[index]['title'],
      //         _listGoods[index]['borrowTime'],
      //         _listGoods[index]['timeLength'],
      //         _listGoods[index]['status'],
      //         _listGoods[index]['goodsNum'],
      //       ),
      //       itemCount: _listGoods.length,
      //     ),
      //   ),
      // ),
      body: BeeListView(
          path: API.manager.articleBorrowMylist,
          controller: _controller,
          convert: (model) {
            return model.tableList
                .map((e) => MineGoodsModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return ListView.builder(itemBuilder: (context, index) {
              return _goodsCard(items[index]);
            });
          }),
    );
  }
}
