part of 'saas_api.dart';

class _MarketApi {
  _Collection collection = _Collection();
  _Good good = _Good();
  _Category category = _Category();
  _Home home = _Home();
  _Rotation rotation = _Rotation();
  _ShopCart shopCart = _ShopCart();
  _Address address = _Address();
  _Order order = _Order();
}

class _ShopCart {
  ///加入购物车
  String get insert => '/app/user/shop/cart/insertShoppingCart';

  ///我的购物车
  String get myCart => '/app/user/shop/cart/myShoppingCart';

  ///更改购物车商品数量
  String get updateNum => '/app/user/shop/cart/updateShoppingCartNum';

  ///删除购物车商品
  String get delete => '/app/user/shop/cart/deleteShoppingCart';

  ///购物车结算
  String get settlement => '/app/user/shop/cart/settlement';
}

class _Address {
  ///添加收货地址
  String get insert => '/app/user/shop/address/insert';

  ///修改收货地址
  String get update => '/app/user/shop/address/update';

  ///我的收货地址
  String get myAddress => '/app/user/shop/address/myAddress';

  ///删除收货地址
  String get delete => '/app/user/shop/address/delete';

  ///设置默认收货地址
  String get setDefault => '/app/user/shop/address/settingDefaultAddress';
}

class _Collection {
  ///我的收藏夹
  String get myCollection => '/app/user/shop/collection/myCollection';

  ///添加/取消 收藏
  String get changeCollection => '/app/user/shop/collection/isCollection';
}

class _Good {
  ///查询最大人气值的几个(热搜及爆品推荐【爆品推荐后期用购买量来判断】)
  String get popular => '/app/user/shop/goods/findMaxPopularity';

  ///查询所有的品牌
  String get brand => '/app/user/shop/brand/list';

  ///查询综合推荐商品列表
  String get recommend => '/app/user/shop/goods/findRecommendGoodsList';

  ///查询商品详情
  String get goodDetail => '/app/user/shop/goods/findGoodsDetail';
}

class _Category {
  ///app商城根据父类主键id查询商品分类
  String get category => '/app/user/shop/category/findCategory';

  ///查询所有的可显示的分类信息
  String get categoryInfo => '/app/user/shop/category/findAllCategoryInfo';
}

class _Home {
  ///查询app商城首页顶部信息(sku总数，入驻品牌数，今日上新产品件数)
  String get topInfo => '/app/user/shop/frontPage/topInfo';
}

class _Rotation {
  ///查询app商城首页轮播图
  String get rotation => '/app/user/shop/rotation/list';
}

class _Order {
  ///查询订单物流
  String get findLogistics => '/app/user/shop/order/findLogistics';

  ///app确认收货
  String get confirm => '/app/user/shop/order/confirm';

  ///app删除订单
  String get delete => '/app/user/shop/order/appDelete';

  ///app取消订单
  String get cancel => '/app/user/shop/order/cancel';

  ///我的订单
  String get myOrder => '/app/user/shop/order/myOrder';
}
