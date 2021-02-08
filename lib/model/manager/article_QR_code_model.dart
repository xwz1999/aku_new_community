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
  String roomName;
  int applicantId;
  String applicantName;
  String effectiveTime;

  AppArticleOutQRCodeVo(
      {this.id,
      this.roomName,
      this.applicantId,
      this.applicantName,
      this.effectiveTime});

  AppArticleOutQRCodeVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomName = json['roomName'];
    applicantId = json['applicantId'];
    applicantName = json['applicantName'];
    effectiveTime = json['effectiveTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomName'] = this.roomName;
    data['applicantId'] = this.applicantId;
    data['applicantName'] = this.applicantName;
    data['effectiveTime'] = this.effectiveTime;
    return data;
  }
}
