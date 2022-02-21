import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/model/community/activity_item_model.dart';
import 'package:aku_new_community/model/community/board_model.dart';
import 'package:aku_new_community/model/community/hot_news_model.dart';
import 'package:aku_new_community/model/community/swiper_model.dart';
import 'package:aku_new_community/model/good/market_swiper_model.dart';
import 'package:aku_new_community/models/community/dynamic_my_list_body.dart';
import 'package:aku_new_community/models/community/topic_model.dart';
import 'package:aku_new_community/models/market/goods_popular_model.dart';
import 'package:aku_new_community/models/market/market_all_category_model.dart';
import 'package:aku_new_community/models/market/market_category_model.dart';
import 'package:aku_new_community/models/market/market_statistics_model.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:bot_toast/bot_toast.dart';

class CommunityFunc {
  ///查询热门话题
  static Future<List<TopicModel>> getListGambit() async {
    var model = await NetUtil().get(
      SARSAPI.community.topNewList,
      params: {'hotShowNum': 3, 'showNum': 3},
    );
    if ((model.data as List).length == 0) return [];
    return (model.data as List).map((e) => TopicModel.fromJson(e)).toList();
  }

  ///我的动态
  static Future<List<DynamicMyListBody>> getMyEventItem() async {
    BaseListModel model = await NetUtil().getList(
      SARSAPI.community.dynamicMyListL,
      params: {'pageNum': 1, 'size': 8},
    );
    if (model.rows.length == 0) return [];
    return model.rows.map((e) => DynamicMyListBody.fromJson(e)).toList();
  }

  ///查询热门资讯
  static Future<List<HotNewsModel>> getHotNews() async {
    BaseListModel model = await NetUtil().getList(
      API.community.findHotNews,
      params: {'pageNum': 1, 'size': 4},
    );
    if (model.rows.length == 0) return [];
    return model.rows.map((e) => HotNewsModel.fromJson(e)).toList();
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
  static Future<List<MarketCategoryModel>> getGoodsClassificationList(
      int parentId) async {
    BaseListModel model = await NetUtil().getList(
      SARSAPI.market.category.category,
      params: {'pageNum': 1, 'size': 9, 'parentId': parentId},
    );
    if (model.rows.length == 0) return [];
    return model.rows.map((e) => MarketCategoryModel.fromJson(e)).toList();
  }

  ///查询爆款推荐
  static Future<List<GoodsPopularModel>> getGoodsPopularModel(int num) async {
    BaseModel model = await NetUtil().get(
      SARSAPI.market.good.popular,
      params: {'num': num},
    );
    if (model.data!.length == 0) return [];
    return (model.data as List)
        .map((e) => GoodsPopularModel.fromJson(e))
        .toList();
  }

  ///获取所有商品的分类
  static Future<List<MarketAllCategoryModel>> getCategory() async {
    BaseModel model = await NetUtil().get(
      SARSAPI.market.category.categoryInfo,
    );
    if (model.data!.length == 0)
      return [];
    else {
      return (model.data as List)
          .map((e) => MarketAllCategoryModel.fromJson(e))
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
    if (model.rows.length == 0) return null;
    return ActivityItemModel.fromJson(model.rows.first);
  }

  static Future<List<ActivityItemModel>> activityList() async {
    BaseListModel model = await NetUtil().getList(
      API.community.activityList,
      params: {'pageNum': 1, 'size': 5},
    );
    if (model.rows.length == 0) return [];
    return model.rows.map((e) => ActivityItemModel.fromJson(e)).toList();
  }

  static Future<List<BoardItemModel>> board() async {
    BaseListModel model = await NetUtil().getList(
      API.community.boardList,
      params: {'pageNum': 1, 'size': 5},
    );
    if (model.rows.length == 0) return [];
    return model.rows.map((e) => BoardItemModel.fromJson(e)).toList();
  }

  static Future<List<SwiperModel>> swiper() async {
    BaseModel model = await NetUtil().get(
      API.community.getSwiper,
    );
    if (model.data!.length == 0) return [];
    return (model.data as List).map((e) => SwiperModel.fromJson(e)).toList();
  }
}
