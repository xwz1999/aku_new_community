import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/model/common/img_model.dart';

part 'market_category_model.g.dart';

@JsonSerializable()
class MarketCategoryModel extends Equatable {
  final int id;
  final String? name;
  final List<ImgModel> imgUrls;

  @override
  List<Object?> get props => [id];

  factory MarketCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MarketCategoryModelFromJson(json);

  const MarketCategoryModel({
    required this.id,
    required this.name,
    required this.imgUrls,
  });
}
