import 'package:aku_community/model/common/img_model.dart';

class BoardDetailModel {
  int? id;
  String? title;
  String? content;
  String? fileDocUrl;
  String? fileDocName;
  String? releaseTime;
  List<ImgModel>? imgUrls;

  BoardDetailModel(
      {this.id,
      this.title,
      this.content,
      this.fileDocUrl,
      this.fileDocName,
      this.releaseTime,
      this.imgUrls});

  BoardDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    fileDocUrl = json['fileDocUrl'];
    fileDocName = json['fileDocName'];
    releaseTime = json['releaseTime'];
    if (json['imgUrls'] != null) {
      imgUrls = [];
      json['imgUrls'].forEach((v) {
        imgUrls!.add(new ImgModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['fileDocUrl'] = this.fileDocUrl;
    data['fileDocName'] = this.fileDocName;
    data['releaseTime'] = this.releaseTime;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
