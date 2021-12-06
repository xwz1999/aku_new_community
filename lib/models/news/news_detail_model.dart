import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_detail_model.g.dart';

@JsonSerializable()
class NewsDetailModel extends Equatable {
  final int id;
  final String code;
  final String title;
  final String content;
  final String newsCategoryName;
  final String createName;
  final String createDate;

  NewsDetailModel({
    required this.id,
    required this.code,
    required this.title,
    required this.content,
    required this.newsCategoryName,
    required this.createName,
    required this.createDate,
  });

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) =>
      _$NewsDetailModelFromJson(json);

  @override
  List<Object> get props {
    return [
      id,
      code,
      title,
      content,
      newsCategoryName,
      createName,
      createDate,
    ];
  }
}
