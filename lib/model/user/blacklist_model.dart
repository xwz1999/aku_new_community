import 'package:aku_new_community/model/common/img_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'blacklist_model.g.dart';

@JsonSerializable()
class BlacklistModel extends Equatable {
  final int id;
  final List<ImgModel> imgList;
  final String? name;
  final String nickName;

  factory BlacklistModel.fromJson(Map<String, dynamic> json) =>
      _$BlacklistModelFromJson(json);

  const BlacklistModel({
    required this.id,
    required this.imgList,
    this.name,
    required this.nickName,
  });

  @override
  List<Object?> get props => [
        id,
        imgList,
        name,
        nickName,
      ];
}
