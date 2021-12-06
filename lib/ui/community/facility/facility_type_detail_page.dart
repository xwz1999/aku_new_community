import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/facility/facility_type_detail_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class FacilityTypeDetailPage extends StatefulWidget {
  final int id;
  final FacilityTypeDetailModel? model;

  FacilityTypeDetailPage({
    Key? key,
    required this.model,
    required this.id,
  }) : super(key: key);

  @override
  _FacilityTypeDetailPageState createState() => _FacilityTypeDetailPageState();
}

class _FacilityTypeDetailPageState extends State<FacilityTypeDetailPage> {
  List<FacilityTypeDetailModel> _models = [];

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择设施',
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          BaseModel model = await NetUtil().get(
            API.manager.facility.detailType,
            params: {'categoryId': widget.id},
          );
          _models = (model.data as List)
              .map((e) => FacilityTypeDetailModel.fromJson(e))
              .toList();
          setState(() {});
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            final item = _models[index];
            return ListTile(
              onTap: () => selectModel(item),
              leading: Radio(
                value: item,
                groupValue: widget.model,
                onChanged: (_) {
                  selectModel(item);
                },
              ),
              title: Text(item.name),
            );
          },
          separatorBuilder: (_, __) => BeeDivider.horizontal(),
          itemCount: _models.length,
        ),
      ),
    );
  }

  void selectModel(FacilityTypeDetailModel model) {
    Get.back(result: model);
  }
}
