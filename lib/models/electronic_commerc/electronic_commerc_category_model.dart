import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'electronic_commerc_category_model.g.dart';

@JsonSerializable()
class ElectronicCommercCategoryModel extends Equatable {
  final int id;
  final String name;
  ElectronicCommercCategoryModel({
    required this.id,
    required this.name,
  });

  factory ElectronicCommercCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ElectronicCommercCategoryModelFromJson(json);

  @override
  List<Object> get props => [id, name];
}
