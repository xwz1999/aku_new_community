// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:akuCommunity/provider/cart.dart';
import 'package:akuCommunity/utils/headers.dart';

class MarketCartBottomBar extends StatelessWidget {
  const MarketCartBottomBar({Key key}) : super(key: key);

  Widget _selectAll(CartProvidde model) {
    return InkWell(
      onTap: () {
        model.changeALlCheckState(!model.isAllCheck);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 29.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              model.isAllCheck
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: model.isAllCheck ? Color(0xffdb0000) : Color(0xff999999),
              size: 40.w,
            ),
            Container(
              margin: EdgeInsets.only(left: 18.w),
              child: Text(
                '全选',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xff333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settlement(CartProvidde model, BuildContext context) {
    return Row(
      children: [
        model.allPrice != 0
            ? Container(
                margin: EdgeInsets.only(right: 10.w),
                child: Text(
                  '合计:￥${model.allPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 28.sp,
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
            width: 198.w,
            margin: EdgeInsets.symmetric(vertical: 16.w),
            padding: EdgeInsets.symmetric(vertical: 12.w),
            child: Text(
              '结算(${model.allGoodsCount})',
              style: TextStyle(
                fontSize: 30.sp,
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
        height: 98.w,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _selectAll(model),
            _settlement(
              model,
              context,
            )
          ],
        ),
      );
    });
  }
}
