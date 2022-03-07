import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/num_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class TaskRemarkPage extends StatefulWidget {
  const TaskRemarkPage({Key? key}) : super(key: key);

  @override
  _TaskRemarkPageState createState() => _TaskRemarkPageState();
}

class _TaskRemarkPageState extends State<TaskRemarkPage> {
  TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '添加备注',
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              '任务内容'
                  .text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
            ],
          ),
          32.w.heightBox,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.06),
                borderRadius: BorderRadius.circular(16.w)),
            child: TextField(
              controller: _contentController,
              autofocus: false,
              onChanged: (text) => setState(() {}),
              minLines: 5,
              maxLength: 200,
              maxLines: 20,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
      bottomNavi: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
        child: MaterialButton(
          elevation: 0,
          height: 93.w,
          disabledColor: Colors.black.withOpacity(0.06),
          disabledTextColor: Colors.black.withOpacity(0.25),
          textColor: Colors.black.withOpacity(0.85),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(65.w)),
          color: kPrimaryColor,
          onPressed: () async {
            Get.back(result: _contentController.text);
          },
          child: '完成'.text.size(32.sp).bold.make(),
        ),
      ),
    );
  }
}
