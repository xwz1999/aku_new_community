import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/others/finish_result_image.dart';

class FinishFixedSubmitPage extends StatelessWidget {
  const FinishFixedSubmitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '报事报修',
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            76.w.heightBox,
            FinishResultImage(status: true),
            48.w.heightBox,
            '提交成功'.text.black.size(36.sp).make(),
            16.w.heightBox,
            '您的报修已受理，预计36小时内完成'
                .text
                .size(26.sp)
                .color(ktextSubColor)
                .maxLines(2)
                .make(),
          ],
        ),
      ),
    );
  }
}
