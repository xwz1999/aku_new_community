import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/facility/facility_order_date_list_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class FacilityOrderDateListPage extends StatefulWidget {
  final int facilitiesId;

  FacilityOrderDateListPage({Key? key, required this.facilitiesId})
      : super(key: key);

  @override
  _FacilityOrderDateListPageState createState() =>
      _FacilityOrderDateListPageState();
}

class _FacilityOrderDateListPageState extends State<FacilityOrderDateListPage> {
  late EasyRefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
        title: '预约时段',
        body: BeeListView(
            path: API.manager.facilityOrderDateList,
            extraParams: {
              "facilitiesId": widget.facilitiesId,
            },
            controller: _refreshController,
            convert: (models) {
              return models.tableList!
                  .map((e) => FacilityOrderDateListModel.fromJson(e))
                  .toList();
            },
            builder: (items) {
              return ListView.separated(
                  padding: EdgeInsets.all(32.w),
                  itemBuilder: (context, index) {
                    return _buildCard(items[index]);
                  },
                  separatorBuilder: (_, __) {
                    return 24.w.heightBox;
                  },
                  itemCount: items.length);
            }));
  }

  Widget _buildCard(FacilityOrderDateListModel model) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              '预约记录'.text.size(32.sp).color(ktextPrimary).bold.make(),
              Spacer(),
            ],
          ),
          16.w.heightBox,
          BeeDivider.horizontal(),
          20.w.heightBox,
          Row(
            children: [
              '预约人姓名'.text.size(28.sp).color(ktextPrimary).make(),
              Spacer(),
              model.appointmentName.text
                  .size(28.sp)
                  .color(ktextSubColor)
                  .bold
                  .make(),
            ],
          ),
          12.w.heightBox,
          Row(
            children: [
              '预约时段'.text.size(28.sp).color(ktextPrimary).make(),
              Spacer(),
              model.tiemSlot.text.size(28.sp).color(ktextSubColor).bold.make(),
            ],
          )
        ],
      ),
    );
  }
}
