import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/pages/message_center_page/comment_message/comment_message_page.dart';
import 'package:aku_community/pages/message_center_page/system_message/system_message_page.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class MessageCenterPage extends StatefulWidget {
  MessageCenterPage({Key? key}) : super(key: key);

  @override
  _MessageCenterPageState createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  EasyRefreshController? _refreshController;
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

  Widget _buildCard({
    required String path,
    required String title,
    required String content,
    int? count,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(28.w, 32.w, 28.w, 20.w),
        child: Row(
          children: [
            SizedBox(
                width: 90.w,
                height: 90.w,
                child: Badge(
                  child: Image.asset(path),
                  showBadge: count != 0,
                  elevation: 0,
                  position: BadgePosition.topEnd(top: 8.w, end: 8.w),
                )),
            15.w.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.text.black.bold.size(32.sp).make(),
                5.w.heightBox,
                (content).text.black.size(28.sp).make(),
              ],
            ).expand()
          ],
        ),
      ),
    ).material(color: Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return BeeScaffold(
        title: '消息中心',
        actions: [
          MaterialButton(
            onPressed: () async {
              await NetUtil().dio!.get(API.message.allRead);
              _refreshController!.callRefresh();
              setState(() {});
            },
            child: '全部已读'.text.size(28.sp).black.make(),
            padding: EdgeInsets.symmetric(horizontal: 32.w),
          ),
        ],
        body: EasyRefresh(
          header: MaterialHeader(),
          firstRefresh: true,
          onRefresh: () async {
            appProvider.getMessageCenter();
          },
          child: Column(
            children: [
              _buildCard(
                path: R.ASSETS_ICONS_SYSTEM_NOTICE_PNG,
                title: '系统通知',
                content: appProvider.messageCenterModel.sysTitle ?? '无系统通知消息',
                count: appProvider.messageCenterModel.sysCount ?? 0,
                onTap: () => Get.to(() => SystemMessagePage()),
              ),
              _buildCard(
                path: R.ASSETS_ICONS_COMMENT_NOTICE_PNG,
                title: '评论通知',
                content:
                    appProvider.messageCenterModel.commentTitle ?? '无评论通知消息',
                count: appProvider.messageCenterModel.commentCount ?? 0,
                onTap: () async {
                  await NetUtil().dio!.get(API.message.allReadComment);
                  Get.to(() => CommentMessagePage());
                  setState(() {});
                },
              ),
              // _buildCard(
              //   path: R.ASSETS_ICONS_SHOP_NOTICE_PNG,
              //   title: '商城通知',
              //   content: '',
              //   count: 0,
              // )
            ],
          ),
        ));
  }
}
