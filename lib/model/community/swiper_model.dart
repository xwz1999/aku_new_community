import 'package:aku_community/model/common/img_model.dart';

class SwiperModel {
  int? newsId;
  String? title;
  List<ImgModel>? voResourcesImgList;

  SwiperModel({this.newsId, this.title, this.voResourcesImgList});

  SwiperModel.fromJson(Map<String, dynamic> json) {
    newsId = json['newsId'];
    title = json['title'];
    if (json['voResourcesImgList'] != null) {
      voResourcesImgList = [];
      json['voResourcesImgList'].forEach((v) {
        voResourcesImgList!.add(new ImgModel.fromJson(v));
      });
    } else {
      voResourcesImgList = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newsId'] = this.newsId;
    data['title'] = this.title;
    if (this.voResourcesImgList != null) {
      data['voResourcesImgList'] = this.voResourcesImgList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}