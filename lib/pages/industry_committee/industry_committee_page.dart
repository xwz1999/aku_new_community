import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/user/committee_item_model.dart';
import 'package:akuCommunity/pages/industry_committee/committee_mailbox/committee_mailbox_page.dart';
import 'package:akuCommunity/utils/network/base_list_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:velocity_x/velocity_x.dart';

class IndustryCommitteePage extends StatefulWidget {
  IndustryCommitteePage({Key key}) : super(key: key);

  @override
  _IndustryCommitteePageState createState() => _IndustryCommitteePageState();
}

class _IndustryCommitteePageState extends State<IndustryCommitteePage> {
  EasyRefreshController _refreshController = EasyRefreshController();
  BaseListModel _listModel = BaseListModel.zero();
  List<CommitteeItemModel> _committeeModels = [];
  int _page = 0;

  Future<List<CommitteeItemModel>> _getCommitteeList() async {
    _listModel = await NetUtil().getList(API.manager.commiteeStaff, params: {
      'pageNum': _page,
      'size': 10,
    });
    return _listModel.tableList
        .map((e) => CommitteeItemModel.fromJson(e))
        .toList();
  }

  Future<void> refresh() async {
    _page = 0;
    _listModel = BaseListModel.zero();
    _committeeModels.clear();
    _committeeModels = await _getCommitteeList();
    setState(() {});
  }

  Future addPage() async {
    _page++;
    if (_page >= _listModel.pageCount)
      _refreshController.finishLoad(noMore: true);
    else
      _committeeModels.addAll(await _getCommitteeList());
    setState(() {});
  }

  Widget _buildBottomNavi() {
    return [
      MaterialButton(
        onPressed: () {
          Get.dialog(CupertinoAlertDialog(
            //TODO 业委会电话, for test only
            title: '(0574) 8888 8888'.text.isIntrinsic.make(),
            actions: [
              CupertinoDialogAction(
                child: '取消'.text.isIntrinsic.make(),
                onPressed: Get.back,
              ),
              CupertinoDialogAction(
                child: '呼叫'.text.isIntrinsic.orange500.make(),
                onPressed: () {
                  launch('tel:10086');
                  Get.back();
                },
              ),
            ],
          ));
        },
        height: 98.w,
        color: Color(0xFF2A2A2A),
        child: '业委会电话'.text.white.size(32.sp).make(),
      )
          .box
          .color(Color(0xFF2A2A2A))
          .margin(EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom,
          ))
          .make()
          .expand(),
      MaterialButton(
        onPressed: CommitteeMailboxPage().to,
        height: 98.w,
        color: kPrimaryColor,
        child: '业委会信箱'.text.size(32.sp).color(ktextPrimary).make(),
      )
          .box
          .color(kPrimaryColor)
          .margin(EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom,
          ))
          .make()
          .expand(),
    ].row();
  }

  Widget _buildCard(CommitteeItemModel model) {
    return VxBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.w),
            child: SizedBox(
              height: 150.w,
              width: 150.w,
              child: Placeholder(),
            ),
          ),
          24.wb,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              [
                model.name.text.size(28.sp).color(ktextPrimary).make(),
                Spacer(),
                Container(
                  height: 44.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.w),
                  child: 'XXX'.text.size(24.sp).color(ktextPrimary).make(),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF3CD),
                    borderRadius: BorderRadius.circular(22.w),
                    border: Border.all(color: Color(0xFFFFC40C), width: 1.w),
                  ),
                ),
              ].row(),
              6.hb,
              ...[
                '住址：${model.roomName}'
                    .text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make(),
                '任职期限：XXXXX'.text.size(24.sp).color(ktextSubColor).make(),
                '从事岗位：${model.profession}'
                    .text
                    .size(24.sp)
                    .color(ktextSubColor)
                    .make(),
              ].sepWidget(separate: 10.hb),
            ],
          ).expand(),
        ],
      ),
    ).padding(EdgeInsets.all(20.w)).white.withRounded(value: 8.w).make();
  }

  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '业委会',
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        controller: _refreshController,
        onRefresh: refresh,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
          itemBuilder: (context, index) {
            return _buildCard(_committeeModels[index]);
          },
          separatorBuilder: (context, index) => 20.hb,
          itemCount: _committeeModels.length,
        ),
      ),
      bottomNavi: _buildBottomNavi(),
    );
  }
}
