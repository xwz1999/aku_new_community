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
      status: json['status'] as int,
      address: json['address'] as String,
      reserveStartDate: json['reserveStartDate'] as String,
      reserveEndDate: json['reserveEndDate'] as String,
      nullifyReason: json['nullifyReason'] as String?,
    );
