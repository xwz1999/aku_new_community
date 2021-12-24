import 'package:flustars/flustars.dart';
import 'package:json_annotation/json_annotation.dart';

part 'announce_list_model.g.dart';

@JsonSerializable()
class AnnounceListModel {
  final int id;
  final String date;
  final String title;
  final String content;

  String get month {
    var date = DateUtil.getDateTime(this.date);
    return date!.year.toString() + '年' + date.month.toString() + '月';
  }

  factory AnnounceListModel.fromJson(Map<String, dynamic> json) =>
      _$AnnounceListModelFromJson(json);

  const AnnounceListModel({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
  });

  AnnounceListModel copyWith({
    int? id,
    String? date,
    String? title,
    String? content,
  }) {
    return AnnounceListModel(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}
