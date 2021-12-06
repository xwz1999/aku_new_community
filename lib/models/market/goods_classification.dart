import 'package:aku_new_community/model/common/img_model.dart';

class GoodsClassification {
  int? id;
  String? name;
  List<ImgModel>? imgUrls;

  GoodsClassification({this.id, this.name, this.imgUrls});

  GoodsClassification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['imgUrls'] != null) {
      imgUrls = [];
      json['imgUrls'].forEach((v) {
        imgUrls!.add(new ImgModel.fromJson(v));
      });
    } else {
      imgUrls = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imgUrls'] = this.imgUrls;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
