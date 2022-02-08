import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';

class SurroundingEnterprisesModel {
  int? id;
  String? name;
  String? content;
  String? releaseDate;
  List<ImgModel>? imgList;

  DateTime? get getReleaseDate => DateUtil.getDateTime(releaseDate!);

  SurroundingEnterprisesModel(
      {this.id, this.name, this.content, this.releaseDate, this.imgList});

  SurroundingEnterprisesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    releaseDate = json['releaseDate'];
    if (json['imgList'] != null) {
      imgList = [];
      json['imgList'].forEach((v) {
        imgList!.add(new ImgModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['releaseDate'] = this.releaseDate;
    if (this.imgList != null) {
      data['imgList'] = this.imgList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
