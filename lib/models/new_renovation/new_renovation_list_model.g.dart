// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_renovation_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewRenovationListModel _$NewRenovationListModelFromJson(
    Map<String, dynamic> json) {
  return NewRenovationListModel(
    id: json['id'] as int,
    roomName: json['roomName'] as String,
    status: json['status'] as int,
    constructionUnit: json['constructionUnit'] as String,
    director: json['director'] as String,
    directorTel: json['directorTel'] as String,
    expectedBegin: json['expectedBegin'] as String,
    expectedEnd: json['expectedEnd'] as String,
    actualBegin: json['actualBegin'] as String?,
    actualEnd: json['actualEnd'] as String?,
    rejectReason: json['rejectReason'] as String?,
    reviewerName: json['reviewerName'] as String?,
    auditDate: json['auditDate'] as String?,
    trackerName: json['trackerName'] as String?,
    applicationCheckDate: json['applicationCheckDate'] as String?,
    isQualified: json['isQualified'] as int?,
    createName: json['createName'] as String,
    createDate: json['createDate'] as String,
    checkVoList: (json['checkVoList'] as List<dynamic>)
        .map((e) =>
            e == null ? null : CheckVoList.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

CheckVoList _$CheckVoListFromJson(Map<String, dynamic> json) {
  return CheckVoList(
    id: json['id'] as int,
    decorationNewId: json['decorationNewId'] as int,
    detail: json['detail'] as String,
    isQualified: json['isQualified'] as int,
    createName: json['createName'] as String,
    createDate: json['createDate'] as String,
  );
}
