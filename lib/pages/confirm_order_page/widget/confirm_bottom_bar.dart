import 'package:akuCommunity/pages/confirm_order_page/pay_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:get/get.dart';

class ConfirmBottomBar extends StatelessWidget {
  final Map cartMap;
  ConfirmBottomBar({Key key, this.cartMap}) : super(key: key);

  Widget _countPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '共计${cartMap["count"]}件',
          style: TextStyle(
            color: BaseStyle.color999999,
            fontSize: BaseStyle.fontSize24,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          '合计:￥${(double.parse(cartMap["itemprice"]) * cartMap["count"]).toStringAsFixed(2)}',
          style: TextStyle(
            color: Color(0xffe60e0e),
            fontSize: BaseStyle.fontSize28,
          ),
        )
      ],
    );
  }

  Widget _submit(BuildContext context) {
    return InkWell(
      onTap: () {
        PayOrderPage().to();
      },
      child: Container(
        decoration: BoxDecoration(
          color: BaseStyle.colorffc40c,
          borderRadius: BorderRadius.all(Radius.circular(33)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 39.w,
          vertical: 12.w,
        ),
        child: Text(
          '提交订单',
          style: TextStyle(
            fontSize: BaseStyle.fontSize30,
            color: ktextPrimary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 98.w,
      padding: EdgeInsets.only(
        top: 15.w,
        bottom: 17.w,
        right: 34.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _countPrice(),
          SizedBox(width: 12.w),
          _submit(context),
        ],
      ),
    );
  }
}
