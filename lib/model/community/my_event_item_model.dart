import 'package:flustars/flustars.dart';

import 'package:akuCommunity/model/common/img_model.dart';

class MyEventItemModel {
  int id;
  String content;
  List<ImgModel> imgUrl;
  String createDate;

  String get firstImg {
    String img = '';
    if (imgUrl.isNotEmpty) img = imgUrl.first.url;
    return img;
  }

  DateTime get date => DateUtil.getDateTime(createDate);

  MyEventItemModel({this.id, this.content, this.imgUrl, this.createDate});

  MyEventItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    if (json['imgUrl'] != null) {
      imgUrl = [];
      json['imgUrl'].forEach((v) {
        imgUrl.add(new ImgModel.fromJson(v));
      });
    } else
      imgUrl = [];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    if (this.imgUrl != null) {
      data['imgUrl'] = this.imgUrl.map((v) => v.toJson()).toList();
    }
    data['createDate'] = this.createDate;
    return data;
  }
}
