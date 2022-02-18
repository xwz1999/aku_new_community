import 'dart:io';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/models/community/all_dynamic_list_model.dart';
import 'package:aku_new_community/models/community/topic_list_model.dart';
import 'package:aku_new_community/ui/community/community_views/topic/topic_search_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/picker/grid_image_picker.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNewEventPage extends StatefulWidget {
  final int? initTopic;
  final String? topicName;

  AddNewEventPage({Key? key})
      : initTopic = null,
        topicName = null,
        super(key: key);

  AddNewEventPage.topic({
    Key? key,
    required this.initTopic,
    required this.topicName,
  }) : super(key: key);

  @override
  _AddNewEventPageState createState() => _AddNewEventPageState();
}

class _AddNewEventPageState extends State<AddNewEventPage> {
  bool _commentable = true;
  bool _public = true;
  List<File> _files = [];
  TextEditingController _textEditingController = TextEditingController();
  List<TopicListModel> _hotTopicModels = [];

  ///发表动态
  _addEvent() async {
    if (_textEditingController.text.isEmpty && _files.isEmpty) {
      BotToast.showText(text: '请填写内容');
      return;
    }
    VoidCallback cancel = BotToast.showLoading();
    final String content = _textEditingController.text;
    List<String?>? imgs;
    print(_files.length);
    if (_files.isNotEmpty) {
      imgs = await NetUtil().uploadFiles(_files, SARSAPI.uploadFile.uploadImg);
    }

    Map<String, dynamic> params = {
      'content': content,
      'isComment': _commentable ? 1 : 0,
      'isPublic': _public ? 1 : 0,
      'imgUrls': imgs,
    };
    if (widget.initTopic != null) {
      params.putIfAbsent('topicIds', () => [widget.initTopic]);
    } else {
      params.putIfAbsent(
          'topicIds', () => _hotTopicModels.map((e) => e.id).toList());
    }

    BaseModel baseModel = await NetUtil().post(
      SARSAPI.community.dynamicInsert,
      params: params,
      showMessage: true,
    );
    cancel();
    if (baseModel.success) {
      Get.back(result: true);
    }
  }

  _buildSelectable({
    required String text,
    required bool value,
    required Function(bool) onChange,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.w),
      child: Row(
        children: [
          text.text.size(28.sp).make(),
          Spacer(),
          CupertinoSwitch(value: value, onChanged: onChange)
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '',
      bodyColor: Color(0xFFF9F9F9),
      actions: [
        Hero(
          tag: 'event_add',
          child: MaterialButton(
            elevation: 0,
            minWidth: 116.w,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.w),
            ),
            color: kPrimaryColor,
            onPressed: _addEvent,
            child: '发表'.text.size(34.sp).make(),
          ).centered(),
        ),
        32.wb,
      ],
      body: ListView(
        // padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 32.w),
        children: [
          16.w.heightBox,
          Container(
            padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  minLines: 3,
                  maxLines: 99,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: '分享我的动态',
                    hintStyle: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 34.sp,
                    ),
                  ),
                ),
                GridImagePicker(onChange: (files) => _files = files),
                64.hb,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var res = await Get.to(() => TopicSearchPage());
                        _hotTopicModels.add(res as TopicListModel);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.w, horizontal: 24.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.w),
                            border: Border.all(
                                width: 2.w,
                                color: Color(0xFF000000).withOpacity(0.25))),
                        child: '# '
                            .richText
                            .withTextSpanChildren([
                              '添加话题'
                                  .textSpan
                                  .size(24.sp)
                                  .color(Colors.black.withOpacity(0.85))
                                  .make()
                            ])
                            .size(24.sp)
                            .color(Color(0xFFFAC058))
                            .make(),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                if (_hotTopicModels.isNotEmpty) 24.w.heightBox,
                TopicWidgets(hotTopicModels: _hotTopicModels),
              ],
            ),
          ),
          16.w.heightBox,
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildSelectable(
                    value: _commentable,
                    text: '其他人可评论',
                    onChange: (value) {
                      _commentable = value;
                      setState(() {});
                    }),
                Divider(height: 1.w),
                _buildSelectable(
                    value: _public,
                    text: '是否公开',
                    onChange: (value) {
                      _public = value;
                      setState(() {});
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopicWidgets extends StatelessWidget {
  const TopicWidgets({
    Key? key,
    this.hotTopicModels,
    this.topicTags,
  })  : assert(hotTopicModels != null || topicTags != null),
        super(key: key);

  final List<TopicListModel>? hotTopicModels;
  final List<TopicTag>? topicTags;
  List<dynamic> get models =>
      hotTopicModels == null ? topicTags! : hotTopicModels!;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 24.w,
      runSpacing: 12.w,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        ...models
            .map((e) => Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F7FC).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(25.w)),
                  child: '# ${e.title}'
                      .text
                      .size(24.sp)
                      .color(Color(0xFF547FC0))
                      .make(),
                ))
            .toList(),
      ],
    );
  }
}
