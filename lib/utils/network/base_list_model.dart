import 'package:json_annotation/json_annotation.dart';

part 'base_list_model.g.dart';

@JsonSerializable()
class BaseListModel {
  final int pages;
  final List<dynamic> rows;
  final int total;

  BaseListModel.zero({
    this.total = 0,
    this.pages = 0,
    this.rows = const [],
  });

  BaseListModel.err({
    this.pages = 0,
    this.total = 0,
    this.rows = const [],
  });
  factory BaseListModel.fromJson(Map<String, dynamic> json) =>
      _$BaseListModelFromJson(json);
  const BaseListModel({
    required this.pages,
    required this.rows,
    required this.total,
  });
}
