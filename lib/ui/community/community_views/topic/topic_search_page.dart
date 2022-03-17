import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/extensions/widget_list_ext.dart';
import 'package:aku_new_community/models/community/topic_list_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/num_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class TopicSearchPage extends StatefulWidget {
  const TopicSearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _TopicSearchPageState createState() => _TopicSearchPageState();
}

class _TopicSearchPageState extends State<TopicSearchPage> {
  List<TopicListModel> _models = [];
  bool isHot = true;

  Future _getModels() async {
    var re = await NetUtil().get(SAASAPI.community.topicList, params: {
      'pageNum': 1,
      'size': 10,
    });
    if (re.success) {
      _models = (re.data['rows'] as List)
          .map((e) => TopicListModel.fromJson(e))
          .toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    _getModels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appbar = PreferredSize(
      preferredSize: Size.fromHeight(128.w),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.w),
                    color: Colors.black.withOpacity(0.06)),
                padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 32.w),
                margin: EdgeInsets.only(left: 32.w),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6.w),
                      child: Icon(
                        CupertinoIcons.search,
                        size: 32.w,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ),
                    12.w.widthBox,
                    Expanded(
                      child: TextField(
                        onSubmitted: (text) async {
                          if (text.isEmpty) {
                            isHot = true;
                            _getModels();
                            return;
                          }
                          var re = await NetUtil()
                              .get(SAASAPI.community.topicList, params: {
                            'pageNum': 1,
                            'size': 20,
                          });
                          if (re.success) {
                            _models = (re.data['rows'] as List)
                                .map((e) => TopicListModel.fromJson(e))
                                .toList();
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            hintText: '请输入话题关键字',
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.25),
                                fontSize: 24.sp),
                            isDense: true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: '取消'
                    .text
                    .size(28.sp)
                    .color(Colors.black.withOpacity(0.45))
                    .make())
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: appbar,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
        children: [
          Offstage(
            offstage: !isHot,
            child: '猜你喜欢'
                .text
                .size(26.sp)
                .color(Colors.black.withOpacity(0.45))
                .make(),
          ),
          ..._models
              .map((e) => _tile(e))
              .toList()
              .sepWidget(separate: BeeDivider.horizontal())
        ],
      ),
    );
  }

  Widget _tile(TopicListModel model) {
    return GestureDetector(
      onTap: () {
        Get.back(result: model);
      },
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 28.w),
          child: Row(
            children: [
              '#'.text.size(24.sp).color(Color(0xFAC058)).make(),
              model.title.text
                  .size(26.sp)
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
              Spacer(),
              '${model.dynamicNum}条动态'
                  .text
                  .size(26.sp)
                  .color(Colors.black.withOpacity(0.85))
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
