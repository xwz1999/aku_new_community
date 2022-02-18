import 'package:common_utils/common_utils.dart';

import 'package:aku_new_community/model/common/img_model.dart';

class BoardItemModel {
  int? id;
  String? title;
  String? releaseTime;
  List<ImgModel>? imgUrls;

  DateTime? get releaseDate => DateUtil.getDateTime(releaseTime!);

  BoardItemModel({this.id, this.title, this.releaseTime, this.imgUrls});

  BoardItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
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
    data['releaseTime'] = this.releaseTime;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
