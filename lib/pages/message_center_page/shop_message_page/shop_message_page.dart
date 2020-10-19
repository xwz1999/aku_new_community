import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class ShopMessagePage extends StatefulWidget {
  ShopMessagePage({Key key}) : super(key: key);

  @override
  _ShopMessagePageState createState() => _ShopMessagePageState();
}

class _ShopMessagePageState extends State<ShopMessagePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController _controller;

  List<Map<String, dynamic>> _listNotice = [
    {
      'status': '已读',
      'type': '您的订单已签收',
      'imagePath': 'assets/example/tz1.png',
      'content': '您购买的  轻便自由，男士针织休闲西装  已签收',
      'lookType': '查看快递'
    },
    {
      'status': '已读',
      'type': '您的订单已发货',
      'imagePath': 'assets/example/tz2.png',
      'content': '您购买的  亚瑟士/Asic Gel轻跑鞋黑武士  已发货 ',
      'lookType': '查看快递'
    },
    {
      'status': '已读',
      'type': '交易退款成功',
      'imagePath': 'assets/example/tz3.png',
      'content': '您的订单已退款成功 来自退款编号：6236402934702983',
      'lookType': '查看详情'
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  void noteCreateRouter() {
    // Navigator.pushNamed(
    //   context,
    //   PageName.note_create_page.toString(),
    // );
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

  void refundRouter() {
    Navigator.pushNamed(context, PageName.common_page.toString(),
        arguments: Bundle()
          ..putMap('commentMap', {
            'title': '退款详情',
            'isActions': false,
          }));
  }

  void expressRouter() {}

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  InkWell _inkWellLook(String type, content, lookType) {
    return InkWell(
      onTap: () {
        lookType == '查看详情' ? refundRouter() : expressRouter();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lookType,
            style: TextStyle(
                fontSize: Screenutil.size(28), color: Color(0xff333333)),
          ),
          Icon(AntDesign.right, size: Screenutil.size(40)),
        ],
      ),
    );
  }

  Container _containerCard(String status, type, imagePath, content, lookType) {
    return Container(
      margin: EdgeInsets.only(
        top: Screenutil.length(32),
        left: Screenutil.length(32),
        right: Screenutil.length(32),
      ),
      padding: EdgeInsets.only(
          top: Screenutil.length(21),
          bottom: Screenutil.length(14),
          left: Screenutil.length(30),
          right: Screenutil.length(20)),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: Offset(1, 1),
              blurRadius: 10.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: Screenutil.length(2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '商城通知',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Screenutil.size(32),
                          color: Color(0xff333333)),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          fontSize: Screenutil.size(32),
                          color: Color(0xff999999)),
                    ),
                  ],
                ),
                SizedBox(height: Screenutil.length(5)),
                Text(type,
                    style: TextStyle(
                        fontSize: Screenutil.size(28),
                        color: Color(0xff333333))),
                SizedBox(height: Screenutil.length(8)),
                Row(
                  children: [
                    Image.asset(
                      imagePath,
                      height: Screenutil.length(120),
                      width: Screenutil.length(120),
                    ),
                    SizedBox(width: Screenutil.length(32)),
                    Container(
                      width: Screenutil.length(439),
                      child: Text(
                        content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Screenutil.size(28),
                            color: Color(0xff999999)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: Screenutil.length(30)),
          Divider(),
          _inkWellLook(type, content, lookType),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '商城通知',
          subtitle: '清空',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: RefreshConfiguration(
        hideFooterWhenNotFull: true,
        child: SmartRefresher(
          controller: _refreshController,
          header: WaterDropHeader(),
          footer: ClassicFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          enablePullUp: true,
          child: ListView.builder(
            itemBuilder: (context, index) => _containerCard(
              _listNotice[index]['status'],
              _listNotice[index]['type'],
              _listNotice[index]['imagePath'],
              _listNotice[index]['content'],
              _listNotice[index]['lookType'],
            ),
            itemCount: _listNotice.length,
          ),
        ),
      ),
    );
  }
}
