import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/manager/event_voting_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/others/stack_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:akuCommunity/utils/headers.dart';

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

  Widget _buildCard(EventVotingModel model) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: kForeGroundColor, borderRadius: BorderRadius.circular(8.w)),
      child: Column(
        children: [
          ClipRect(
            child: FadeInImage.assetNetwork(
                placeholder: R.ASSETS_IMAGES_LOGO_PNG,
                image: API.image(model.imgUrls[0])),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                model.title.text.black.size(28.sp).bold.make(),
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
                      color: kPrimaryColor,
                      minWidth: 120.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.w),
                      elevation: 0,
                      onPressed: () {},
                      child: '去投票'.text.black.size(20.sp).bold.make(),
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
