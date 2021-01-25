class FixedDetailModel {
  AppReportRepairVo appReportRepairVo;
  List<AppProcessRecordVo> appProcessRecordVo;
  List<String> appMaintenanceResultVo; //暂无用 待修改
  List<String> appDispatchListVo; //暂无用 待修改

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
      appProcessRecordVo = new List<AppProcessRecordVo>();
      json['appProcessRecordVo'].forEach((v) {
        appProcessRecordVo.add(new AppProcessRecordVo.fromJson(v));
      });
    }
    appMaintenanceResultVo = json['appMaintenanceResultVo'].cast<String>();
    appDispatchListVo = json['appDispatchListVo'].cast<String>();
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
    data['appDispatchListVo'] = this.appDispatchListVo;
    return data;
  }
}

class AppReportRepairVo {
  int id;
  int type;
  int status;
  String reportDetail;
  List<String> imgUrls;

  AppReportRepairVo(
      {this.id, this.type, this.status, this.reportDetail, this.imgUrls});

  AppReportRepairVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    reportDetail = json['reportDetail'];
    imgUrls = json['imgUrls'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['reportDetail'] = this.reportDetail;
    data['imgUrls'] = this.imgUrls;
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
