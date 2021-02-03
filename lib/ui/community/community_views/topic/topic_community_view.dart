import 'dart:ui';

import 'package:akuCommunity/ui/community/community_views/topic/topic_detail_page.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/community/community_topic_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class TopicCommunityView extends StatefulWidget {
  TopicCommunityView({Key key}) : super(key: key);

  @override
  _TopicCommunityViewState createState() => _TopicCommunityViewState();
}

class _TopicCommunityViewState extends State<TopicCommunityView>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController = EasyRefreshController();

  _buildItem(CommunityTopicModel model) {
    var firstImg = '';
    if (model?.imgUrls?.isNotEmpty ?? false) {
      firstImg = model?.imgUrls?.first?.url ?? '';
    }
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 53.w, vertical: 20.w),
      onPressed: () {
        Get.to(TopicDetailPage(id: model.id));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Colors.black12,
            ),
            child: Stack(
              children: [
                FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                  image: API.image(firstImg),
                  height: 160.w,
                  width: 250.w,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(8.w),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      //TODO 等待后端接口补充话题摘要
                      // model.summary
                      child: ('#${''}')
                          .text
                          .center
                          .size(28.sp)
                          .white
                          .make()
                          .material(color: Colors.black26),
                    ),
                  ),
                ),
              ],
            ),
          ),
          12.wb,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (model?.gambitTitle ?? '')
                  .text
                  .maxLines(2)
                  .size(28.sp)
                  .bold
                  .overflow(TextOverflow.ellipsis)
                  .make(),
              (model?.content ?? '')
                  .text
                  .maxLines(1)
                  .size(22.sp)
                  .overflow(TextOverflow.ellipsis)
                  .make(),
              12.hb,
            ],
          ).expand(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BeeListView(
      path: API.community.topicList,
      controller: _refreshController,
      convert: (model) {
        return model.tableList
            .map((e) => CommunityTopicModel.fromJson(e))
            .toList();
      },
      builder: (items) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return _buildItem(items[index]);
          },
          separatorBuilder: (_, __) => 20.hb,
          itemCount: items.length,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
