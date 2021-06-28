import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_community/model/common/img_model.dart';

part 'lease_detail_model.g.dart';

@JsonSerializable()
class LeaseDetailModel extends Equatable {
  final int id;
  final String code;
  final String name;
  final int sex;
  final String idCard;
  final String roomName;
  final int type;
  final String estateType;
  final String estateStructure;
  final num constructionArea;
  final num indoorArea;
  final num rentStandard;
  final num margin;
  final String leaseDateStart;
  final String leaseDateEnd;
  final List<ImgModel>? imgUrls;
  final int status;
  final String? reviewerName;
  final String? auditDate;
  final String createName;
  final String? emergencyContact;
  final String? emergencyContactNumber;
  final String? correspondenceAddress;
  final String? workUnits;
  final String? payBank;
  final String? bankAccountName;
  final String? bankAccount;
  LeaseDetailModel({
    required this.id,
    required this.code,
    required this.name,
    required this.sex,
    required this.idCard,
    required this.roomName,
    required this.type,
    required this.estateType,
    required this.estateStructure,
    required this.constructionArea,
    required this.indoorArea,
    required this.rentStandard,
    required this.margin,
    required this.leaseDateStart,
    required this.leaseDateEnd,
    required this.imgUrls,
    required this.status,
    required this.reviewerName,
    required this.auditDate,
    required this.createName,
    required this.emergencyContact,
    required this.emergencyContactNumber,
    required this.correspondenceAddress,
    required this.workUnits,
    required this.payBank,
    required this.bankAccountName,
    required this.bankAccount,
  });

  factory LeaseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LeaseDetailModelFromJson(json);
  @override
  List<Object?> get props {
    return [
      id,
      code,
      name,
      sex,
      idCard,
      roomName,
      type,
      estateType,
      rentStandard,
      margin,
      leaseDateStart,
      leaseDateEnd,
      imgUrls,
      status,
      reviewerName,
      auditDate,
      createName,
      emergencyContact,
      emergencyContactNumber,
      correspondenceAddress,
      workUnits,
      payBank,
      bankAccountName,
      bankAccount,
    ];
  }
}
