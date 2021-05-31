import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/model/user/house_model.dart';
import 'package:aku_community/ui/profile/house/house_func.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/others/bee_row_tile.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:aku_community/const/resource.dart';

class MyHouseList extends StatefulWidget {
  MyHouseList({Key? key}) : super(key: key);

  @override
  _MyHouseListState createState() => _MyHouseListState();
}

class _MyHouseListState extends State<MyHouseList> {
  late EasyRefreshController _refreshController;

  List<HouseModel> models = [];
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
      title: '审核记录',
      body: EasyRefresh(
          firstRefresh: true,
          header: MaterialHeader(),
          controller: _refreshController,
          onRefresh: () async {
            models = await HouseFunc.examineHouses;
            print(models);
            setState(() {});
          },
          child: models.isEmpty
              ? Container()
              : ListView.separated(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
                  itemBuilder: (context, index) {
                    return _buildCard(models[index]);
                  },
                  separatorBuilder: (_, __) {
                    return 24.w.heightBox;
                  },
                  itemCount: models.length)),
    );
  }

  Widget _buildCard(HouseModel model) {
    return Container(
      padding: EdgeInsets.all(24.w),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: model.backgroundColor,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              model.roomName!.text.size(32.sp).color(ktextPrimary).bold.make(),
              Spacer(),
              // model.houseStatus.text
              //     .size(30.sp)
              //     .color(model.houseStatusColor)
              //     .make()
            ],
          ),
          16.w.heightBox,
          BeeDivider.horizontal(),
          20.w.heightBox,
          BeeRowTile(
              assetPath: R.ASSETS_ICONS_APPOINTMENT_CODE_PNG,
              titile: '房屋状态',
              content: model.houseStatus.text
                  .size(30.sp)
                  .color(model.houseStatusColor)
                  .make()),
          12.w.heightBox,
          model.effectiveTimeStart == null
              ? SizedBox()
              : BeeRowTile(
                  assetPath: R.ASSETS_ICONS_APPOINTMENT_CODE_PNG,
                  titile: '生效时间',
                  content:
                      ('${DateUtil.formatDate(model.effectiveStartDate, format: 'yyyy-MM-dd HH:mm')}-${DateUtil.formatDate(model.effectiveEndDate, format: 'HH:mm')}')
                          .text
                          .size(28.sp)
                          .color(ktextPrimary)
                          .make())
        ],
      ),
    );
  }
}
