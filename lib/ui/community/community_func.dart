import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/model/community/activity_item_model.dart';
import 'package:aku_new_community/model/community/board_model.dart';
import 'package:aku_new_community/model/community/community_topic_model.dart';
import 'package:aku_new_community/model/community/hot_news_model.dart';
import 'package:aku_new_community/model/community/my_event_item_model.dart';
import 'package:aku_new_community/model/community/swiper_model.dart';
import 'package:aku_new_community/model/good/category_model.dart';
import 'package:aku_new_community/model/good/market_swiper_model.dart';
import 'package:aku_new_community/models/market/goods_classification.dart';
import 'package:aku_new_community/models/market/goods_popular_model.dart';
import 'package:aku_new_community/models/market/market_statistics_model.dart';
import 'package:aku_new_community/models/market/order/goods_home_model.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:bot_toast/bot_toast.dart';

class CommunityFunc {
  ///查询热门话题
  static Future<List<CommunityTopicModel>> getListGambit() async {
    BaseListModel model = await NetUtil().getList(
      API.community.listGambit,
      params: {'pageNum': 1, 'size': 8},
    );
    if (model.tableList!.length == 0) return [];
    return model.tableList!
        .map((e) => CommunityTopicModel.fromJson(e))
        .toList();
  }

  ///我的动态
  static Future<List<MyEventItemModel>> getMyEventItem() async {
    BaseListModel model = await NetUtil().getList(
      API.community.myEvent,
      params: {'pageNum': 1, 'size': 8},
    );
    if (model.tableList!.length == 0) return [];
    return model.tableList!.map((e) => MyEventItemModel.fromJson(e)).toList();
  }

  ///查询热门资讯
  static Future<List<HotNewsModel>> getHotNews() async {
    BaseListModel model = await NetUtil().getList(
      API.community.findHotNews,
      params: {'pageNum': 1, 'size': 4},
    );
    if (model.tableList!.length == 0) return [];
    return model.tableList!.map((e) => HotNewsModel.fromJson(e)).toList();
  }

  ///给单个资讯增加浏览量
  static Future<String> addViews(int newsId) async {
    BaseModel model = await NetUtil().get(
      API.community.addViews,
      params: {
        'newsId': newsId,
      },
    );
    if (model.success) return '';
    return model.msg;
  }

  ///查询顶部统计信息
  static Future<MarketStatisticsModel?> getMarketStatistics() async {
    BaseModel model = await NetUtil().get(
      SARSAPI.market.home.topInfo,
    );
    if (model.success) {
      return MarketStatisticsModel.fromJson(model.data);
    } else {
      BotToast.showText(text: model.msg);
      return null;
    }
  }

  ///获取商品分类
  static Future<List<GoodsClassification>> getGoodsClassificationList(
      int parentId) async {
    BaseListModel model = await NetUtil().getList(
      API.market.findAllCategoryByParentId,
      params: {'pageNum': 1, 'size': 9, 'parentId': parentId},
    );
    if (model.tableList!.length == 0) return [];
    return model.tableList!
        .map((e) => GoodsClassification.fromJson(e))
        .toList();
  }

  ///商场首页的商品列表
  static Future<List<GoodsHomeModel>> getGoodsHomeModelList(
    int PageNum,
    int size,
    int orderBySalesVolume,
    int orderByPrice,
  ) async {
    BaseListModel model = await NetUtil().getList(
      API.market.findRecommendGoodsList,
      params: {
        'pageNum': PageNum,
        'size': size,
        'orderBySalesVolume': orderBySalesVolume,
        'orderByPrice': orderByPrice,
      },
    );
    if (model.tableList!.length == 0) return [];
    return model.tableList!.map((e) => GoodsHomeModel.fromJson(e)).toList();
  }

  ///查询爆款推荐
  static Future<List<GoodsPopularModel>> getGoodsPopularModel(int num) async {
    BaseModel model = await NetUtil().get(
      API.market.findMaxPopularity,
      params: {'num': num},
    );
    if (model.data!.length == 0) return [];
    return (model.data as List)
        .map((e) => GoodsPopularModel.fromJson(e))
        .toList();
  }

  ///获取所有商品的分类
  static Future<List<CategoryModel>> getCategory() async {
    BaseModel model = await NetUtil().get(
      API.market.findAllCategoryInfo,
    );
    if (model.data!.length == 0)
      return [];
    else {
      return (model.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    }
  }

  ///获取商城的轮播图
  static Future<List<MarketSwiperModel>> marketSwiper() async {
    BaseModel model = await NetUtil().get(
      SARSAPI.market.rotation.rotation,
    );
    if (model.data!.length == 0) return [];
    return (model.data as List)
        .map((e) => MarketSwiperModel.fromJson(e))
        .toList();
  }

  static Future<ActivityItemModel?> activity() async {
    BaseListModel model = await NetUtil().getList(
      API.community.activityList,
      params: {'pageNum': 1, 'size': 5},
    );
    if (model.tableList!.length == 0) return null;
    return ActivityItemModel.fromJson(model.tableList!.first);
  }

  static Future<List<ActivityItemModel>> activityList() async {
    BaseListModel model = await NetUtil().getList(
      API.community.activityList,
      params: {'pageNum': 1, 'size': 5},
    );
    if (model.tableList!.length == 0) return [];
    return model.tableList!.map((e) => ActivityItemModel.fromJson(e)).toList();
  }

  static Future<List<BoardItemModel>> board() async {
    BaseListModel model = await NetUtil().getList(
      API.community.boardList,
      params: {'pageNum': 1, 'size': 5},
    );
    if (model.tableList!.length == 0) return [];
    return model.tableList!.map((e) => BoardItemModel.fromJson(e)).toList();
  }

  static Future<List<SwiperModel>> swiper() async {
    BaseModel model = await NetUtil().get(
      API.community.getSwiper,
    );
    if (model.data!.length == 0) return [];
    return (model.data as List).map((e) => SwiperModel.fromJson(e)).toList();
  }
}
