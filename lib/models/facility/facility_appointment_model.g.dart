// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityAppointmentModel _$FacilityAppointmentModelFromJson(
        Map<String, dynamic> json) =>
    FacilityAppointmentModel(
      id: json['id'] as int,
      code: json['code'] as String,
      facilitiesName: json['facilitiesName'] as String,
      status: json['status'] as int,
      address: json['address'] as String,
      appointmentStartDate: json['appointmentStartDate'] as String,
      appointmentEndDate: json['appointmentEndDate'] as String,
      nullifyReason: json['nullifyReason'] as String?,
      useEndDate: json['useEndDate'] as String?,
    );
