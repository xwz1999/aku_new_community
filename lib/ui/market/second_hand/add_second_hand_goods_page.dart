import 'dart:io';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/buttons/bottom_button.dart';
import 'package:aku_community/widget/picker/grid_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class AddSecondGoodsPage extends StatefulWidget {
  AddSecondGoodsPage({Key? key}) : super(key: key);

  @override
  _AddSecondGoodsPageState createState() => _AddSecondGoodsPageState();
}

class _AddSecondGoodsPageState extends State<AddSecondGoodsPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  List<File> _files = [];
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '添加商品',
      // actions: [
      //   Padding(
      //     padding: EdgeInsets.all(32.w),
      //     child: '提交'.text.size(28.sp).color(ktextPrimary).make(),
      //   ),
      // ],
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.w)),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 26.w, horizontal: 32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFEEEEEE),
                                width: 2.w,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(bottom: 10.w),
                            isDense: true,
                            hintText: '请输入标题',
                            hintStyle: TextStyle(
                              color: ktextSubColor,
                              fontSize: 36.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.w.heightBox,
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      hintText: '请输入描述信息，至少五个字',
                      hintStyle: TextStyle(
                        color: ktextSubColor,
                        fontSize: 28.sp,
                      ),
                    ),
                    minLines: 5,
                    maxLines: 10,
                  ),
                  GridImagePicker(onChange: (files) {
                    _files = files;
                  }),
                ],
              ),
            ),
          ]),
      bottomNavi: BottomButton(
        onPressed: () {},
        child: '立即提交'.text.size(32.sp).color(ktextPrimary).bold.make(),
      ),
    );
  }
}
