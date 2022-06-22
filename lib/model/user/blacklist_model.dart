import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'blacklist_model.g.dart';


@JsonSerializable()
class BlacklistModel extends Equatable {
  int id;
  List imgList;
  String name;

  factory BlacklistModel.fromJson(Map<String, dynamic> json) =>
      _$BlacklistModelFromJson(json);


  BlacklistModel({
    required this.id,
    required this.imgList,
    required this.name,
  });

  @override
  List<Object?> get props => [id, imgList, name,];
}