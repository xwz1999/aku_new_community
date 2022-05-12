import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/facility/facility_type_detail_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../constants/saas_api.dart';
import '../../../models/facility/facility_type_model.dart';
import 'facility_type_card.dart';
import 'facility_type_detail_card.dart';

class FacilityTypeDetailPage extends StatefulWidget {
  final FacilityTypeModel facilityModel;

  FacilityTypeDetailPage({
    Key? key,
    required this.facilityModel,
  }) : super(key: key);

  @override
  _FacilityTypeDetailPageState createState() => _FacilityTypeDetailPageState();
}

class _FacilityTypeDetailPageState extends State<FacilityTypeDetailPage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  List<FacilityTypeDetailModel> _models = [];
  int _page = 1;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择设施',
      body: EasyRefresh(
        controller: _refreshController,
        firstRefresh: true,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {
          _page = 1;
          BaseListModel model = await NetUtil()
              .getList(SAASAPI.facilities.manageList, params: {
            'pageNum': _page,
            'size': 10,
            'facilitiesCategoryId': widget.facilityModel.id
          });
          _models = model.rows
              .map((e) => FacilityTypeDetailModel.fromJson(e))
              .toList();
          setState(() {});
        },
        onLoad: () async {
          _page++;
          BaseListModel model = await NetUtil()
              .getList(SAASAPI.facilities.manageList, params: {
            'pageNum': _page,
            'size': 10,
            'facilitiesCategoryId': widget.facilityModel.id
          });
          _models=model.rows
              .map((e) => FacilityTypeDetailModel.fromJson(e))
              .toList();
          setState(() {});
        },
        child: ListView.separated(
          padding: EdgeInsets.all(32.w),
          itemBuilder: (context, index) {
            return FacilityTypeDetailCard(model: _models[index],facilityModel:widget.facilityModel);
          },
          separatorBuilder: (context, index) => 32.hb,
          itemCount: _models.length,
        ),
      ),
    );
  }

  void selectModel(FacilityTypeDetailModel model) {
    Get.back(result: model);
  }
}
