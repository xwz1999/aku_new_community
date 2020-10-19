import "net.dart";
import 'net_url.dart';

class NetUtil {
  /// 测试商品获取
  static void akuShop(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.Shop, params, success: success, failure: failure);
  }

  static void akuShopClass(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.ShopClass, params, success: success, failure: failure);
  }

  static void akuShopJJSH(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.JJSH, params, success: success, failure: failure);
  }

  static void akuShopSMJD(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.SMJD, params, success: success, failure: failure);
  }

  static void akuShopXXFS(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.XXFS, params, success: success, failure: failure);
  }

  static void akuShopZBBJ(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.ZBBJ, params, success: success, failure: failure);
  }

  static void akuShopCZXS(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.CZXS, params, success: success, failure: failure);
  }

  static void akuShopFSXB(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.FSXB, params, success: success, failure: failure);
  }

  static void akuShopMYWJ(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.MYWJ, params, success: success, failure: failure);
  }

  static void akuShopYLJS(Map<String, dynamic> params,
      {Function success, Function failure}) {
    Net().get(NetUrl.YLJS, params, success: success, failure: failure);
  }
}
