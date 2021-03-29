import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'order_card.dart';

class OrderList extends StatefulWidget {
  OrderList({Key key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Map<String, dynamic>> _listGood = [
    {
      'status': '卖家已发货',
      'listContent': <Map<String, dynamic>>[
        {
          'imagePath': 'assets/example/tz1.png',
          'content': '男士精致生活休闲全羊毛修身西装 全套…',
          'specs': 'S;深蓝色',
          'price': 1123.30,
          'shopNum': 1
        }
      ],
      'totalPrice': 1123.30,
      'payPrice': 1123.30,
      'listButton': <Map<String, dynamic>>[
        {'buttonName': '查看物流'},
        {'buttonName': '确认收货'},
      ],
      'listOrderDetail': <Map<String, dynamic>>[
        {'title': '订单编号', 'subtitle': '3569285692852983'},
        {'title': '创建时间', 'subtitle': '2020-07-23 10:45:12'},
        {'title': '付款时间', 'subtitle': '2020-07-23 10:48:10'},
        {'title': '发货时间', 'subtitle': '2020-07-24 11:21:58'},
      ],
    },
    {
      'status': '交易成功',
      'listContent': <Map<String, dynamic>>[
        {
          'imagePath': 'assets/example/tz2.png',
          'content': '简约气质精致餐具共套 可拼装盘子 海…',
          'specs': '四件套;海豚样式',
          'price': 459.90,
          'shopNum': 1
        }
      ],
      'totalPrice': 459.90,
      'payPrice': 459.90,
      'listButton': <Map<String, dynamic>>[
        {'buttonName': '查看物流'},
        {'buttonName': '申请售后'},
        {'buttonName': '评价'},
      ],
      'listOrderDetail': <Map<String, dynamic>>[
        {'title': '订单编号', 'subtitle': '3569285692852983'},
        {'title': '创建时间', 'subtitle': '2020-07-23 10:45:12'},
        {'title': '付款时间', 'subtitle': '2020-07-23 10:48:10'},
        {'title': '发货时间', 'subtitle': '2020-07-24 11:21:58'},
      ],
    },
    {
      'status': '等待买家付款',
      'listContent': <Map<String, dynamic>>[
        {
          'imagePath': 'assets/example/tz3.png',
          'content': 'ichoo冷淡风白衬衫七分慵懒风 百搭衬衫…',
          'specs': '白色;S',
          'price': 249.00,
          'shopNum': 1
        }
      ],
      'totalPrice': 249.00,
      'payPrice': 249.00,
      'listButton': <Map<String, dynamic>>[
        {'buttonName': '修改地址'},
        {'buttonName': '付款'},
      ],
      'listOrderDetail': <Map<String, dynamic>>[
        {'title': '订单编号', 'subtitle': '3569285692852983'},
        {'title': '创建时间', 'subtitle': '2020-07-23 10:45:12'},
      ],
    },
    {
      'status': '买家已付款',
      'listContent': <Map<String, dynamic>>[
        {
          'imagePath': 'assets/example/tz1.png',
          'content': '设计款不规则高弹力小吊带显瘦修身 搭配简…',
          'specs': '白色;S',
          'price': 99.90,
          'shopNum': 1
        }
      ],
      'totalPrice': 99.90,
      'payPrice': 99.90,
      'listButton': <Map<String, dynamic>>[],
      'listOrderDetail': <Map<String, dynamic>>[
        {'title': '订单编号', 'subtitle': '3569285692852983'},
        {'title': '创建时间', 'subtitle': '2020-07-23 10:45:12'},
        {'title': '付款时间', 'subtitle': '2020-07-23 10:48:10'},
      ],
    },
    {
      'status': '退款中',
      'listContent': <Map<String, dynamic>>[
        {
          'imagePath': 'assets/example/tz3.png',
          'content': '冠军体恤 正版 显瘦修身宽松',
          'specs': '白色;S',
          'price': 99.90,
          'shopNum': 1
        }
      ],
      'totalPrice': 99.90,
      'payPrice': 99.90,
      'listButton': <Map<String, dynamic>>[],
      'listOrderDetail': <Map<String, dynamic>>[
        {'title': '订单编号', 'subtitle': '3569285692852983'},
        {'title': '创建时间', 'subtitle': '2020-07-23 10:45:12'},
        {'title': '付款时间', 'subtitle': '2020-07-23 10:48:10'},
        {'title': '发货时间', 'subtitle': '2020-07-24 11:21:58'},
      ],
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1500));
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1500));

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (context, index) => OrderCard(
        status: _listGood[index]['status'],
        totalPrice: _listGood[index]['totalPrice'],
        payPrice: _listGood[index]['payPrice'],
        listContent: _listGood[index]['listContent'],
        listButton: _listGood[index]['listButton'],
        listOrderDetail: _listGood[index]['listOrderDetail'],
      ),
      itemCount: _listGood.length,
    );
  }
}
