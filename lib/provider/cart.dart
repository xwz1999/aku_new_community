import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:akuCommunity/model/aku_shop_model.dart';

class CartProvidde with ChangeNotifier {
  String cartString;
  List<AkuShopModel> cartList = [];

  double allPrice = 0;
  int allGoodsCount = 0;
  bool isAllCheck = true;

  save(itemid, itemtitle, count, itemprice, itempic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartString");
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isSave = false;
    int ival = 0;
    tempList.forEach((item) {
      if (item["itemid"] == itemid) {
        tempList[ival]["count"] = item["count"] + 1;
        cartList[ival].count++;
        isSave = true;
      }
      ival++;
    });
    if (!isSave) {
      Map<String, dynamic> newGoods = {
        "itemid": itemid,
        "itemtitle": itemtitle,
        "count": count,
        "itemprice": itemprice,
        "itempic": itempic,
        "isCheck": false
      };
      tempList.add(newGoods);
      cartList.add(AkuShopModel.fromJson(newGoods));
    }
    cartString = json.encode(tempList).toString();
    print(cartString);
    print(cartList);
    prefs.setString("cartInfo", cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    cartList = [];
    print('清空购物车');
    notifyListeners();
  }

  ///获取商品列表
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    // cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

      ///总价格和总数量初始化
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if (item["isCheck"]) {
          allPrice += (item["count"] * (double.parse(item["itemprice"])));
          allGoodsCount++;
        } else {
          isAllCheck = false;
        }
        cartList.add(AkuShopModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  ///删除单个购物车商品
  deleteGoods(String itemid) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // cartString = prefs.getString("cartInfo");
    // List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    // int tempIndex = 0;
    // int deleteIndex = 0;
    // tempList.forEach((item) {
    //   if (item["itemid"] == itemid) {
    //     deleteIndex = tempIndex;
    //   }
    //   tempIndex++;
    // });
    // tempList.removeAt(deleteIndex);
    // cartString = json.encode(tempList).toString();
    // prefs.setString("cartInfo", cartString);
    // await getCartInfo();

    cartList.removeWhere((element) => element.itemid == itemid);
    notifyListeners();
  }

  ///单选商品
  changeCheckState(AkuShopModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item["itemid"] == cartItem.itemid) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString("cartInfo", cartString);
    await getCartInfo();
  }

  ///全选商品
  changeALlCheckState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    tempList.forEach((item) {
      var newItem = item;
      newItem["isCheck"] = isCheck;
      newList.add(newItem);
    });
    cartString = json.encode(newList).toString();
    prefs.setString("cartInfo", cartString);
    await getCartInfo();
  }

  ///商品数量加减
  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item["itemid"] == cartItem.itemid) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString("cartInfo", cartString);
    await getCartInfo();
  }
}
