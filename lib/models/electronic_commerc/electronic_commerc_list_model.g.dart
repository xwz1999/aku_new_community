// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electronic_commerc_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectronicCommercListModel _$ElectronicCommercListModelFromJson(
        Map<String, dynamic> json) =>
    ElectronicCommercListModel(
      id: json['id'] as int,
      title: json['title'] as String,
      createDate: json['createDate'] as String,
      imgList: (json['imgList'] as List<dynamic>)
          .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
