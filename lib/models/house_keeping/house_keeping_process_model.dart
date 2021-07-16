import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'house_keeping_process_model.g.dart';

@JsonSerializable()
class HouseKeepingProcessModel extends Equatable {
  final int id;
  final int housekeepingServiceId;
  final String operationDate;
  final int operationType;
  @JsonKey(name: 'operator')
  final int opName;
  final int operatorType;
  final String operatorContent;
  HouseKeepingProcessModel({
    required this.id,
    required this.housekeepingServiceId,
    required this.operationDate,
    required this.operationType,
    required this.opName,
    required this.operatorType,
    required this.operatorContent,
  });
  factory HouseKeepingProcessModel.fromJson(Map<String, dynamic> json) =>
      _$HouseKeepingProcessModelFromJson(json);
  factory HouseKeepingProcessModel.fail() => HouseKeepingProcessModel(
      id: -1,
      housekeepingServiceId: -1,
      operationDate: '',
      opName: 0,
      operationType: 0,
      operatorContent: '',
      operatorType: 1);
  @override
  List<Object> get props {
    return [
      id,
      housekeepingServiceId,
      operationDate,
      operationType,
      operatorType,
      operatorContent,
    ];
  }
}
