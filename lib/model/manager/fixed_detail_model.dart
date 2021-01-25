class FixedDetailModel {
  AppReportRepairVo appReportRepairVo;
  List<AppProcessRecordVo> appProcessRecordVo;
  Null appMaintenanceResultVo;
  List<AppDispatchListVo> appDispatchListVo;

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
    appMaintenanceResultVo = json['appMaintenanceResultVo'];
    if (json['appDispatchListVo'] != null) {
      appDispatchListVo = new List<AppDispatchListVo>();
      json['appDispatchListVo'].forEach((v) {
        appDispatchListVo.add(new AppDispatchListVo.fromJson(v));
      });
    }
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
      data['appDispatchListVo'] =
          this.appDispatchListVo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppReportRepairVo {
  int id;
  int type;
  int status;
  String reportDetail;
  List<ImgUrls> imgUrls;

  AppReportRepairVo(
      {this.id, this.type, this.status, this.reportDetail, this.imgUrls});

  AppReportRepairVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    reportDetail = json['reportDetail'];
    if (json['imgUrls'] != null) {
      imgUrls = new List<ImgUrls>();
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgUrls.fromJson(v));
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

class ImgUrls {
  String url;
  String size;
  int longs;
  int paragraph;
  int sort;

  ImgUrls({this.url, this.size, this.longs, this.paragraph, this.sort});

  ImgUrls.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    size = json['size'];
    longs = json['longs'];
    paragraph = json['paragraph'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['size'] = this.size;
    data['longs'] = this.longs;
    data['paragraph'] = this.paragraph;
    data['sort'] = this.sort;
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
  int code;
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
