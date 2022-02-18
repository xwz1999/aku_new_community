import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/models/service_browse/service_browse_list_mode.dart';
import 'package:aku_new_community/utils/link_text_parase.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';

class ServiceBrowseDetailPage extends StatefulWidget {
  final ServiceBrowseListModel model;

  ServiceBrowseDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _ServiceBrowseDetailPageState createState() =>
      _ServiceBrowseDetailPageState();
}

class _ServiceBrowseDetailPageState extends State<ServiceBrowseDetailPage> {
  ServiceBrowseListModel get _detailModel => widget.model;
  late List<String> _parasedText;
  late TapGestureRecognizer _tapLinkUrlLancher; //设置单击手势识别器
  @override
  void initState() {
    super.initState();
    _tapLinkUrlLancher = TapGestureRecognizer();
    _parasedText = LinkTextParase.stringParase(widget.model.content);
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '服务浏览',
      bodyColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        children: [
          _detailModel.name.text
              .size(32.sp)
              .color(ktextPrimary)
              .bold
              .align(TextAlign.center)
              .make(),
          24.w.heightBox,
          SizedBox(
            width: double.infinity,
            child: RichText(
              text: TextSpan(
                  children: List.generate(_parasedText.length, (index) {
                if (index.isEven) {
                  return TextSpan(
                    text: _parasedText[index],
                    style: TextStyle(fontSize: 28.sp, color: ktextPrimary),
                  );
                } else {
                  return TextSpan(
                      text: _parasedText[index],
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: Colors.lightBlue,
                      ),
                      recognizer: _tapLinkUrlLancher
                        ..onTap = () {
                          launch(_parasedText[index]);
                        });
                }
              })),
            ),
          ),
          40.w.heightBox,
          Row(
            children: [
              Spacer(),
              '发布于 ${DateUtil.formatDateStr(_detailModel.createDate, format: 'MM-dd HH:mm')}'
                  .text
                  .size(24.sp)
                  .color(ktextSubColor)
                  .make(),
            ],
          )
        ],
      ),
    );
  }
}
