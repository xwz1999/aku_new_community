import 'package:json_annotation/json_annotation.dart';

part 'share_pay_record_model.g.dart';

@JsonSerializable()
class SharePayRecordModel {
  final double payPrice;
  final String paymentTime;
  final int payType;
  final String code;
  final String months;
  final String effectiveTimeStart;
  final String effectiveTimeEnd;
  final double shareUnitPrice;
  final double indoorArea;
  factory SharePayRecordModel.fromJson(Map<String, dynamic> json) =>
      _$SharePayRecordModelFromJson(json);

  const SharePayRecordModel({
    required this.payPrice,
    required this.paymentTime,
    required this.payType,
    required this.code,
    required this.months,
    required this.effectiveTimeStart,
    required this.effectiveTimeEnd,
    required this.shareUnitPrice,
    required this.indoorArea,
  });
}
