import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:akuCommunity/model/message/system_message_detail_model.dart';
import 'package:akuCommunity/pages/message_center_page/message_func.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class SystemMessageDetailPage extends StatefulWidget {
  final int id;
  SystemMessageDetailPage({Key key, this.id}) : super(key: key);

  @override
  _SystemMessageDetailPageState createState() =>
      _SystemMessageDetailPageState();
}

class _SystemMessageDetailPageState extends State<SystemMessageDetailPage> {
  SystemMessageDetailModel _model;
  bool _onload = true;

  Widget _empty() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold.white(
      title: '查看详情',
      body: EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        onRefresh: () async {
          _model = await MessageFunc.getSystemMessageDetial(widget.id);
          _onload = false;
        },
        child: _onload
            ? _empty()
            : Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.w.heightBox,
                      '系统通知'.text.black.bold.size(32.sp).make(),
                      5.w.heightBox,
                      _model.title.text.black.size(28.sp).isIntrinsic.make(),
                      110.w.heightBox,
                      _model.content.text.black.size(28.sp).isIntrinsic.make(),
                    ],
                  ),
              ),
            ),
      ),
    );
  }
}
