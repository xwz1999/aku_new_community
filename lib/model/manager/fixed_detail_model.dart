import 'package:akuCommunity/model/common/img_model.dart';

class FixedDetailModel {
  AppReportRepairVo appReportRepairVo;
  List<AppProcessRecordVo> appProcessRecordVo;
  Null appMaintenanceResultVo;
  AppDispatchListVo appDispatchListVo;

  FixedDetailModel(
      {this.appReportRepairVo,
      this.appProcessRecordVo,
      this.appMaintenanceResultVo,
      this.appDispatchListVo});

  FixedDetailModel.fromJson(Map<String, dynamic> json) {
    appReportRepairVo = json['appReportRepairVo'] != null
        ? new AppReportRepairVo.fromJson(json['appReportRepairVo'])
        : null;
    if (json['appProcessRecordVo'] != null) {
      appProcessRecordVo = [];
      json['appProcessRecordVo'].forEach((v) {
        appProcessRecordVo.add(new AppProcessRecordVo.fromJson(v));
      });
    }
    appMaintenanceResultVo = json['appMaintenanceResultVo'];
    appDispatchListVo = json['appDispatchListVo'] != null
        ? new AppDispatchListVo.fromJson(json['appDispatchListVo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appReportRepairVo != null) {
      data['appReportRepairVo'] = this.appReportRepairVo.toJson();
    }
    if (this.appProcessRecordVo != null) {
      data['appProcessRecordVo'] =
          this.appProcessRecordVo.map((v) => v.toJson()).toList();
    }
    data['appMaintenanceResultVo'] = this.appMaintenanceResultVo;
    if (this.appDispatchListVo != null) {
      data['appDispatchListVo'] = this.appDispatchListVo.toJson();
    }
    return data;
  }
}

class AppReportRepairVo {
  int id;
  int type;
  int status;
  String reportDetail;
  List<ImgModel> imgUrls;

  AppReportRepairVo(
      {this.id, this.type, this.status, this.reportDetail, this.imgUrls});

  AppReportRepairVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    reportDetail = json['reportDetail'];
    if (json['imgUrls'] != null) {
      imgUrls = [];
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['reportDetail'] = this.reportDetail;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppProcessRecordVo {
  String operationDate;
  int operationType;

  AppProcessRecordVo({this.operationDate, this.operationType});

  AppProcessRecordVo.fromJson(Map<String, dynamic> json) {
    operationDate = json['operationDate'];
    operationType = json['operationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operationDate'] = this.operationDate;
    data['operationType'] = this.operationType;
    return data;
  }
}

class AppDispatchListVo {
  String code;
  String orderDate;
  int type;
  String operatorName;
  String distributorName;

  AppDispatchListVo(
      {this.code,
      this.orderDate,
      this.type,
      this.operatorName,
      this.distributorName});

  AppDispatchListVo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    orderDate = json['orderDate'];
    type = json['type'];
    operatorName = json['operatorName'];
    distributorName = json['distributorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['orderDate'] = this.orderDate;
    data['type'] = this.type;
    data['operatorName'] = this.operatorName;
    data['distributorName'] = this.distributorName;
    return data;
  }
}
