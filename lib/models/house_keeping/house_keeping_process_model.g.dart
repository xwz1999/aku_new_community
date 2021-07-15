// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_keeping_process_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseKeepingProcessModel _$HouseKeepingProcessModelFromJson(
    Map<String, dynamic> json) {
  return HouseKeepingProcessModel(
    id: json['id'] as int,
    housekeepingServiceId: json['housekeepingServiceId'] as int,
    operationDate: json['operationDate'] as String,
    operationType: json['operationType'] as int,
    opName: json['operator'] as int,
    operatorType: json['operatorType'] as int,
    operatorContent: json['operatorContent'] as String,
  );
}
