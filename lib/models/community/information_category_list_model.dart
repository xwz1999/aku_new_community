import 'package:json_annotation/json_annotation.dart';

part 'information_category_list_model.g.dart';

@JsonSerializable()
class InformationCategoryListModel {
  final int id;
  final String name;
  factory InformationCategoryListModel.fromJson(Map<String, dynamic> json) =>
      _$InformationCategoryListModelFromJson(json);

  const InformationCategoryListModel({
    required this.id,
    required this.name,
  });
}
