import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class MineGoodsPage extends StatefulWidget {
  MineGoodsPage({Key key}) : super(key: key);

  @override
  _MineGoodsPageState createState() => _MineGoodsPageState();
}

class _MineGoodsPageState extends State<MineGoodsPage> {
  List<Map<String, dynamic>> _listGoods = [
    {
      'title': '榔头',
      'goodsNum': 6,
      'borrowTime': '2020.09.18 12:00',
      'timeLength': '7',
      'status': '未还'
    },
    {
      'title': '梯子',
      'goodsNum': 1,
      'borrowTime': '2020.08.28 12:00',
      'timeLength': '3',
      'status': '已还'
    },
    {
      'title': '电钻',
      'goodsNum': 1,
      'borrowTime': '2020.07.04 12:00',
      'timeLength': '6',
      'status': '未还'
    },
    {
      'title': '多功能螺丝刀',
      'goodsNum': 4,
      'borrowTime': '2020.04.06 12:00',
      'timeLength': '4',
      'status': '已还'
    },
    {
      'title': '手电筒',
      'goodsNum': 2,
      'borrowTime': '2020.02.19 12:00',
      'timeLength': '2',
      'status': '已还'
    },
    {
      'title': '胶带',
      'goodsNum': 3,
      'borrowTime': '2020.01.14 12:00',
      'timeLength': '8',
      'status': '未还'
    },
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1500));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1500));

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  InkWell _frmLoss() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: Screenutil.length(120),
        height: Screenutil.length(44),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: Screenutil.length(7)),
        decoration: BoxDecoration(
          color: Color(0xff2a2a2a),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          '报损',
          style: TextStyle(fontSize: Screenutil.size(22), color: Colors.white),
        ),
      ),
    );
  }

  Container _goodsCard(
      String title, borrowTime, timeLength, status, int goodsNum) {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(20),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
      ),
      padding: EdgeInsets.only(
        top: Screenutil.length(30),
        left: Screenutil.length(38),
        right: Screenutil.length(34),
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
                  '物品名称：${title}',
                  style: TextStyle(
                    fontSize: Screenutil.size(28),
                    color: Color(0xff4a4b51),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Screenutil.length(16)),
                  child: Text(
                    '借还数量：${goodsNum}个',
                    style: TextStyle(
                      fontSize: Screenutil.size(24),
                      color: Color(0xff333333),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Screenutil.length(16)),
                  child: Text(
                    '借用时间: ${borrowTime}',
                    style: TextStyle(
                      fontSize: Screenutil.size(24),
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Screenutil.length(16)),
                  child: Text(
                    '借用时长: ${timeLength}日',
                    style: TextStyle(
                      fontSize: Screenutil.size(24),
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Screenutil.length(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '借用状态: ${status}',
                        style: TextStyle(
                          fontSize: Screenutil.size(24),
                          color: Color(0xff999999),
                        ),
                      ),
                      _frmLoss(),
                    ],
                  ),
                ),
                SizedBox(height: Screenutil.length(12)),
                Divider(color: Color(0xfff9f9f9)),
                status == '未还'
                    ? Container(
                        margin: EdgeInsets.only(bottom: Screenutil.length(9)),
                        child: Text(
                          '温馨提示：您的物品已借用${timeLength}天，如果用完，请及时归还',
                          style: TextStyle(
                            fontSize: Screenutil.size(22),
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
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '我的借还物品',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: RefreshConfiguration(
        child: SmartRefresher(
          controller: _refreshController,
          header: WaterDropHeader(),
          footer: ClassicFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          enablePullUp: true,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) => _goodsCard(
              _listGoods[index]['title'],
              _listGoods[index]['borrowTime'],
              _listGoods[index]['timeLength'],
              _listGoods[index]['status'],
              _listGoods[index]['goodsNum'],
            ),
            itemCount: _listGoods.length,
          ),
        ),
      ),
    );
  }
}
