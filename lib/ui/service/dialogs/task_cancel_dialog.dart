import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/ui/service/task_func.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class TaskCancelDialog extends StatefulWidget {
  final int taskId;

  const TaskCancelDialog({Key? key, required this.taskId}) : super(key: key);

  @override
  _TaskCancelDialogState createState() => _TaskCancelDialogState();
}

class _TaskCancelDialogState extends State<TaskCancelDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.icons.cancelTask.image(
            width: double.infinity,
            height: 420.w,
          ),
          64.hb,
          '确定要取消任务吗?'.text.size(36.sp).black.bold.make(),
          24.hb,
          '不再等等吗？马上就会有人来接单了！'
              .text
              .size(28.sp)
              .color(Colors.black.withOpacity(0.45))
              .make(),
          80.hb,
          Row(
            children: [
              MaterialButton(
                onPressed: () {
                  Get.back();
                },
                minWidth: 330.w,
                height: 80.w,
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.w),
                  side: BorderSide(color: Colors.black.withOpacity(0.25)),
                ),
                child: Text(
                  '继续等待',
                  style: TextStyle(
                      fontSize: 28.sp, color: Colors.black.withOpacity(0.65)),
                ),
              ),
              Spacer(),
              MaterialButton(
                onPressed: () async {
                  var re = await TaskFunc.cancel(taskId: widget.taskId);
                  if (re) {
                    Get.back();
                  }
                },
                minWidth: 330.w,
                height: 80.w,
                elevation: 0,
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.w),
                ),
                child: Text(
                  '确认取消',
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
}
