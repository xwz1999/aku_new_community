// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:akuCommunity/const/resource.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/community/activity_detail_model.dart';
import 'package:akuCommunity/ui/community/activity/activity_people_list_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/others/stack_avatar.dart';
import 'package:akuCommunity/widget/picker/bee_image_preview.dart';

class ActivityDetailPage extends StatefulWidget {
  final int id;
  ActivityDetailPage({Key key, @required this.id}) : super(key: key);

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  ActivityDetailModel model;
  EasyRefreshController _refreshController = EasyRefreshController();

  Widget get emptyWidget => Shimmer.fromColors(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxBox().white.height(45.w).width(544.w).make(),
            48.hb,
            VxBox()
                .white
                .height(228.w)
                .width(double.infinity)
                .withRounded(value: 8.w)
                .make(),
            44.hb,
            ...List.generate(
              3,
              (index) => VxBox()
                  .white
                  .height(45.w)
                  .width(544.w)
                  .margin(EdgeInsets.symmetric(vertical: 5.w))
                  .make(),
            ),
          ],
        ).pSymmetric(h: 32.w, v: 24.w),
        baseColor: Colors.black12,
        highlightColor: Colors.white,
      );
  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  _buildTile(String title, String subTitle) {
    return Row(
      children: [
        title.text.size(28.sp).make().box.width(136.w).make(),
        subTitle.text.size(28.sp).make().expand(),
      ],
    ).pSymmetric(h: 32.w);
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '活动详情',
      body: EasyRefresh(
        header: MaterialHeader(),
        onRefresh: () async {
          BaseModel baseModel = await NetUtil().get(
            API.community.activityDetail,
            params: {'activityId': widget.id},
          );
          model = ActivityDetailModel.fromJson(baseModel.data);
          setState(() {});
        },
        controller: _refreshController,
        firstRefresh: true,
        emptyWidget: model == null ? emptyWidget : null,
        child: model == null
            ? SizedBox()
            : ListView(
                children: [
                  model.title.text
                      .size(32.sp)
                      .bold
                      .make()
                      .pSymmetric(h: 32.w, v: 24.w),
                  48.hb,
                  ...model.imgUrls
                      .map((e) => GestureDetector(
                            onTap: () {
                              Get.to(
                                BeeImagePreview.path(path: API.image(e.url)),
                                opaque: false,
                              );
                            },
                            child: Hero(
                              tag: API.image(e.url),
                              child: Container(
                                height: 228.w,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(8.w),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: FadeInImage.assetNetwork(
                                  placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                                  image: e.url,
                                ),
                              ),
                            ),
                          ).pSymmetric(h: 32.w))
                      .toList(),
                  44.hb,
                  model.content.text.size(28.sp).make().pSymmetric(h: 32.w),
                  44.hb,
                  _buildTile(
                    '开始时间',
                    DateUtil.formatDate(
                      model.startDate,
                      format: 'yyyy年MM月dd日 HH:mm',
                    ),
                  ),
                  _buildTile(
                    '结束时间',
                    DateUtil.formatDate(
                      model.endDate,
                      format: 'yyyy年MM月dd日 HH:mm',
                    ),
                  ),
                  _buildTile('地        点', model.location),
                  _buildTile('参与人数', '不限'),
                  _buildTile(
                    '报名截止',
                    DateUtil.formatDate(
                      model.registEndDate,
                      format: 'yyyy年MM月dd日 HH:mm',
                    ),
                  ),
                  115.hb,
                  Container(
                    height: 24.w,
                    color: Color(0xFFF9F9F9),
                  ),
                  MaterialButton(
                    height: 92.w,
                    onPressed: () =>
                        Get.to(ActivityPeopleListPage(id: widget.id)),
                    child: Row(
                      children: [
                        StackAvatar(
                          avatars: model.headImgURls.map((e) => e.url).toList(),
                        ),
                        Spacer(),
                        '已有${model.countRegistration}人参加'
                            .text
                            .size(28.sp)
                            .make(),
                        16.wb,
                        Icon(
                          CupertinoIcons.chevron_forward,
                          size: 30.w,
                          color: Color(0xFFD8D8D8),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1.w, indent: 32.w, endIndent: 32.w),
                ],
              ),
      ).material(color: Colors.white),
    );
  }
}
