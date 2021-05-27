import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_browse_list_mode.g.dart';

@JsonSerializable()
class ServiceBrowseListModel extends Equatable {
  final int id;
  final String name;
  final String content;
  final String createDate;
  ServiceBrowseListModel({
    required this.id,
    required this.name,
    required this.content,
    required this.createDate,
  });
  factory ServiceBrowseListModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceBrowseListModelFromJson(json);
  @override
  List<Object> get props => [id, name, content, createDate];
}
