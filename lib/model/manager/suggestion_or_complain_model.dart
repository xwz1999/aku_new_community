import 'package:common_utils/common_utils.dart';

import 'package:aku_new_community/model/common/img_model.dart';

class SuggestionOrComplainModel {
  int? id;
  int? type;
  int? status;
  String? content;
  int? score;
  DateTime? createDate;
  List<ImgModel>? imgUrls;

  SuggestionOrComplainModel(
      {this.id,
      this.type,
      this.status,
      this.content,
      this.score,
      this.createDate,
      this.imgUrls});

  SuggestionOrComplainModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    content = json['content'];
    score = json['score'];
    createDate = DateUtil.getDateTime(json['createDate']);
    if (json['imgUrls'] != null) {
      imgUrls = [];
      json['imgUrls'].forEach((v) {
        imgUrls!.add(new ImgModel.fromJson(v));
      });
    }
  }
}

class imgUrls {
  String? url;
  String? size;
  int? longs;
  int? paragraph;
  int? sort;

  imgUrls({this.url, this.size, this.longs, this.paragraph, this.sort});

  imgUrls.fromJson(Map<String, dynamic> json) {
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
