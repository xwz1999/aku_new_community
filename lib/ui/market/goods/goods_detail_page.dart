import 'package:flutter/material.dart';

import 'package:aku_community/widget/bee_scaffold.dart';

///商品详情页面
class GoodsDetailPage extends StatefulWidget {
  ///商品ID
  final int id;

  GoodsDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold();
  }
}
