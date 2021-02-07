import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SendAChat extends StatefulWidget {
  final FocusNode node;
  SendAChat({Key key, this.node}) : super(key: key);

  static Future<bool> send({
    @required int parentId,
    @required int themeId,
  }) async {
    FocusNode node = FocusNode();
    node.requestFocus();
    String result = await Get.bottomSheet(
      SendAChat(node: node),
      barrierColor: Colors.transparent,
    );
    if (result != null) {
      await NetUtil().post(
        API.community.sendAComment,
        params: {
          'parentId': parentId,
          'gambitThemeId': themeId,
          'content': result,
        },
        showMessage: true,
      );
      return true;
    }
    return false;
  }

  @override
  _SendAChatState createState() => _SendAChatState();
}

class _SendAChatState extends State<SendAChat> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          focusNode: widget.node,
          controller: _textEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ).p(16.w).expand(),
        16.wb,
        MaterialButton(
          color: kPrimaryColor,
          onPressed: () {
            Get.back(result: _textEditingController.text);
          },
          minWidth: 64.w,
          child: '发送'.text.make(),
        ),
        16.wb,
      ],
    ).material(color: Colors.white);
  }
}
