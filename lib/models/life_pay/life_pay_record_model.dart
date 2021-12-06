import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'life_pay_record_model.g.dart';

@JsonSerializable()
class LifePayRecordModel extends Equatable {
  final int id;
  final String chargesTemplateDetailName;
  final String roomName;
  final String years;
  final num paidPrice;
  final String createName;
  final String createDate;
  final int payType;
  final String code;

  LifePayRecordModel({
    required this.id,
    required this.chargesTemplateDetailName,
    required this.roomName,
    required this.years,
    required this.paidPrice,
    required this.createName,
    required this.createDate,
    required this.payType,
    required this.code,
  });

  factory LifePayRecordModel.fromJson(Map<String, dynamic> json) =>
      _$LifePayRecordModelFromJson(json);

  @override
  List<Object> get props {
    return [
      id,
      chargesTemplateDetailName,
      roomName,
      years,
      paidPrice,
      createName,
      createDate,
      payType,
      code,
    ];
  }
}
