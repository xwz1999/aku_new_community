// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/community/community_topic_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/ui/community/community_views/topic/topic_detail_page.dart';
import 'package:akuCommunity/utils/headers.dart';

class TopicCommunityView extends StatefulWidget {
  TopicCommunityView({Key key}) : super(key: key);

  @override
  TopicCommunityViewState createState() => TopicCommunityViewState();
}

class TopicCommunityViewState extends State<TopicCommunityView>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController = EasyRefreshController();
  refresh() {
    _refreshController?.callRefresh();
  }

  _buildItem(CommunityTopicModel model) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 53.w, vertical: 20.w),
      onPressed: () {
        Get.to(TopicDetailPage(model: model));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  FadeInImage.assetNetwork(
                    placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                    image: API.image(model.firstImg),
                    height: 160.w,
                    width: 250.w,
                    fit: BoxFit.cover,
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
                        child: ('#${model.summary}')
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
          ),
          12.wb,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (model?.title ?? '')
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
