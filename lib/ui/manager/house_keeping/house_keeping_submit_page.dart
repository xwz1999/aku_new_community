import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/finish_result_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class HouseKeepingSubmitPage extends StatefulWidget {
  HouseKeepingSubmitPage({Key? key}) : super(key: key);

  @override
  _HouseKeepingSubmitPageState createState() => _HouseKeepingSubmitPageState();
}

class _HouseKeepingSubmitPageState extends State<HouseKeepingSubmitPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '家政服务',
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            76.w.heightBox,
            FinishResultImage(status: true),
            48.w.heightBox,
            '提交成功'.text.black.size(36.sp).make(),
            16.w.heightBox,
            '您的家政服务已受理，预计36小时内完成'
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
