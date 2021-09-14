import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'share_pay_list_model.g.dart';

@JsonSerializable(createToJson: true)
class SharePayListModel extends Equatable {
  final int id;
  final String months;
  final int type;
  final int num;
  final double total;
  final List<AppMeterShareDetailsVos> appMeterShareDetailsVos;

  factory SharePayListModel.fromJson(Map<String, dynamic> json) =>
      _$SharePayListModelFromJson(json);

  Map<String, dynamic> toJson() => _$SharePayListModelToJson(this);

  @override
  List<Object?> get props =>
      [id, months, type, num, total, appMeterShareDetailsVos];

  const SharePayListModel({
    required this.id,
    required this.months,
    required this.type,
    required this.num,
    required this.total,
    required this.appMeterShareDetailsVos,
  });

  SharePayListModel copyWith({
    int? id,
    String? months,
    int? type,
    int? num,
    double? total,
    List<AppMeterShareDetailsVos>? appMeterShareDetailsVos,
  }) {
    return SharePayListModel(
      id: id ?? this.id,
      months: months ?? this.months,
      type: type ?? this.type,
      num: num ?? this.num,
      total: total ?? this.total,
      appMeterShareDetailsVos:
          appMeterShareDetailsVos ?? this.appMeterShareDetailsVos,
    );
  }
}

@JsonSerializable(createToJson: true)
class AppMeterShareDetailsVos extends Equatable {
  final int id;
  final double houseArea;
  final double amountPayable;
  final double paidAmount;
  final double remainingUnpaidAmount;
  final int status;
  final double rate;
  final String paymentPeriod;
  final String? paymentTime;
  final double lateFree;

  factory AppMeterShareDetailsVos.fromJson(Map<String, dynamic> json) =>
      _$AppMeterShareDetailsVosFromJson(json);

  Map<String, dynamic> toJson() => _$AppMeterShareDetailsVosToJson(this);

  @override
  List<Object?> get props => [
        id,
        houseArea,
        amountPayable,
        paidAmount,
        remainingUnpaidAmount,
        status,
        rate,
        paymentPeriod,
        paymentTime,
        lateFree
      ];

  const AppMeterShareDetailsVos({
    required this.id,
    required this.houseArea,
    required this.amountPayable,
    required this.paidAmount,
    required this.remainingUnpaidAmount,
    required this.status,
    required this.rate,
    required this.paymentPeriod,
    this.paymentTime,
    required this.lateFree,
  });

  AppMeterShareDetailsVos copyWith({
    int? id,
    double? houseArea,
    double? amountPayable,
    double? paidAmount,
    double? remainingUnpaidAmount,
    int? status,
    double? rate,
    String? paymentPeriod,
    String? paymentTime,
    double? lateFree,
  }) {
    return AppMeterShareDetailsVos(
      id: id ?? this.id,
      houseArea: houseArea ?? this.houseArea,
      amountPayable: amountPayable ?? this.amountPayable,
      paidAmount: paidAmount ?? this.paidAmount,
      remainingUnpaidAmount:
          remainingUnpaidAmount ?? this.remainingUnpaidAmount,
      status: status ?? this.status,
      rate: rate ?? this.rate,
      paymentPeriod: paymentPeriod ?? this.paymentPeriod,
      paymentTime: paymentTime ?? this.paymentTime,
      lateFree: lateFree ?? this.lateFree,
    );
  }
}
