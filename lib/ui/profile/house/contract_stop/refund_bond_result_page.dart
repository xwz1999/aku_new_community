import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/others/finish_result_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class RefundBondResultPage extends StatefulWidget {
  final int status;
  RefundBondResultPage({Key? key, required this.status}) : super(key: key);

  @override
  _RefundBondResultPageState createState() => _RefundBondResultPageState();
}

class _RefundBondResultPageState extends State<RefundBondResultPage> {
  String get statusString {
    switch (widget.status) {
      case 15:
        return '申请退还保证金审核中';
      case 16:
        return '申请退还保证金驳回';
      case 17:
        return '申请保证金退还成功';

      default:
        return '未知';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '保证金退还情况',
      body: Center(
        child: Column(
          children: [
            276.w.heightBox,
            FinishResultImage(
              status: widget.status == 16 ? false : true,
              haveInHandStatus: widget.status == 15 ? true : false,
            ),
            48.w.heightBox,
            statusString.text.black.size(36.sp).make(),
            96.w.heightBox,
          ],
        ),
      ),
    );
  }
}
