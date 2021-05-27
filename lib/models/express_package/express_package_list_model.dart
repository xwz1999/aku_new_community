import 'package:equatable/equatable.dart';
import 'package:flustars/flustars.dart';
import 'package:json_annotation/json_annotation.dart';

part 'express_package_list_model.g.dart';

@JsonSerializable()
class ExpressPackageListModel extends Equatable {
  final int id;
  final String code;
  final String addresseeName;
  final String addresseeTel;
  final String address;
  final int status;
  final String? receiveDate;
  final String createDate;
  final String placePosition;
  ExpressPackageListModel({
    required this.id,
    required this.code,
    required this.addresseeName,
    required this.addresseeTel,
    required this.address,
    required this.status,
    required this.receiveDate,
    required this.createDate,
    required this.placePosition,
  });
  factory ExpressPackageListModel.fromJson(Map<String, dynamic> json) =>
      _$ExpressPackageListModelFromJson(json);
  String get createDateString =>
      DateUtil.formatDateStr(this.createDate, format: 'yyyy-MM-dd HH:mm');

  @override
  List<Object?> get props => throw UnimplementedError();
}
