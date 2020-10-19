import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/routers/page_routers.dart';

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
        SizedBox(width: Screenutil.length(10)),
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
        Navigator.pushNamed(context, PageName.pay_order_page.toString(),
            arguments: Bundle()..putMap('cartMap', cartMap));
      },
      child: Container(
        decoration: BoxDecoration(
          color: BaseStyle.colorffc40c,
          borderRadius: BorderRadius.all(Radius.circular(33)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Screenutil.length(39),
          vertical: Screenutil.length(12),
        ),
        child: Text(
          '提交订单',
          style: TextStyle(
            fontSize: BaseStyle.fontSize30,
            color: BaseStyle.color333333,
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
      height: Screenutil.length(98),
      padding: EdgeInsets.only(
        top: Screenutil.length(15),
        bottom: Screenutil.length(17),
        right: Screenutil.length(34),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _countPrice(),
          SizedBox(width: Screenutil.length(12)),
          _submit(context),
        ],
      ),
    );
  }
}
