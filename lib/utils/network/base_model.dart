import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable(includeIfNull: false)
class BaseModel {
  final int code;
  final String msg;
  final bool success;
  final dynamic data;

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  static BaseModel error(
          {String? message, bool? success, dynamic data, int? code}) =>
      BaseModel(
          code: code ?? 0, msg: message ?? '未知错误', success: success ?? false);

  BaseModel({
    required this.code,
    required this.msg,
    required this.success,
    this.data,
  });
}
