import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/assets_image.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class PayOrderPage extends StatelessWidget {
  final Bundle bundle;
  PayOrderPage({Key key, this.bundle}) : super(key: key);

  var alertStyle = AlertStyle(
    isCloseButton: false,
    isOverlayTapDismiss: false,
    titleStyle:
        TextStyle(fontSize: Screenutil.size(38), color: Color(0xff333333)),
  );

  List<Map<String, dynamic>> _listPay = [
    {
      'title': '支付宝支付',
      'widget': Icon(
        AntDesign.alipay_circle,
        color: Color(0xff06b4fd),
        size: Screenutil.length(50),
      ),
      'id': 'alipay',
      'isCheck': true
    },
    {
      'title': '微信支付',
      'widget': Image.asset(
        AssetsImage.WXPAY,
        height: Screenutil.length(60),
        width: Screenutil.length(60),
      ),
      'id': 'wxpay',
      'isCheck': false
    }
  ];
  Widget FadeAlertAnimation(BuildContext context, Animation<double> animation,
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
            margin: EdgeInsets.only(top: Screenutil.length(40)),
            height: Screenutil.length(200),
            width: Screenutil.length(200),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffffe16b), Color(0xffffc40d)],
              ),
              borderRadius:
                  BorderRadius.all(Radius.circular(Screenutil.length(200))),
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: Screenutil.length(150),
            ),
          ),
          style: alertStyle,
          alertAnimation: FadeAlertAnimation,
          buttons: [
            DialogButton(
              child: Text(
                "确认",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color(0xffffc40d),
              radius: BorderRadius.circular(Screenutil.length(8)),
            ),
          ],
        ).show();
        // Navigator.pushNamed(context, PageName.pay_success_page.toString());
      },
      child: Container(
        padding: EdgeInsets.only(
          bottom: Screenutil.length(27),
          top: Screenutil.length(28),
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
                SizedBox(width: Screenutil.length(24)),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: Screenutil.size(28), color: Color(0xff333333)),
                ),
              ],
            ),
            Icon(
              AntDesign.right,
              color: Color(0xff999999),
              size: Screenutil.length(32),
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
                top: Screenutil.length(130),
                bottom: Screenutil.length(130),
              ),
              alignment: Alignment.center,
              child: Text(
                '¥${(double.parse(bundle.getMap('cartMap')["itemprice"]) * bundle.getMap('cartMap')["count"]).toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Screenutil.size(48),
                  color: Color(0xffe60e0e),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Screenutil.length(32)),
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
