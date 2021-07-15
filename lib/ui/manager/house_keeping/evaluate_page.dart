import 'dart:io';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/picker/grid_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EvaluatePage extends StatefulWidget {
  EvaluatePage({Key? key}) : super(key: key);

  @override
  _EvaluatePageState createState() => _EvaluatePageState();
}

class _EvaluatePageState extends State<EvaluatePage> {
  late TextEditingController _textEditingController;
  int _rating = 10;
  List<File> _files = [];
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
      bodyColor: Colors.white,
      title: '评价',
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 52.w),
        children: [
          '请您对本次服务进行评价'.text.color(ktextSubColor).size(28.sp).make(),
          50.w.heightBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          10.w.heightBox,
          GridImagePicker(onChange: (file) {
            _files.addAll(file);
          }),
        ],
      ),
    );
  }
}
