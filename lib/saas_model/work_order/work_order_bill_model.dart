import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_order_bill_model.g.dart';

@JsonSerializable()
class WorkOrderBillModel extends Equatable {
  final int id;
  final int costType;
  final String name;
  @JsonKey(name: 'num')
  final int number;
  final num price;

  factory WorkOrderBillModel.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderBillModelFromJson(json);

  const WorkOrderBillModel({
    required this.id,
    required this.costType,
    required this.name,
    required this.number,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        costType,
        name,
        number,
        price,
      ];
}
