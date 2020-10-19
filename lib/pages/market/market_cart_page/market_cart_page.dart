import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:akuCommunity/provider/cart.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/model/aku_shop_model.dart';
import 'widget/market_cart_app_bar.dart';
import 'widget/market_cart_card.dart';
import 'widget/market_cart_bottom_bar.dart';

class MarketCartPage extends StatelessWidget {
  MarketCartPage({Key key}) : super(key: key);
// List<Map<String, dynamic>> _listGoods = [
//     {
//       'imagePath':
//           'http://img.alicdn.com/imgextra/i3/2113905378/O1CN01aH72RP1pbAf1n1amP_!!2113905378.jpg',
//       'content': '2020很仙的开衫女春秋装韩版宽松加厚百搭外搭毛衣外套针织衫',
//       'specs': '165/M',
//       'price': 69.9,
//       'goodsNum': 1,
//       'isCheck': false
//     },
//     {
//       'imagePath':
//           'http://img.alicdn.com/imgextra/i3/2261315282/O1CN01FLPB6E1otCdaEw4OC_!!2261315282.jpg',
//       'content': '微商爆款女士MCKZ阳离子秋冬柔软舒适打底衫高领针织螺纹棉上衣',
//       'specs': '165/M',
//       'price': 129.9,
//       'goodsNum': 1,
//       'isCheck': false
//     },
//   ];

  // bool isAll = false;
  // double _currentPrice = 0;
  // int _currentGoodsNum = 0;

  // void funAll() {
  //   setState(() {
  //     isAll = !isAll;
  //     if (isAll) {
  //       _currentPrice = 0;
  //       _currentGoodsNum = 0;
  //     }
  //     _listGoods.forEach((item) {
  //       item["isCheck"] = isAll;
  //       if (item["isCheck"]) {
  //         _currentPrice += item["price"] * item["goodsNum"];
  //         _currentGoodsNum++;
  //       } else {
  //         _currentPrice -= item["price"] * item["goodsNum"];
  //         _currentGoodsNum--;
  //       }
  //     });
  //   });
  // }

  // void funIsSelect(int index) {
  //   setState(() {
  //     _listGoods[index]["isCheck"] = !_listGoods[index]["isCheck"];
  //     if (_listGoods[index]["isCheck"]) {
  //       _currentPrice +=
  //           _listGoods[index]["price"] * _listGoods[index]["goodsNum"];
  //       _currentGoodsNum++;
  //     } else {
  //       _currentPrice -=
  //           _listGoods[index]["price"] * _listGoods[index]["goodsNum"];
  //       _currentGoodsNum--;
  //     }
  //     if (_listGoods.every((item) => item["isCheck"])) {
  //       isAll = true;
  //     } else {
  //       isAll = false;
  //     }
  //   });
  // }

  // void reduce(int index) {
  //   setState(() {
  //     _listGoods[index]["goodsNum"]--;
  //     if (_currentPrice != 0) {
  //       _currentPrice = 0;
  //       _listGoods.forEach((item) {
  //         if (item["isCheck"]) {
  //           _currentPrice += item["price"] * item["goodsNum"];
  //         }
  //       });
  //     }
  //   });
  // }

  // void add(int index) {
  //   setState(() {
  //     _listGoods[index]["goodsNum"]++;
  //     if (_currentPrice != 0) {
  //       _currentPrice = 0;
  //       _listGoods.forEach((item) {
  //         if (item["isCheck"]) {
  //           _currentPrice += item["price"] * item["goodsNum"];
  //         }
  //       });
  //     }
  //   });
  // }

  // void funSubimt() {
  //   // setState(() {
  //   //   isAll = !isAll;
  //   // });
  // }
  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvidde>(context, listen: false).getCartInfo();
    return 'end';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: MarketCartAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // List cartList = Provider.of<CartProvidde>(context).cartList;
            return Stack(
              children: [
                Consumer<CartProvidde>(
                  builder: (context, model, child) {
                    List cartList = model.cartList;
                    return ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MarketCartCard(
                            cartItem: cartList[index],
                          );
                        });
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: MarketCartBottomBar(),
                ),
              ],
            );
          } else {
            return Text('正在加载中');
          }
        },
      ),
    );
  }
}
