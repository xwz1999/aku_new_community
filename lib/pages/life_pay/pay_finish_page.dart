import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PayFinishPage extends StatelessWidget {
  const PayFinishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenUtil().statusBarHeight + 88.w),
        child: AppBar(
          backgroundColor: Color(0xFF2A2A2A),
          centerTitle: true,
          title: '支付完成'.text.size(32.sp).bold.color(Colors.white).make(),
          leading: BeeBackButton(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Color(0xFF2A2A2A),
      body: Center(
        child: Column(
          children: [
            200.w.heightBox,
            Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.w),
                gradient: LinearGradient(
                    colors: [Color(0xFFFFE16B), Color(0xFFFFC40D)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              alignment: Alignment.center,
              child: Icon(CupertinoIcons.checkmark_alt,size:150.w ,color: Colors.white,),
            ),
            70.w.heightBox,
            '支付成功'.text.size(48.sp).color(Colors.white).bold.make(),
            16.w.heightBox,
            'Payment successful'.text.size(20.sp).color(Colors.white).make(),
          ],
        ),
      ),
    );
  }
}
