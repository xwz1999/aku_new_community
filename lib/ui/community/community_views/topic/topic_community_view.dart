import 'dart:ui';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/models/community/topic_list_model.dart';
import 'package:aku_new_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_new_community/ui/community/community_views/topic/topic_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_image_network.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class TopicCommunityView extends StatefulWidget {
  TopicCommunityView({Key? key}) : super(key: key);

  @override
  TopicCommunityViewState createState() => TopicCommunityViewState();
}

class TopicCommunityViewState extends State<TopicCommunityView> {
  EasyRefreshController _refreshController = EasyRefreshController();

  _buildItem(TopicListModel model, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TopicDetailPage(topicId: model.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 32.w),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        index <= 2
                            ? Container(
                                width: 36.w,
                                height: 35.w,
                                clipBehavior: Clip.antiAlias,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(index == 0
                                        ? R.ASSETS_ICONS_ICON_TOPIC_FIRST_PNG
                                        : index == 1
                                            ? R.ASSETS_ICONS_ICON_TOPIC_SECOND_PNG
                                            : R.ASSETS_ICONS_ICON_TOPIC_THIRD_PNG),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: (index + 1)
                                    .text
                                    .white
                                    .size(24.sp)
                                    .bold
                                    .make(),
                              )
                            : Container(
                                width: 32.w,
                                height: 32.w,
                                clipBehavior: Clip.antiAlias,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xFFC4C4C4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.w)),
                                ),
                                child: (index + 1)
                                    .text
                                    .white
                                    .size(24.sp)
                                    .bold
                                    .make(),
                              ),
                        15.wb,
                        Container(
                          width: 400.w,
                          child: ('#' + model.title)
                              .text
                              .maxLines(1)
                              .size(30.sp)
                              .bold
                              .isIntrinsic
                              .overflow(TextOverflow.ellipsis)
                              .make(),
                        )
                      ],
                    ),
                    20.hb,
                    (model.content)
                        .text
                        .maxLines(2)
                        .size(22.sp)
                        .color(Color(0xFF666666))
                        .overflow(TextOverflow.ellipsis)
                        .make(),
                    21.hb,
                  ],
                ).box.make().expand(),
                12.wb,
                Hero(
                  // tag: "${model.firstImg}_${model.id}",
                  tag: model.hashCode.toString(),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                      color: Colors.black12,
                    ),
                    child: Stack(
                      children: [
                        BeeImageNetwork(imgs: model.imgList),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            32.w.heightBox,
            Row(
              children: [
                '${model.dynamicNum}条动态 · ${model.commentNum}人讨论'
                    .text
                    .size(24.sp)
                    .color(Colors.black.withOpacity(0.45))
                    .make()
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '所有话题'.text.color(ktextPrimary).size(32.sp).normal.make(),
      body: BeeListView<TopicListModel>(
        path: SAASAPI.community.topicList,
        controller: _refreshController,
        convert: (model) {
          return model.rows.map((e) => TopicListModel.fromJson(e)).toList();
        },
        builder: (items) {
          return ListView.separated(
            padding: EdgeInsets.only(top: 20.w),
            itemBuilder: (context, index) {
              return _buildItem(items[index], index);
            },
            separatorBuilder: (_, __) => 20.hb,
            itemCount: items.length,
          );
        },
      ),
    );
  }
}
