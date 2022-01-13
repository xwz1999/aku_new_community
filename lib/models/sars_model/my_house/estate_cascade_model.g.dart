// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estate_cascade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstateCascadeModel _$EstateCascadeModelFromJson(Map<String, dynamic> json) =>
    EstateCascadeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      childList: (json['childList'] as List<dynamic>)
          .map((e) => Unit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      id: json['id'] as int,
      name: json['name'] as String,
      floor: json['floor'] as int,
      childList: (json['childList'] as List<dynamic>)
          .map((e) => House.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

House _$HouseFromJson(Map<String, dynamic> json) => House(
      id: json['id'] as int,
      name: json['name'] as String,
      manageEstateTypeName: json['manageEstateTypeName'] as String,
    );
