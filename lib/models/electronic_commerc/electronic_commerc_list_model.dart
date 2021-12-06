import 'package:aku_new_community/model/common/img_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'electronic_commerc_list_model.g.dart';

@JsonSerializable()
class ElectronicCommercListModel extends Equatable {
  final int id;
  final String title;
  final String createDate;
  final List<ImgModel> imgList;

  ElectronicCommercListModel({
    required this.id,
    required this.title,
    required this.createDate,
    required this.imgList,
  });

  factory ElectronicCommercListModel.fromJson(Map<String, dynamic> json) =>
      _$ElectronicCommercListModelFromJson(json);

  @override
  List<Object> get props => [id, title, createDate, imgList];
}
