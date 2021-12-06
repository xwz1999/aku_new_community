import 'package:aku_new_community/model/community/activity_item_model.dart';
import 'package:aku_new_community/model/community/community_topic_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel extends Equatable {
  final List<ActivityItemModel?> activityVoList;
  final List<CommunityTopicModel?> gambitVoList;

  SearchModel({
    required this.activityVoList,
    required this.gambitVoList,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);

  factory SearchModel.init() =>
      SearchModel(activityVoList: [], gambitVoList: []);

  @override
  List<Object> get props => [activityVoList, gambitVoList];
}
