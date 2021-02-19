import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/message/system_message_model.dart';
import 'package:akuCommunity/pages/things_page/widget/bee_list_view.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_divider.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:akuCommunity/utils/headers.dart';

class MessageCenterPage extends StatefulWidget {
  MessageCenterPage({Key key}) : super(key: key);

  @override
  _MessageCenterPageState createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  EasyRefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  Map<int, bool> isRead = {
    1: false,
    3: true,
  };
  Widget _buildCard({
    String path,
    String title,
    SystemMessageModel model,
  }) {
    return InkWell(
      onTap: () async {
        await NetUtil().dio.get(API.message.readMessage);
        
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(28.w, 32.w, 28.w, 20.w),
        child: Row(
          children: [
            SizedBox(
                width: 90.w,
                height: 90.w,
                child: Badge(
                  child: Image.asset(path),
                  showBadge: !isRead[model.status],
                  elevation: 0,
                  position: BadgePosition.topEnd(top: 8.w, end: 8.w),
                )),
            15.w.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.text.black.bold.size(32.sp).make(),
                5.w.heightBox,
                model.content.text.black.size(28.sp).make(),
              ],
            ).expand()
          ],
        ),
      ),
    ).material(color: Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '消息中心',
      body: BeeListView(
          path: API.message.sysMessageList,
          controller: _refreshController,
          convert: (models) {
            return models.tableList
                .map((e) => SystemMessageModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return _buildCard(
                    path: R.ASSETS_ICONS_SYSTEM_NOTICE_PNG,
                    title: '系统通知',
                    model: items[index],
                  );
                },
                separatorBuilder: (_, __) {
                  return BeeDivider.horizontal(
                    indent: 28.w,
                    endIndent: 28.w,
                  );
                },
                itemCount: items.length);
          }),
    );
  }
}
