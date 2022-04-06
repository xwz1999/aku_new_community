import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';
import 'package:aku_new_community/models/home/activity_detail_model.dart';
import 'package:aku_new_community/models/home/home_activity_model.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/beeImageNetwork.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:aku_new_community/widget/others/stack_avatar.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'activity_func.dart';
import 'activity_people_list_page.dart';

class ActivityDetailPage extends StatefulWidget {
  final int id;

  const ActivityDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  final EasyRefreshController _refreshController = EasyRefreshController();
  ActivityDetailModel? _model;

  @override
  void initState() {
    _refreshController.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var content = Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.w),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '活动详情'.text.size(32.sp).color(Colors.black).bold.make(),
          32.w.heightBox,
          '${_model?.content}'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.45))
              .make(),
          32.w.heightBox,
          ...List.generate(
              0,
              (index) => Container(
                    width: 686.w,
                    height: 432.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: BeeImageNetwork(
                      urls: [ImgModel.first(_model?.imgList)],
                    ),
                  )),
        ],
      ),
    );
    return BeeScaffold(
      title: '活动详情',
      body: EasyRefresh(
        header: MaterialHeader(),
        controller: _refreshController,
        firstRefresh: true,
        onRefresh: () async {
          BaseModel baseModel = await NetUtil().get(
            SAASAPI.activity.detail,
            params: {'activityId': widget.id},
          );
          _model = ActivityDetailModel.fromJson(baseModel.data);
          setState(() {});
        },
        child: _model == null
            ? SizedBox()
            : ListView(
                children: [
                  _headWidget(),
                  24.w.heightBox,
                  content,
                  24.w.heightBox,
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
                    height: 132.w,
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: BeeImageNetwork(
                            width: 100.w,
                            height: 100.w,
                            imgs: _model!.organizerImgList,
                          ),
                          radius: 50.w,
                        ),
                        20.w.widthBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            '${_model!.unit}'
                                .text
                                .size(28.sp)
                                .color(Colors.black)
                                .make(),
                            8.w.heightBox,
                            '${S.of(context)!.tempPlotName}'
                                .text
                                .size(24.sp)
                                .color(Colors.black.withOpacity(0.25))
                                .make()
                          ],
                        ),
                        Spacer(),
                        MaterialButton(
                          minWidth: 120.w,
                          height: 60.w,
                          onPressed: () {
                            launch('tel:${_model!.tel}');
                          },
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.circular(30.w)),
                          child: '联系物业'
                              .text
                              .size(24.sp)
                              .color(Colors.blueAccent)
                              .make(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavi: BottomButton(
        child: '立即报名'.text.size(32.sp).bold.make(),
        onPressed: !canTap
            ? null
            : () async {
                var re = await NetUtil().get(SAASAPI.activity.registration,
                    params: {'activityId': _model!.id}, showMessage: true);
                if (re.success) {
                  _refreshController.callRefresh();
                }
              },
      ),
    );
  }

  bool get canTap {
    if (_model?.regisEndTime?.isBefore(DateTime.now()) ?? true) {
      return false;
    }
    return true;
  }

  Container _headWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 280.w,
            child: BeeImageNetwork(
              imgs: _model!.imgList,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 32.w, right: 32.w, top: 16.w, bottom: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                '${_model!.title}'
                    .text
                    .size(32.sp)
                    .color(Colors.black.withOpacity(0.85))
                    .maxLines(3)
                    .bold
                    .make(),
                32.w.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                      decoration: BoxDecoration(
                          color: Color(0xFFFEC076).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.w)),
                      alignment: Alignment.center,
                      child: '${ActivityFunc.dateCheck(_model!.regisEndTime)}'
                          .text
                          .size(24.sp)
                          .color(Color(0xFFF48117))
                          .make(),
                    ),
                  ],
                ),
                32.w.heightBox,
                _buildTile(
                  '报名时间',
                  '${DateUtil.formatDate(
                    _model!.regisStartTime,
                    format: 'yyyy.MM.dd HH:mm',
                  )}-${DateUtil.formatDate(
                    _model!.regisEndTime,
                    format: 'yyyy.MM.dd HH:mm',
                  )}',
                ),
                16.hb,
                _buildTile(
                  '活动时间',
                  '${DateUtil.formatDate(
                    _model!.activeTime,
                    format: 'yyyy.MM.dd HH:mm',
                  )}-${DateUtil.formatDate(
                    _model!.activeEndTime,
                    format: 'yyyy.MM.dd HH:mm',
                  )}',
                ),
                // 16.hb,
                // Row(
                //   children: [
                //     '活动方式'.text.size(28.sp).make().box.width(136.w).make(),
                //     '本次活动介绍'
                //         .richText
                //         .tap(() {
                //           var bottomSheet = Container(
                //             width: double.infinity,
                //             padding: EdgeInsets.all(32.w),
                //             decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 borderRadius: BorderRadius.circular(16.w)),
                //             child: Column(
                //               children: [
                //                 '活动介绍'.text.size(32.sp).black.bold.make(),
                //                 32.w.heightBox,
                //                 _model!.content.text
                //                     .size(28.sp)
                //                     .color(Colors.black.withOpacity(0.65))
                //                     .make(),
                //               ],
                //             ),
                //           );
                //           Get.bottomSheet(
                //             bottomSheet,
                //           );
                //         })
                //         .size(28.sp)
                //         .color(Colors.blue)
                //         .make(),
                //     Spacer(),
                //   ],
                // ),
                16.hb,
                Row(
                  children: [
                    '活动费用'.text.size(28.sp).make().box.width(136.w).make(),
                    '免费'.richText.size(28.sp).make(),
                    Spacer(),
                  ],
                ),
                16.w.heightBox,
                Row(
                  children: [
                    '活动地点'.text.size(28.sp).make().box.width(136.w).make(),
                    '${_model!.activityAddress}'
                        .richText
                        .tap(() {})
                        .size(28.sp)
                        .color(Colors.blue)
                        .make(),
                    Spacer(),
                  ],
                ),
                32.w.heightBox,
                BeeDivider.horizontal(),
                16.hb,
                AvatarsParticipate(
                    avatars: _model!.registrationList
                        .map((e) => ImgModel.first(e.avatarImgList))
                        .toList(),
                    pNum: _model!.registrationNum,
                    tNum: _model!.registrationNumMax),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTile(String title, String subTitle) {
    return Row(
      children: [
        title.text.size(28.sp).make().box.width(136.w).make(),
        subTitle.text.size(28.sp).make().expand(),
      ],
    );
  }
}

class AvatarsParticipate extends StatelessWidget {
  final List<String?> avatars;
  final List<Registration>? registrationList;

  //参加人数
  final int pNum;

  //总人数
  final int? tNum;

  final bool? hasIcon;

  const AvatarsParticipate({
    Key? key,
    required this.avatars,
    required this.pNum,
    this.tNum,
    this.hasIcon = true, this.registrationList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ActivityPeopleListPage( registrationList: registrationList,));
      },
      child: Container(
        child: Row(
          children: [
            Offstage(
              offstage: avatars.isEmpty,
              child: StackAvatar(
                avatars: avatars,
              ),
            ),
            16.w.heightBox,
            '${pNum}'
                .richText
                .withTextSpanChildren([
                  '${tNum == null ? '' : '/${tNum}'}人参与'
                      .textSpan
                      .size(24.sp)
                      .black
                      .make()
                ])
                .color(Colors.blueAccent)
                .size(24.sp)
                .make(),
            Spacer(),
            !hasIcon!
                ? SizedBox()
                : Icon(
                    CupertinoIcons.chevron_right,
                    size: 40.w,
                  ),
          ],
        ),
      ),
    );
  }
}
