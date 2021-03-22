import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/model/manager/fixed_detail_model.dart';
import 'package:akuCommunity/pages/manager_func.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';

class FixedEvaluatePage extends StatefulWidget {
  final FixedDetailModel model;
  FixedEvaluatePage(this.model, {Key key}) : super(key: key);

  @override
  _FixedEvaluatePageState createState() => _FixedEvaluatePageState();
}

class _FixedEvaluatePageState extends State<FixedEvaluatePage> {
  int _rating;
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '评价',
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 52.w),
        children: [
          '请您对本次服务进行评价'.text.color(ktextSubColor).size(28.sp).make(),
          50.w.heightBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              '综合评价'.text.color(ktextSubColor).size(28.sp).make(),
              35.w.widthBox,
              RatingBar(
                  ratingWidget: RatingWidget(
                    full: Icon(
                      CupertinoIcons.star_fill,
                      color: kDarkPrimaryColor,
                    ),
                    half: Icon(
                      CupertinoIcons.star_lefthalf_fill,
                      color: kDarkPrimaryColor,
                    ),
                    empty: Icon(
                      CupertinoIcons.star,
                      color: kDarkSubColor,
                    ),
                  ),
                  itemSize: 35.w,
                  itemCount: 5,
                  initialRating: 0,
                  allowHalfRating: true,
                  itemPadding: EdgeInsets.symmetric(horizontal: 15.w),
                  onRatingUpdate: (rating) {
                    _rating = (rating * 2).toInt();
                  })
            ],
          ),
          60.w.heightBox,
          '请输入内容'.text.black.size(28.sp).make(),
          24.w.heightBox,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 32.w),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFD4CFBE), width: 1.w),
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: _textEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                hintText: '您对本次服务满意吗?',
                hintStyle: TextStyle(
                  color: ktextSubColor,
                ),
              ),
              maxLines: 10,
              minLines: 6,
            ),
          ),
          100.w.heightBox,
          MaterialButton(
            onPressed: () async {
              if (_textEditingController.text.isEmpty) {
                BotToast.showText(text: '评价内容不能为空！');
              } else {
                BaseModel baseModel = await ManagerFunc.reportRepairEvaluate(
                    widget.model.appReportRepairVo.id,
                    _rating,
                    _textEditingController.text);
                if (baseModel.status) {
                  Get.back();
                }
              }
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48.w)),
            color: kPrimaryColor,
            minWidth: 686.w,
            padding: EdgeInsets.symmetric(
              vertical: 26.w,
            ),
            child: '发布'.text.black.size(32.sp).bold.make(),
          ),
        ],
      ),
    );
  }
}
