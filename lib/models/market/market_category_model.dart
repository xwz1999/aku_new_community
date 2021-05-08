import 'package:equatable/equatable.dart';

import 'package:aku_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'market_category_model.g.dart';

@JsonSerializable()
class MarketCategoryModel extends Equatable {
  final int id;
  final String name;
  final List<ImgModel> imgList;
  MarketCategoryModel({
    required this.id,
    required this.name,
    required this.imgList,
  });
  @override
  List<Object?> get props => [id];

  factory MarketCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MarketCategoryModelFromJson(json);
}
