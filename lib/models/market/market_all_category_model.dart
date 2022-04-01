import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'market_all_category_model.g.dart';

@JsonSerializable()
class MarketAllCategoryModel {
  final int id;
  final String? name;
  final List<ImgModel> imgUrls;
  final List<MarketAllCategoryModel> categoryList;
  factory MarketAllCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MarketAllCategoryModelFromJson(json);

  const MarketAllCategoryModel({
    required this.id,
    required this.name,
    required this.imgUrls,
    required this.categoryList,
  });
}
