import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/message/system_message_model.dart';
import 'package:aku_community/pages/message_center_page/system_message/system_message_detail_page.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/utils/bee_map.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:aku_community/widget/bee_divider.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

class SystemMessagePage extends StatefulWidget {
  SystemMessagePage({Key? key}) : super(key: key);

  @override
  _SystemMessagePageState createState() => _SystemMessagePageState();
}

class _SystemMessagePageState extends State<SystemMessagePage> {
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

  Widget _buildCard(SystemMessageModel model) {
    return InkWell(
      onTap: () async {
        await NetUtil().dio!.get(API.message.readMessage, queryParameters: {
          'sysMessageId': model.id,
        });
        Get.to(() => SystemMessageDetailPage(id: model.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: kForeGroundColor,
          borderRadius: BorderRadius.circular(4.w),
        ),
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(30.w, 20.w, 20.w, 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                '系统通知'.text.black.bold.size(32.sp).make(),
                Spacer(),
                BeeMap.messageRead[model.status!]!.text
                    .color(BeeMap.messageIsRead[model.status!]!
                        ? Color(0xFF999999)
                        : Colors.red)
                    .size(32.sp)
                    .make()
              ],
            ),
            5.w.heightBox,
            model.title!.text.black
                .size(28.sp)
                .maxLines(1)
                .isIntrinsic
                .ellipsis
                .make(),
            5.w.heightBox,
            model.content!.text.black
                .size(28.sp)
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .isIntrinsic
                .make(),
            30.w.heightBox,
            BeeDivider.horizontal(),
            14.w.heightBox,
            Row(
              children: [
                '查看详情'.text.black.size(28.sp).make(),
                Spacer(),
                Icon(
                  CupertinoIcons.chevron_forward,
                  size: 28.w,
                ),
              ],
            ),
          ],
        ),
      ),
    ).material();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '系统通知',
      body: BeeListView<SystemMessageModel>(
          path: API.message.sysMessageList,
          controller: _refreshController,
          convert: (models) {
            return models.tableList!
                .map((e) => SystemMessageModel.fromJson(e))
                .toList();
          },
          builder: (items) {
            return ListView.separated(
                padding: EdgeInsets.all(32.w),
                itemBuilder: (context, index) {
                  return _buildCard(items[index]);
                },
                separatorBuilder: (_, __) {
                  return 32.w.heightBox;
                },
                itemCount: items.length);
          }),
    );
  }
}
