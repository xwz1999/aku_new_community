import 'package:aku_new_community/model/common/img_model.dart';
import 'package:flustars/flustars.dart';

class HouseIntroduceModel {
  int? id;
  String? name;
  String? content;
  String? releaseDate;
  List<ImgModel>? imgUrls;

  DateTime? get getReleaseDate => DateUtil.getDateTime(releaseDate!);

  HouseIntroduceModel(
      {this.id, this.name, this.content, this.releaseDate, this.imgUrls});

  HouseIntroduceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    releaseDate = json['releaseDate'];
    if (json['imgUrls'] != null) {
      imgUrls =
          (json['imgUrls'] as List).map((e) => ImgModel.fromJson(e)).toList();
    } else
      imgUrls = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['releaseDate'] = this.releaseDate;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
