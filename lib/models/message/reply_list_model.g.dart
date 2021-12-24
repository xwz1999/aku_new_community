// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyListModel _$ReplyListModelFromJson(Map<String, dynamic> json) =>
    ReplyListModel(
      id: json['id'] as int,
      name: json['name'] as String,
      date: json['date'] as String,
      content: json['content'] as String,
      img: ImgModel.fromJson(json['img'] as Map<String, dynamic>),
      title: json['title'] as String,
      pic: ImgModel.fromJson(json['pic'] as Map<String, dynamic>),
    );
