class ArticleQRModel {
  AppArticleOutQRCodeVo appArticleOutQRCodeVo;
  String message;
  bool status;

  ArticleQRModel({this.appArticleOutQRCodeVo, this.message, this.status});

  ArticleQRModel.fromJson(Map<String, dynamic> json) {
    appArticleOutQRCodeVo = json['appArticleOutQRCodeVo'] != null
        ? new AppArticleOutQRCodeVo.fromJson(json['appArticleOutQRCodeVo'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appArticleOutQRCodeVo != null) {
      data['appArticleOutQRCodeVo'] = this.appArticleOutQRCodeVo.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class AppArticleOutQRCodeVo {
  int id;
  int residentId;
  String residentName;
  String effectiveTime;

  AppArticleOutQRCodeVo(
      {this.id, this.residentId, this.residentName, this.effectiveTime});

  AppArticleOutQRCodeVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    residentId = json['residentId'];
    residentName = json['residentName'];
    effectiveTime = json['effectiveTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['residentId'] = this.residentId;
    data['residentName'] = this.residentName;
    data['effectiveTime'] = this.effectiveTime;
    return data;
  }
}
