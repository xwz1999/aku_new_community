import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_order_type_model.g.dart';

@JsonSerializable()
class WorkOrderTypeModel extends Equatable {
  final int id;
  final String name;
  factory WorkOrderTypeModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderTypeModelFromJson(json);

  const WorkOrderTypeModel({
    required this.id,
    required this.name,
  });
  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
