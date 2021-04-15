import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart' hide Response;
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/advice_detail_model.dart';
import 'package:akuCommunity/model/manager/suggestion_or_complain_model.dart';
import 'package:akuCommunity/ui/manager/advice/advice_add_comment_page.dart';
import 'package:akuCommunity/ui/manager/advice/advice_evaluate_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/buttons/bottom_button.dart';
import 'package:akuCommunity/widget/views/bee_grid_image_view.dart';

class AdviceDetailPage extends StatefulWidget {
  final SuggestionOrComplainModel model;
  AdviceDetailPage({Key key, @required this.model}) : super(key: key);

  @override
  _AdviceDetailPageState createState() => _AdviceDetailPageState();
}

class _AdviceDetailPageState extends State<AdviceDetailPage> {
  bool _loading = true;
  EasyRefreshController _refreshController = EasyRefreshController();
  AdviceDetailModel _model;
  String get adviceValue {
    switch (widget.model.type) {
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
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.white10,
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
          Divider(
            height: 50.w,
            thickness: 1.w,
            color: Color(0xFFD8D8D8),
          ),
          BeeGridImageView(
            urls: widget.model.imgUrls.map((e) => e.url).toList(),
            padding: EdgeInsets.only(right: 100.w),
          ),
        ],
      ),
    );
  }

  _buildAdviceContent(AppAdviceContentVos item) {
    String type = '';
    switch (item.createUserType) {
      case 1:
        type = '您';
        break;
      case 2:
        type = '装修公司';
        break;
      case 3:
        type = '物业';
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '$type\的回复'.text.size(38.sp).bold.make(),
        28.hb,
        item.content.text.size(28.sp).color(ktextSubColor).make(),
        24.hb,
        DateUtil.formatDate(item.date, format: 'yyyy年MM月dd日 HH:mm')
            .text
            .size(24.sp)
            .color(Color(0xFF999999))
            .make(),
        50.hb,
      ],
    );
  }

  _buildChild() {
    return ListView(
      padding: EdgeInsets.all(32.w),
      children: [
        '您的$adviceValue'.text.black.bold.size(38.sp).make(),
        30.hb,
        _model.appAdviceDetailVo.appAdviceVo.content.text
            .color(ktextSubColor)
            .size(28.sp)
            .make(),
        24.hb,
        DateUtil.formatDate(
          _model.appAdviceDetailVo.appAdviceVo.date,
          format: 'yyyy年MM月dd日 HH:mm',
        ).text.size(24.sp).color(Color(0xFF999999)).make(),
        Divider(
          height: 50.w,
          thickness: 1.w,
          color: Color(0xFFD8D8D8),
        ),
        BeeGridImageView(
          urls: widget.model.imgUrls.map((e) => e.url).toList(),
          padding: EdgeInsets.only(right: 100.w),
        ),
        Divider(
          height: 50.w,
          thickness: 1.w,
          color: Color(0xFFD8D8D8),
        ),
        ..._model.appAdviceDetailVo.appAdviceContentVos
            .map((e) => _buildAdviceContent(e))
            .toList(),
      ],
    );
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '查看详情',
      actions: [
        TextButton(
          onPressed: () =>
              Get.to(() => AdviceEvaluatePage(id: widget.model.id)),
          child: '评价'.text.make(),
        ),
      ],
      body: EasyRefresh(
        firstRefresh: true,
        child: _loading ? _buildShimmer() : _buildChild(),
        controller: _refreshController,
        header: MaterialHeader(),
        onRefresh: () async {
          Response res = await NetUtil().dio.get(
            API.manager.adviceDetail,
            queryParameters: {'adviceId': widget.model.id},
          );
          _model = AdviceDetailModel.fromJson(res.data);
          _loading = false;
          if (mounted) setState(() {});
        },
      ),
      bottomNavi: BottomButton(
        onPressed: () async {
          bool result =
              await Get.to(() => AdviceAddCommentPage(id: widget.model.id));
          if (result && mounted) _refreshController.callRefresh();
        },
        child: '继续提问'.text.bold.make(),
      ),
    );
  }
}
