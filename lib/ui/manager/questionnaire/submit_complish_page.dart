import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SubmitComplishPage extends StatelessWidget {
  final bool status;
  final String message;
  const SubmitComplishPage({Key key, this.status, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '提交结果',
      body: Center(
        child: Column(
          children: [
            76.w.heightBox,
            Container(
              alignment: Alignment.center,
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55.w),
                color: this.status ? kPrimaryColor : kDangerColor,
              ),
              child: Icon(
                this.status ? CupertinoIcons.checkmark : CupertinoIcons.multiply,
                size: 100.w,
              ),
            ),
            48.w.heightBox,
            (this.status ? '提交成功' : '提交失败').text.size(36.sp).black.bold.make(),
            16.w.heightBox,
            (this.status ? '您的建议我们已经收到，感谢填写' : this.message)
                .text
                .color(ktextSubColor)
                .size(26.sp)
                .make(),
            96.w.heightBox,
            MaterialButton(
              elevation: 0,
              minWidth: 702.w,
              height: 98.w,
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.w)),
              onPressed: () {
                Get.back();
              },
              child: (this.status ? '返回' : '重新提交')
                  .text
                  .color(ktextPrimary)
                  .size(36.sp)
                  .make(),
            ),
          ],
        ),
      ),
    );
  }
}
