import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_community/model/common/img_model.dart';

part 'fix_detail_model.g.dart';

@JsonSerializable()
class FixDetailModel extends Equatable {
  final AppReportRepairVo appReportRepairVo;
  @JsonKey(includeIfNull: true)
  final List<AppProcessRecordVo> appProcessRecordVo;
  final AppMaintenanceResultVo? appMaintenanceResultVo;
  final AppDispatchListVo? appDispatchListVo;
  FixDetailModel({
    required this.appReportRepairVo,
    required this.appProcessRecordVo,
    this.appMaintenanceResultVo,
    required this.appDispatchListVo,
  });
  factory FixDetailModel.fromJson(Map<String, dynamic> json) =>
      _$FixDetailModelFromJson(json);
  @override
  List<Object?> get props => [
        appReportRepairVo,
        appProcessRecordVo,
        appMaintenanceResultVo,
        appDispatchListVo
      ];
}

@JsonSerializable()
class AppReportRepairVo extends Equatable {
  final int id;
  final String roomName;
  final int type;
  final int status;
  final String reportDetail;
  final List<ImgModel> imgUrls;
  AppReportRepairVo({
    required this.roomName,
    required this.id,
    required this.type,
    required this.status,
    required this.reportDetail,
    required this.imgUrls,
  });

  factory AppReportRepairVo.fromJson(Map<String, dynamic> json) =>
      _$AppReportRepairVoFromJson(json);
  @override
  List<Object> get props {
    return [
      id,
      roomName,
      type,
      status,
      reportDetail,
      imgUrls,
    ];
  }
}

@JsonSerializable()
class AppProcessRecordVo extends Equatable {
  final String operationDate;
  final int operationType;
  AppProcessRecordVo({
    required this.operationDate,
    required this.operationType,
  });

  factory AppProcessRecordVo.fromJson(Map<String, dynamic> json) =>
      _$AppProcessRecordVoFromJson(json);
  @override
  List<Object> get props => [operationDate, operationType];
}

@JsonSerializable()
class AppDispatchListVo extends Equatable {
  final String code;
  final String orderDate;
  final int type;
  final String operatorName;
  final String distributorName;
  AppDispatchListVo({
    required this.code,
    required this.orderDate,
    required this.type,
    required this.operatorName,
    required this.distributorName,
  });

  factory AppDispatchListVo.fromJson(Map<String, dynamic> json) =>
      _$AppDispatchListVoFromJson(json);
  @override
  List<Object> get props {
    return [
      code,
      orderDate,
      type,
      operatorName,
      distributorName,
    ];
  }
}

@JsonSerializable()
class AppMaintenanceResultVo extends Equatable {
  final int id;
  final num? laborCost;
  final num? materialCost;
  final num? totalCost;
  final List<ImgModel> imgUrls;
  AppMaintenanceResultVo({
    required this.id,
    this.laborCost,
    this.materialCost,
    this.totalCost,
    required this.imgUrls,
  });

  factory AppMaintenanceResultVo.fromJson(Map<String, dynamic> json) =>
      _$AppMaintenanceResultVoFromJson(json);
  @override
  List<Object?> get props {
    return [
      id,
      laborCost,
      materialCost,
      totalCost,
      imgUrls,
    ];
  }
}
