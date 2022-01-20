part of 'sars_api.dart';

class _MarketApi {
  _Collection collection = _Collection();
  _Good good = _Good();
  _Category category = _Category();
  _Home home = _Home();
  _Rotation rotation = _Rotation();
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
  String get recommend => '查询综合推荐商品列表';

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
  String get rotation => '/app/user/rotation/shop/list';
}
