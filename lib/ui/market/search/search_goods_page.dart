import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:waterfall_flow/waterfall_flow.dart';

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/ui/market/goods/goods_card.dart';
import 'package:aku_community/utils/headers.dart';
import 'package:aku_community/widget/bee_scaffold.dart';

enum OrderType {
  NORMAL,
  SALES,
  PRICE_HIGH,
  PRICE_LOW,
}

class SearchGoodsPage extends StatefulWidget {
  SearchGoodsPage({Key? key}) : super(key: key);

  @override
  SearchGoodsPageState createState() => SearchGoodsPageState();
}

class SearchGoodsPageState extends State<SearchGoodsPage> {
  TextEditingController _editingController = TextEditingController();
  OrderType _orderType = OrderType.NORMAL;
  IconData priceIcon = CupertinoIcons.chevron_up_chevron_down;
  @override
  Widget build(BuildContext context) {
    final normalTypeButton = MaterialButton(
      onPressed: () {
        _orderType = OrderType.NORMAL;
        priceIcon = CupertinoIcons.chevron_up_chevron_down;
        setState(() {});
      },
      child: Text(
        '综合',
        style: TextStyle(
          color:
              _orderType == OrderType.NORMAL ? kDarkPrimaryColor : ktextPrimary,
        ),
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    final salesTypeButton = MaterialButton(
      onPressed: () {
        _orderType = OrderType.SALES;
        priceIcon = CupertinoIcons.chevron_up_chevron_down;
        setState(() {});
      },
      child: Text(
        '销量',
        style: TextStyle(
          color:
              _orderType == OrderType.SALES ? kDarkPrimaryColor : ktextPrimary,
        ),
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final priceButton = MaterialButton(
      onPressed: () {
        switch (_orderType) {
          case OrderType.NORMAL:
          case OrderType.SALES:
            _orderType = OrderType.PRICE_HIGH;
            priceIcon = CupertinoIcons.chevron_up;
            break;
          case OrderType.PRICE_HIGH:
            _orderType = OrderType.PRICE_LOW;
            priceIcon = CupertinoIcons.chevron_down;
            break;
          case OrderType.PRICE_LOW:
            _orderType = OrderType.PRICE_HIGH;
            priceIcon = CupertinoIcons.chevron_up;
            break;
        }
        setState(() {});
      },
      child: Row(
        children: [
          Text(
            '价格',
            style: TextStyle(
              color: _orderType == OrderType.PRICE_HIGH ||
                      _orderType == OrderType.PRICE_LOW
                  ? kDarkPrimaryColor
                  : ktextPrimary,
            ),
          ),
          Icon(
            priceIcon,
            size: 32.w,
            color: _orderType == OrderType.PRICE_HIGH ||
                    _orderType == OrderType.PRICE_LOW
                ? kDarkPrimaryColor
                : ktextPrimary,
          ),
        ],
      ),
      height: 80.w,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    return BeeScaffold(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.w),
        child: TextField(
          controller: _editingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            filled: true,
            fillColor: Color(0xFFF3F3F3),
            isDense: true,
            prefixIcon: Icon(CupertinoIcons.search),
          ),
        ),
      ),
      //TODO 列表排序
      // appBarBottom: PreferredSize(
      //   child: Row(
      //     children: [
      //       normalTypeButton,
      //       salesTypeButton,
      //       priceButton,
      //     ],
      //   ),
      //   preferredSize: Size.fromHeight(80.w),
      // ),
      body: WaterfallFlow.builder(
        padding: EdgeInsets.all(32.w),
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.w,
          crossAxisSpacing: 20.w,
        ),
        itemBuilder: (context, index) {
          return GoodsCard();
        },
        itemCount: 10,
      ),
    );
  }
}
