import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'electronic_commerc_detail_model.g.dart';

@JsonSerializable()
class ElectronicCommercDetailModel extends Equatable {
  final int id;
  final String title;
  final String code;
  final String content;
  final String electronicCommerceCategoryName;
  final String createName;
  final String createDate;
  ElectronicCommercDetailModel({
    required this.id,
    required this.title,
    required this.code,
    required this.content,
    required this.electronicCommerceCategoryName,
    required this.createName,
    required this.createDate,
  });
  factory ElectronicCommercDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ElectronicCommercDetailModelFromJson(json);
  @override
  List<Object> get props {
    return [
      id,
      title,
      code,
      content,
      electronicCommerceCategoryName,
      createName,
      createDate,
    ];
  }
}
