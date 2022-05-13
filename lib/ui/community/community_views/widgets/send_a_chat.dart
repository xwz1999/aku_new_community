import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class SendAChat extends StatefulWidget {
  final FocusNode? node;

  SendAChat({Key? key, this.node}) : super(key: key);

  static Future<bool> send({
    required int? rootId,
    required int? parentId,
    required int? dynamicId,
  }) async {
    FocusNode node = FocusNode();
    node.requestFocus();
    String? result = await Get.bottomSheet(
      SendAChat(node: node),
      barrierColor: Colors.transparent,
    );
    if (result != null) {
      await NetUtil().post(
        SAASAPI.community.commentInsert,
        params: {
          'rootId': rootId,
          'parentId': parentId,
          'dynamicId': dynamicId,
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
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.w,
      child: Row(
        children: [
          TextField(
            focusNode: widget.node,
            controller: _textEditingController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20.w),
              filled: true,
              fillColor: Color(0x0F000000),
              hintText: '参与评论',
              hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),

              //
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(40.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(40.w),
              ),
            ),
          ).p(16.w).expand(),
          16.wb,
          GestureDetector(
            onTap: () {
              Get.back(result: _textEditingController.text);
            },
            child: Container(
              height: 55.w,
              width: 120.w,
              decoration: BoxDecoration(
                color: Color(0xFFFAC058),
                borderRadius: BorderRadius.all(Radius.circular(34.w)),
              ),
              alignment: Alignment.center,
              child: '发布'.text.size(28.sp).color(Color(0xD9000000)).make(),
            ),
          ),
          // MaterialButton(
          //   color: kPrimaryColor,
          //
          //   onPressed: () {
          //     Get.back(result: _textEditingController.text);
          //   },
          //   minWidth: 64.w,
          //   child: '发送'.text.make(),
          // ),
          16.wb,
        ],
      ).material(color: Colors.white),
    );
  }
}
