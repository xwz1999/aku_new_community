import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class PayOrderPage extends StatelessWidget {
  final Bundle bundle;
  PayOrderPage({Key key, this.bundle}) : super(key: key);

  final alertStyle = AlertStyle(
    isCloseButton: false,
    isOverlayTapDismiss: false,
    titleStyle: TextStyle(fontSize: 38.sp, color: Color(0xff333333)),
  );

  final List<Map<String, dynamic>> _listPay = [
    {
      'title': '支付宝支付',
      'widget': Icon(
        AntDesign.alipay_circle,
        color: Color(0xff06b4fd),
        size: 50.w,
      ),
      'id': 'alipay',
      'isCheck': true
    },
    {
      'title': '微信支付',
      'widget': Image.asset(
        AssetsImage.WXPAY,
        height: 60.w,
        width: 60.w,
      ),
      'id': 'wxpay',
      'isCheck': false
    }
  ];
  Widget fadeAlertAnimation(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  InkWell _payMode(BuildContext context, Widget widget, String title) {
    return InkWell(
      onTap: () {
        Alert(
          context: context,
          title: "支付成功!~",
          image: Container(
            margin: EdgeInsets.only(top: 40.w),
            height: 200.w,
            width: 200.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffffe16b), Color(0xffffc40d)],
              ),
              borderRadius: BorderRadius.all(Radius.circular(200.w)),
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 150.w,
            ),
          ),
          style: alertStyle,
          alertAnimation: fadeAlertAnimation,
          buttons: [
            DialogButton(
              child: Text(
                "确认",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Get.back(),
              color: Color(0xffffc40d),
              radius: BorderRadius.circular(8.w),
            ),
          ],
        ).show();
      },
      child: Container(
        padding: EdgeInsets.only(
          bottom: 27.w,
          top: 28.w,
        ),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xffd8d8d8), width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget,
                SizedBox(width: 24.w),
                Text(
                  title,
                  style: TextStyle(fontSize: 28.sp, color: Color(0xff333333)),
                ),
              ],
            ),
            Icon(
              AntDesign.right,
              color: Color(0xff999999),
              size: 32.w,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(title: '付款方式'),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 130.w,
                bottom: 130.w,
              ),
              alignment: Alignment.center,
              child: Text(
                '¥${(double.parse(bundle.getMap('cartMap')["itemprice"]) * bundle.getMap('cartMap')["count"]).toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 48.sp,
                  color: Color(0xffe60e0e),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: List.generate(
                    _listPay.length,
                    (index) => _payMode(
                          context,
                          _listPay[index]['widget'],
                          _listPay[index]['title'],
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
