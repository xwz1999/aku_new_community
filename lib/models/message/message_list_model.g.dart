// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageListModel _$MessageListModelFromJson(Map<String, dynamic> json) =>
    MessageListModel(
      id: json['id'] as int,
      type: json['type'] as int,
      status: json['status'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      sendDate: json['sendDate'] as String,
      jumpId: json['jumpId'] as int,
      onlyId: json['onlyId'] as int?,
    );
