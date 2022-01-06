import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  int code;
  String message;
  bool success;
  dynamic data;
  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);
  BaseModel.err(
      {this.message = '未知错误',
      this.success = false,
      this.data = null,
      this.code = 0});

  BaseModel({
    required this.code,
    required this.message,
    required this.success,
    required this.data,
  });
}
