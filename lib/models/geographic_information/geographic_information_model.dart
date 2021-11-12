import 'package:aku_community/model/common/img_model.dart';
import 'package:flustars/flustars.dart';

class GeographicInformationModel {
  int? id;
  String? name;
  String? content;
  String? createDate;
  List<ImgModel>? imgUrls;

  DateTime? get getCreateDate => DateUtil.getDateTime(createDate!);

  GeographicInformationModel(
      {this.id, this.name, this.content, this.createDate, this.imgUrls});

  GeographicInformationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    createDate = json['createDate'];
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
    data['createDate'] = this.createDate;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory GeographicInformationModel.init() =>
      GeographicInformationModel(id: -1, name: '', content: '', createDate: '');

}
