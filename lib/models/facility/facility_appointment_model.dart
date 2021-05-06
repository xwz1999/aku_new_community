import 'package:json_annotation/json_annotation.dart';
part 'facility_appointment_model.g.dart';

@JsonSerializable()
class FacilityAppointmentModel {
  final int id;
  final String code;
  final String facilitiesName;
  final int status;
  final String address;
  final String appointmentStartDate;
  final String appointmentEndDate;
  final String? nullifyReason;
  final String? useEndDate;

  FacilityAppointmentModel({
    required this.id,
    required this.code,
    required this.facilitiesName,
    required this.status,
    required this.address,
    required this.appointmentStartDate,
    required this.appointmentEndDate,
    required this.nullifyReason,
    required this.useEndDate,
  });

  factory FacilityAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityAppointmentModelFromJson(json);
}
