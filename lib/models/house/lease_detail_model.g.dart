// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lease_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaseDetailModel _$LeaseDetailModelFromJson(Map<String, dynamic> json) {
  return LeaseDetailModel(
    id: json['id'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    sex: json['sex'] as int,
    idCard: json['idCard'] as String,
    roomName: json['roomName'] as String,
    type: json['type'] as int,
    estateType: json['estateType'] as String,
    rentStandard: json['rentStandard'] as num,
    margin: json['margin'] as num,
    leaseDateStart: json['leaseDateStart'] as String,
    leaseDateEnd: json['leaseDateEnd'] as String,
    imgUrls: (json['imgUrls'] as List<dynamic>?)
        ?.map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    status: json['status'] as int,
    reviewerName: json['reviewerName'] as String?,
    auditDate: json['auditDate'] as String?,
    createName: json['createName'] as String,
    emergencyContact: json['emergencyContact'] as String?,
    emergencyContactNumber: json['emergencyContactNumber'] as String?,
    correspondenceAddress: json['correspondenceAddress'] as String?,
    workUnits: json['workUnits'] as String?,
    payBank: json['payBank'] as String?,
    bankAccountName: json['bankAccountName'] as String?,
    bankAccount: json['bankAccount'] as String?,
  );
}
