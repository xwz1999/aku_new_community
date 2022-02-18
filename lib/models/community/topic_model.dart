import 'package:json_annotation/json_annotation.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class TopicModel {
  final int id;
  final String title;
  final int type;

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);

  String get typeToString {
    switch (type) {
      case 1:
        return '普通';
      case 2:
        return '推荐';
      case 3:
        return '热门';
      default:
        return '';
    }
  }

  const TopicModel({
    required this.id,
    required this.title,
    required this.type,
  });
}
