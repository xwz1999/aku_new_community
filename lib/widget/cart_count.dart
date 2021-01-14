import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:akuCommunity/provider/cart.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/model/aku_shop_model.dart';

class CartCount extends StatelessWidget {
  final AkuShopModel cartItem;
  CartCount({Key key, this.cartItem}) : super(key: key);

  //减按钮
  Widget _reduceBtn(CartProvidde model) {
    return InkWell(
      onTap: cartItem.count > 1
          ? () {
              model.addOrReduceAction(cartItem, 'reduce');
            }
          : null,
      child: Container(
        width: 52.w,
        height: 52.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: cartItem.count > 1 ? Color(0xffffffff) : Colors.black12,
            border:
                Border(right: BorderSide(width: 0.5, color: Colors.black12))),
        child: Icon(
          Icons.remove,
          color: Color(0xff979797),
          size: 38.sp,
        ),
      ),
    );
  }

  //加按钮
  Widget _addBtn(CartProvidde model) {
    return InkWell(
      onTap: () {
        model.addOrReduceAction(cartItem, 'add');
      },
      child: Container(
        width: 52.w,
        height: 52.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Icon(
          Icons.add,
          color: Color(0xff979797),
          size: 38.sp,
        ),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      width: 52.w,
      height: 52.w,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '${cartItem.count}',
        style: TextStyle(
          fontSize: 24.sp,
          color: Color(0xff333333),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      decoration: BoxDecoration(
          border:
              Border.all(width: 0.5, color: Colors.black12) //设置所有的边框宽度为1 颜色为浅灰
          ),
      child: Consumer<CartProvidde>(builder: (context, model, child) {
        return Row(
          children: <Widget>[_reduceBtn(model), _countArea(), _addBtn(model)],
        );
      }),
    );
  }
}
