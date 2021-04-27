import 'package:aku_community/model/common/img_model.dart';

class ActivityPeopleModel {
  int? id;
  String? name;
  String? tel;
  List<ImgModel>? imgUrl;

  ActivityPeopleModel({this.id, this.name, this.tel, this.imgUrl});

  ActivityPeopleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tel = json['tel'];
    if (json['imgUrl'] != null) {
      imgUrl = [];
      json['imgUrl'].forEach((v) {
        imgUrl!.add(new ImgModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tel'] = this.tel;
    if (this.imgUrl != null) {
      data['imgUrl'] = this.imgUrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
