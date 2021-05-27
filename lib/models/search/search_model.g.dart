// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) {
  return SearchModel(
    activityVoList: (json['activityVoList'] as List<dynamic>)
        .map((e) => e == null
            ? null
            : ActivityItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    gambitVoList: (json['gambitVoList'] as List<dynamic>)
        .map((e) => e == null
            ? null
            : CommunityTopicModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
