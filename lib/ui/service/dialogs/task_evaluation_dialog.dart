import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class TaskEvaluationDialog extends StatefulWidget {
  const TaskEvaluationDialog({Key? key}) : super(key: key);

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
                  onPressed: () {},
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
              _evaluationIcon(2, '不满意', Assets.icons.dissatisfied.path),
              _evaluationIcon(6, '一般', Assets.icons.normal.path),
              _evaluationIcon(10, '满意', Assets.icons.satisfied.path),
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
          Row(
            children: [
              MaterialButton(
                onPressed: () {},
                minWidth: 330.w,
                height: 80.w,
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.w),
                  side: BorderSide(color: Colors.black.withOpacity(0.25)),
                ),
                child: Text(
                  '',
                  style: TextStyle(
                      fontSize: 28.sp, color: Colors.black.withOpacity(0.65)),
                ),
              ),
              Spacer(),
              MaterialButton(
                onPressed: () {},
                minWidth: 330.w,
                height: 80.w,
                elevation: 0,
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.w),
                ),
                child: Text(
                  '暂不评价',
                  style: TextStyle(
                      fontSize: 28.sp, color: Colors.black.withOpacity(0.85)),
                ),
              )
            ],
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: _currentIndex == index ? 120.w : 80.w,
        height: _currentIndex == index ? 120.w : 80.w,
        child: Column(
          children: [
            Image.asset(iconPath,
                width: double.infinity, height: double.infinity),
            10.hb,
            text.text.size(32.sp).color(Colors.black.withOpacity(0.65)).make(),
          ],
        ),
      ),
    );
  }
}
