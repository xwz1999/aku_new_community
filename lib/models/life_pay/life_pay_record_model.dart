import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'life_pay_record_model.g.dart';

@JsonSerializable()
class LifePayRecordModel extends Equatable {
  final int id;
  final String chargesName;
  final String communityName;
  final String buildingName;
  final String unitName;
  final String estateName;
  final String billDateStart;
  final String billDateEnd;
  final String billCreateDate;
  final num payAmount;
  final String createDate;
  final int payType;
  final String code;



  factory LifePayRecordModel.fromJson(Map<String, dynamic> json) =>
      _$LifePayRecordModelFromJson(json);

  @override
  List<Object> get props {
    return [
      id,
      chargesName,
      communityName,
      buildingName,
      unitName,
      estateName,
      billDateStart,
      billDateEnd,
      billCreateDate,
      payAmount,
      createDate,
      payType,
      code,
    ];
  }

   LifePayRecordModel({
    required this.id,
    required this.chargesName,
    required this.communityName,
    required this.buildingName,
    required this.unitName,
    required this.estateName,
    required this.billDateStart,
    required this.billDateEnd,
    required this.billCreateDate,
    required this.payAmount,
    required this.createDate,
    required this.payType,
    required this.code,
  });
}
