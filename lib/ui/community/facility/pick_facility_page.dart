import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/facility/facility_type_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/community/facility/facility_type_card.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PickFacilityPage extends StatefulWidget {
  PickFacilityPage({Key? key}) : super(key: key);

  @override
  _PickFacilityPageState createState() => _PickFacilityPageState();
}

class _PickFacilityPageState extends State<PickFacilityPage> {
  final EasyRefreshController _refreshController = EasyRefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '选择设施',
      body: BeeListView<FacilityTypeModel>(
        path: API.manager.facility.type,
        controller: _refreshController,
        convert: (model) =>
            model.tableList!.map((e) => FacilityTypeModel.fromJson(e)).toList(),
        builder: (items) {
          return ListView.separated(
            padding: EdgeInsets.all(32.w),
            itemBuilder: (context, index) {
              return FacilityTypeCard(model: items[index]);
            },
            separatorBuilder: (context, index) => 32.hb,
            itemCount: items.length,
          );
        },
      ),
    );
  }
}
