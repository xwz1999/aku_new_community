import 'package:json_annotation/json_annotation.dart';

part 'news_category_model.g.dart';

@JsonSerializable()
class NewsCategoryModel {
  final int id;
  final String name;
  NewsCategoryModel({
    required this.id,
    required this.name,
  });

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$NewsCategoryModelFromJson(json);
}
