import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/provider/cart.dart';

class MarketCartBottomBar extends StatelessWidget {
  const MarketCartBottomBar({Key key}) : super(key: key);

  Widget _selectAll(CartProvidde model) {
    return InkWell(
      onTap: () {
        model.changeALlCheckState(!model.isAllCheck);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Screenutil.length(29)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              model.isAllCheck
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: model.isAllCheck ? Color(0xffdb0000) : Color(0xff999999),
              size: Screenutil.length(40),
            ),
            Container(
              margin: EdgeInsets.only(left: Screenutil.length(18)),
              child: Text(
                '全选',
                style: TextStyle(
                  fontSize: Screenutil.size(28),
                  color: Color(0xff333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settlement(CartProvidde model) {
    return Row(
      children: [
        model.allPrice != 0
            ? Container(
                margin: EdgeInsets.only(right: Screenutil.length(10)),
                child: Text(
                  '合计:￥${model.allPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: Screenutil.size(28),
                    color: Color(0xffe60e0e),
                  ),
                ),
              )
            : SizedBox(),
        InkWell(
          onTap: model.allGoodsCount != 0 ? () {} : null,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: model.allGoodsCount != 0
                  ? Color(0xffffc40c)
                  : Color(0xffd8d8d8),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            width: Screenutil.length(198),
            margin: EdgeInsets.symmetric(vertical: Screenutil.length(16)),
            padding: EdgeInsets.symmetric(vertical: Screenutil.length(12)),
            child: Text(
              '结算(${model.allGoodsCount})',
              style: TextStyle(
                fontSize: Screenutil.size(30),
                color:
                    model.allGoodsCount != 0 ? Color(0xff333333) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvidde>(builder: (context, model, child) {
      return Container(
        color: Colors.white,
        height: Screenutil.length(98),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: Screenutil.length(32)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _selectAll(model),
            _settlement(model),
          ],
        ),
      );
    });
  }
}
