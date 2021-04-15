import 'package:akuCommunity/model/common/img_model.dart';

class ArticleBorrowDetailModel {
  int id;
  String name;
  String code;
  int status;
  List<ImgModel> imgList;
  String get borrowStatus {
    switch (this.status) {
      case 1:
        return '正常';
        break;
      case 2:
        return '破损';
      case 3:
        return '丢失';
      default:
        return '';
    }
  }

  ArticleBorrowDetailModel(
      {this.id, this.name, this.code, this.status, this.imgList});

  ArticleBorrowDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    status = json['status'];
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
    data['status'] = this.status;
    if (this.imgList != null) {
      data['imgList'] = this.imgList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
