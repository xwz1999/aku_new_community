// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamListModel _$TeamListModelFromJson(Map<String, dynamic> json) =>
    TeamListModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imgs: (json['imgs'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tel: json['tel'] as String,
      position: json['position'] as String,
    );
