import 'package:common_utils/common_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'message_list_model.g.dart';

@JsonSerializable()
class MessageListModel extends Equatable {
  final int id;
  final int type;
  final int status;
  final String title;
  final String content;
  final String sendDate;
  final int jumpId;
  final int? onlyId;

  DateTime? get sendDt => DateUtil.getDateTime(sendDate);

  int? get month => sendDt?.month;

  int? get year => sendDt?.year;

  factory MessageListModel.fromJson(Map<String, dynamic> json) =>
      _$MessageListModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        type,
        status,
        title,
        content,
        sendDate,
        jumpId,
        onlyId,
      ];

  const MessageListModel({
    required this.id,
    required this.type,
    required this.status,
    required this.title,
    required this.content,
    required this.sendDate,
    required this.jumpId,
    required this.onlyId,
  });

  MessageListModel copyWith({
    int? id,
    int? type,
    int? status,
    String? title,
    String? content,
    String? sendDate,
    int? jumpId,
    int? onlyId,
  }) {
    return MessageListModel(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      title: title ?? this.title,
      content: content ?? this.content,
      sendDate: sendDate ?? this.sendDate,
      jumpId: jumpId ?? this.jumpId,
      onlyId: onlyId ?? this.onlyId,
    );
  }
}
