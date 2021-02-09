// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyrefresh/easy_refresh.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/event_voting_model.dart';
import 'package:akuCommunity/pages/event_activity/voting_detail_page.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/others/stack_avatar.dart';

class EventVotingPage extends StatefulWidget {
  EventVotingPage({Key key}) : super(key: key);

  @override
  _EventVotingPageState createState() => _EventVotingPageState();
}

class _EventVotingPageState extends State<EventVotingPage> {
  EasyRefreshController _controller;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String _getButtonText(int status) {
    switch (status) {
      case 1:
      case 2:
        return '去参与';
      case 3:
        return '已结束';
      case 4:
        return '已填写';
      default:
        return '';
    }
  }

  Widget _buildCard(EventVotingModel model) {
    return Container(
      // clipBehavior: Clip.,
      decoration: BoxDecoration(
          color: kForeGroundColor, borderRadius: BorderRadius.circular(8.w)),
      child: Column(
        children: [
          SizedBox(
            height: 210.w,
            width: double.infinity,
            child: ClipRect(
              child: FadeInImage.assetNetwork(
                  placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                  image: API.image(
                      model.imgUrls.isNotEmpty ? model.imgUrls.first.url : '')),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                model.title.text.black
                    .size(28.sp)
                    .bold
                    .overflow(TextOverflow.ellipsis)
                    .make(),
                16.w.heightBox,
                model.content.text.color(ktextSubColor).size(24.sp).make(),
                8.w.heightBox,
                RichText(
                    text: TextSpan(
                        text: '投票时间:',
                        style: TextStyle(
                          color: ktextSubColor,
                          fontSize: 24.sp,
                        ),
                        children: [
                      TextSpan(
                        style: TextStyle(
                          color: ktextPrimary,
                          fontSize: 24.sp,
                        ),
                        text: model.beginDate + '至' + model.endDate,
                      ),
                    ])),
                16.w.heightBox,
                Row(
                  children: [
                    StackAvatar(
                        avatars: model.headImgURls.map((e) => e.url).toList()),
                    Spacer(),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.w)),
                      color: model.status == 3 ? kDarkSubColor : kPrimaryColor,
                      minWidth: 120.w,
                      height: 44.w,
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.w),
                      elevation: 0,
                      onPressed: () {
                        VotingDetailPage(
                          id: model.id,
                        ).to();
                      },
                      child: (_getButtonText(model.status))
                          .text
                          .black
                          .size(20.sp)
                          .bold
                          .make(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '活动投票',
      body: BeeListView(
          path: API.manager.enventVotingList,
          controller: _controller,
          convert: (model) {
            return model.tableList
                .map((e) => EventVotingModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
                separatorBuilder: (context, index) {
                  return 20.w.heightBox;
                },
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _buildCard(items[index]);
                });
          }),
    );
  }
}
