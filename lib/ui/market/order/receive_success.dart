import 'package:aku_new_community/pages/tab_navigator.dart';
import 'package:aku_new_community/ui/profile/order/order_page.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ReceiveSuccess extends StatefulWidget {
  final bool integralGood;
  final int? integral;

  const ReceiveSuccess({Key? key, this.integralGood = false, this.integral})
      : super(key: key);

  @override
  _ReceiveSuccessState createState() => _ReceiveSuccessState();
}

class _ReceiveSuccessState extends State<ReceiveSuccess> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '订单结果',
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.w),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE52E2E), Color(0xFFF58123)],
                ),
              ),
              child: Icon(
                CupertinoIcons.check_mark,
                size: 42.w,
                color: Colors.white,
              ),
            ),
            24.w.heightBox,
            '收货成功'.text.size(32.sp).color(Colors.black).make(),
            widget.integral != null
                ? Column(
                    children: [
                      8.w.heightBox,
                      '已获得${widget.integral}积分'
                          .text
                          .size(28.sp)
                          .color(Colors.red)
                          .make(),
                      48.w.heightBox,
                    ],
                  )
                : Column(
                    children: [
                      8.w.heightBox,
                      '本单已享受积分兑换不予返还积分'
                          .text
                          .size(28.sp)
                          .color(Colors.black.withOpacity(0.25))
                          .make(),
                      32.w.heightBox,
                    ],
                  ),
            Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    Get.offAll(() => TabNavigator());
                  },
                  color: Colors.white,
                  minWidth: 168.w,
                  height: 68.w,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34.w),
                    side: BorderSide(color: Colors.red),
                  ),
                  child: '返回首页'.text.size(28.sp).color(Colors.red).make(),
                ),
                24.w.widthBox,
                MaterialButton(
                  onPressed: () {
                    Get.off(() => OrderPage(initIndex: 3));
                  },
                  color: Colors.white,
                  minWidth: 168.w,
                  height: 68.w,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34.w),
                    side: BorderSide(color: Colors.red),
                  ),
                  child: '查看详情'.text.size(28.sp).color(Colors.red).make(),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
