import 'package:equatable/equatable.dart';
import 'package:flustars/flustars.dart';
import 'package:json_annotation/json_annotation.dart';
part 'facility_order_date_list_model.g.dart';

@JsonSerializable()
class FacilityOrderDateListModel extends Equatable {
  final int id;
  final String appointmentStartDate;
  final String appointmentEndDate;
  final String appointmentName;
  FacilityOrderDateListModel({
    required this.id,
    required this.appointmentStartDate,
    required this.appointmentEndDate,
    required this.appointmentName,
  });
  factory FacilityOrderDateListModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityOrderDateListModelFromJson(json);
  String get startDateString =>
      DateUtil.formatDateStr(this.appointmentStartDate,
          format: 'yyyy-MM-dd HH:mm');
  String get endDateString => DateUtil.formatDateStr(this.appointmentEndDate,
      format: 'yyyy-MM-dd HH:mm');
  String get tiemSlot =>
      '${this.startDateString}-${DateUtil.formatDateStr(this.appointmentEndDate, format: 'HH:mm')}';
  @override
  List<Object> get props =>
      [id, appointmentStartDate, appointmentEndDate, appointmentName];
}
