// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fix_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixDetailModel _$FixDetailModelFromJson(Map<String, dynamic> json) {
  return FixDetailModel(
    appReportRepairVo: AppReportRepairVo.fromJson(
        json['appReportRepairVo'] as Map<String, dynamic>),
    appProcessRecordVo: (json['appProcessRecordVo'] as List<dynamic>)
        .map((e) => AppProcessRecordVo.fromJson(e as Map<String, dynamic>))
        .toList(),
    appMaintenanceResultVo: json['appMaintenanceResultVo'] == null
        ? null
        : AppMaintenanceResultVo.fromJson(
            json['appMaintenanceResultVo'] as Map<String, dynamic>),
    appDispatchListVo: json['appDispatchListVo'] == null
        ? null
        : AppDispatchListVo.fromJson(
            json['appDispatchListVo'] as Map<String, dynamic>),
  );
}

AppReportRepairVo _$AppReportRepairVoFromJson(Map<String, dynamic> json) {
  return AppReportRepairVo(
    id: json['id'] as int,
    type: json['type'] as int,
    status: json['status'] as int,
    reportDetail: json['reportDetail'] as String,
    imgUrls: (json['imgUrls'] as List<dynamic>)
        .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

AppProcessRecordVo _$AppProcessRecordVoFromJson(Map<String, dynamic> json) {
  return AppProcessRecordVo(
    operationDate: json['operationDate'] as String,
    operationType: json['operationType'] as int,
  );
}

AppDispatchListVo _$AppDispatchListVoFromJson(Map<String, dynamic> json) {
  return AppDispatchListVo(
    code: json['code'] as String,
    orderDate: json['orderDate'] as String,
    type: json['type'] as int,
    operatorName: json['operatorName'] as String,
    distributorName: json['distributorName'] as String,
  );
}

AppMaintenanceResultVo _$AppMaintenanceResultVoFromJson(
    Map<String, dynamic> json) {
  return AppMaintenanceResultVo(
    id: json['id'] as int,
    laborCost: json['laborCost'] as num?,
    materialCost: json['materialCost'] as num?,
    totalCost: json['totalCost'] as num?,
    imgUrls: (json['imgUrls'] as List<dynamic>)
        .map((e) => ImgModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
