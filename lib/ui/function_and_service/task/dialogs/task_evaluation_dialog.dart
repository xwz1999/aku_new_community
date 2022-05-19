import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';

class TaskEvaluationDialog extends StatefulWidget {
  final Future<bool> Function(int star, String content) evaluate;

  const TaskEvaluationDialog({Key? key, required this.evaluate})
      : super(key: key);

  @override
  _TaskEvaluationDialogState createState() => _TaskEvaluationDialogState();
}

class _TaskEvaluationDialogState extends State<TaskEvaluationDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(32.w),
      child: Column(
        children: [
          Row(
            children: [
              '请对服务质量进行评价'
                  .text
                  .color(Colors.black.withOpacity(0.25))
                  .size(32.sp)
                  .make(),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    CupertinoIcons.xmark,
                    size: 24.w,
                    color: Colors.black.withOpacity(0.45),
                  )),
            ],
          ),
          40.hb,
          Row(
            children: [
              32.wb,
              _evaluationIcon(
                  2,
                  '不满意',
                  _currentIndex == 2
                      ? Assets.newIcon.unsatisfied.path
                      : Assets.newIcon.unsatisfiedUnselect.path),
              Spacer(),
              _evaluationIcon(
                  6,
                  '一般',
                  _currentIndex == 6
                      ? Assets.newIcon.normal.path
                      : Assets.newIcon.normalUnselect.path),
              Spacer(),
              _evaluationIcon(
                  10,
                  '满意',
                  _currentIndex == 10
                      ? Assets.newIcon.satisfied.path
                      : Assets.newIcon.satisfiedUnselect.path),
              32.wb,
            ],
          ),
          56.hb,
          Container(
            width: 622.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                color: Colors.black.withOpacity(0.03)),
            child: TextField(
              maxLines: 10,
              minLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          80.hb,
          BottomPluralButtonWidget(
            leftTitle: '暂不评价',
            onLeftTap: () {
              Get.back();
            },
            rightTitle: '确认提交',
            onRightTap: () async {
              if (_currentIndex == null) {
                BotToast.showText(text: '请选择评价满意度');
                return;
              }
              var re = await widget.evaluate(_currentIndex!, _controller.text);
              if (re) {
                Get.back();
              }
            },
          )
        ],
      ),
    );
  }

  int? _currentIndex;

  Widget _evaluationIcon(
    int index,
    String text,
    String iconPath,
  ) {
    return GestureDetector(
      onTap: () {
        _currentIndex = index;
        setState(() {});
      },
      child: Column(
        children: [
          Image.asset(iconPath,width: 120.w,height: 120.w,),
          10.hb,
          text.text
              .size(32.sp)
              .color(Colors.black.withOpacity(0.65))
              .make(),
        ],
      ),
    );
  }
}

class BottomPluralButtonWidget extends StatelessWidget {
  const BottomPluralButtonWidget({
    Key? key,
    required this.onLeftTap,
    required this.onRightTap,
    required this.leftTitle,
    required this.rightTitle,
    this.padding = false,
  }) : super(key: key);
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;
  final String leftTitle;
  final String rightTitle;
  final bool padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding
          ? EdgeInsets.only(
              left: 32.w,
              top: 32.w,
              bottom: 32.w + MediaQuery.of(context).padding.bottom,
              right: 32.w)
          : EdgeInsets.zero,
      color: padding ? Colors.white : Colors.transparent,
      child: Row(
        children: [
          MaterialButton(
            onPressed: onLeftTap,
            minWidth: 330.w,
            height: 80.w,
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.w),
              side: BorderSide(color: Colors.black.withOpacity(0.25)),
            ),
            child: Text(
              leftTitle,
              style: TextStyle(
                  fontSize: 28.sp, color: Colors.black.withOpacity(0.65)),
            ),
          ),
          Spacer(),
          MaterialButton(
            onPressed: onRightTap,
            minWidth: 330.w,
            height: 80.w,
            elevation: 0,
            color: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.w),
            ),
            child: Text(
              rightTitle,
              style: TextStyle(
                  fontSize: 28.sp, color: Colors.black.withOpacity(0.85)),
            ),
          )
        ],
      ),
    );
  }
}
