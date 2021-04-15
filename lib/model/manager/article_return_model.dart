import 'package:akuCommunity/model/common/img_model.dart';

class ArticleReturnModel {
  int id;
  String name;
  String code;
  String beginDate;
  int borrowTime;
  List<ImgModel> imgList;

  ArticleReturnModel(
      {this.id,
      this.name,
      this.code,
      this.beginDate,
      this.borrowTime,
      this.imgList});

  ArticleReturnModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    beginDate = json['beginDate'];
    borrowTime = json['borrowTime'];
    if (json['imgList'] != null) {
      imgList = new List<ImgModel>();
      json['imgList'].forEach((v) {
        imgList.add(new ImgModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['beginDate'] = this.beginDate;
    data['borrowTime'] = this.borrowTime;
    if (this.imgList != null) {
      data['imgList'] = this.imgList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImgList {
  String url;
  String size;
  int longs;
  int paragraph;
  int sort;

  ImgList({this.url, this.size, this.longs, this.paragraph, this.sort});

  ImgList.fromJson(Map<String, dynamic> json) {
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
