import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/market/market_category_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class DisplayCategoryModel {
  final MarketCategoryModel model;
  final List<MarketCategoryModel> children;

  DisplayCategoryModel({
    required this.model,
    required this.children,
  });

  static Future<List<MarketCategoryModel>> get top8 async {
    List<MarketCategoryModel> models = await fetchCategory(0);
    if (models.length >= 8)
      return models.getRange(0, 8).toList();
    else
      return models;
  }

  ///获取分类列表
  static Future<List<MarketCategoryModel>> fetchCategory(int parentId) async {
    BaseModel model = await NetUtil().get(
      API.market.category,
      params: {'parentId': parentId},
    );
    if (model.data == null) return [];
    return (model.data as List)
        .map((e) => MarketCategoryModel.fromJson(e))
        .toList();
  }
}
