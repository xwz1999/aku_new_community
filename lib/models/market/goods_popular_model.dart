import 'package:json_annotation/json_annotation.dart';

part 'goods_popular_model.g.dart';

@JsonSerializable()
class GoodsPopularModel {
  int? id;
  String? skuName;
  String? mainPhoto;
  int? viewsNum;
  factory GoodsPopularModel.fromJson(Map<String, dynamic> json) =>
      _$GoodsPopularModelFromJson(json);

  GoodsPopularModel({
    this.id,
    this.skuName,
    this.mainPhoto,
    this.viewsNum,
  });
}
