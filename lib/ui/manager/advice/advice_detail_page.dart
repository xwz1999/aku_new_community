import 'package:akuCommunity/model/manager/advice_detail_model.dart';
import 'package:akuCommunity/ui/manager/advice/advice_page.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class AdviceDetailPage extends StatefulWidget {
  final int type;
  AdviceDetailPage({Key key, @required this.type}) : super(key: key);

  @override
  _AdviceDetailPageState createState() => _AdviceDetailPageState();
}

class _AdviceDetailPageState extends State<AdviceDetailPage> {
  bool _loading = true;
  EasyRefreshController _refreshController = EasyRefreshController();
  AdviceDetailModel _model;
  String get adviceValue {
    switch (widget.type) {
      case 1:
        return '咨询';
      case 2:
        return '建议';
      case 3:
        return '投诉';
      case 4:
        return '表扬';
    }
    return '';
  }

  _buildShimmer() {
    return Shimmer.fromColors(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxBox().height(53.w).width(152.w).color(Colors.white).make(),
            30.hb,
            VxBox().height(40.w).width(600.w).color(Colors.white).make(),
            24.hb,
            VxBox().height(33.w).width(263.w).color(Colors.white).make(),
            50.hb,
            VxBox().height(53.w).width(152.w).color(Colors.white).make(),
            30.hb,
            VxBox().height(40.w).width(600.w).color(Colors.white).make(),
            24.hb,
            VxBox().height(33.w).width(263.w).color(Colors.white).make(),
          ],
        ),
      ),
      baseColor: Colors.black12,
      highlightColor: Colors.white10,
    );
  }

  _buildChild() {
    return ListView(
      padding: EdgeInsets.all(32.w),
      children: [
        '您的$adviceValue'.text.black.bold.size(38.sp).make(),
        30.hb,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '查看详情',
      body: EasyRefresh(
        firstRefresh: true,
        child: _loading ? _buildShimmer() : _buildChild(),
        controller: _refreshController,
        header: MaterialHeader(),
        onRefresh: () async {
          _loading = false;
          setState(() {});
        },
      ),
    );
  }
}
