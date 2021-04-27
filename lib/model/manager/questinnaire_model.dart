import 'package:aku_community/model/common/img_model.dart';

class QuestionnaireModel {
  int id;
  String title;
  String description;
  String beginDate;
  String endDate;
  int status;
  int answerNum;
  List<ImgModel> imgUrls;
  List<ImgModel> headImgURls;

  QuestionnaireModel(
      {this.id,
      this.title,
      this.description,
      this.beginDate,
      this.endDate,
      this.status,
      this.answerNum,
      this.imgUrls,
      this.headImgURls});

  QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    beginDate = json['beginDate'];
    endDate = json['endDate'];
    status = json['status'];
    answerNum = json['answerNum'];
    if (json['imgUrls'] != null) {
      imgUrls = [];
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgModel.fromJson(v));
      });
    } else
      imgUrls = [];
    if (json['headImgURls'] != null) {
      headImgURls = [];
      json['headImgURls'].forEach((v) {
        headImgURls.add(new ImgModel.fromJson(v));
      });
    } else
      headImgURls = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['beginDate'] = this.beginDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['answerNum'] = this.answerNum;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    if (this.headImgURls != null) {
      data['headImgURls'] = this.headImgURls.map((v) => v.toJson()).toList();
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
