import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:badges/badges.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/message/message_center_model.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class MessageCenter extends StatefulWidget {
  MessageCenter({Key key}) : super(key: key);

  @override
  _MessageCenterState createState() => _MessageCenterState();
}

class _MessageCenterState extends State<MessageCenter> {
  MessageCenterModel _model;

  Widget _buildMessageTile({
    String title,
    String content,
    int count,
    String path,
  }) {
    bool empty = count == null || count == 0;
    return Row(
      children: [
        Badge(
          elevation: 0,
          position: BadgePosition(top: 8.w, end: 8.w),
          showBadge: !empty,
          child: Image.asset(
            path,
            height: 90.w,
            width: 90.w,
          ),
        ),
        12.wb,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title.text.size(32.sp).bold.make(),
            4.hb,
            (TextUtil.isEmpty(content) ? '没有新通知' : content)
                .text
                .size(28.sp)
                .make(),
          ],
        ).expand(),
      ],
    ).pSymmetric(h: 32.w, v: 18.w);
  }

  Future<MessageCenterModel> _getMessageCenter() async {
    Response response = await NetUtil().dio.get(API.message.center);
    return MessageCenterModel.fromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '消息中心',
      actions: [
        MaterialButton(
          onPressed: () {},
          child: '全部已读'.text.size(28.sp).make(),
        ),
      ],
      body: EasyRefresh(
        header: MaterialHeader(),
        firstRefresh: true,
        onRefresh: () async {
          _model = await _getMessageCenter();
          setState(() {});
        },
        child: _model == null
            ? SizedBox()
            : ListView(
                children: [
                  _buildMessageTile(
                    title: '系统通知',
                    path: R.ASSETS_ICONS_SYSTEM_NOTICE_PNG,
                    content: _model.sysTitle,
                    count: _model.sysCount,
                  ),
                  // _buildMessageTile(
                  //   title: '评论通知',
                  //   path: R.ASSETS_ICONS_COMMENT_NOTICE_PNG,
                  //   content: '',
                  //   count: 0,
                  // ),
                ].sepWidget(separate: Divider(indent: 32.w, endIndent: 32.w)),
              ),
      ).material(color: Colors.white),
    );
  }
}
