import 'package:aku_new_community/model/common/img_model.dart';

class ArticleReturnListModel {
  int? id;
  String? name;
  String? code;
  String? beginDate;
  int? borrowTime;
  List<ImgModel>? imgList;

  String get paraseBorrowTime {
    if (this.borrowTime! > 24) {
      return '${this.borrowTime! ~/ 24}天${this.borrowTime! % 24}小时';
    } else {
      return '${this.borrowTime}小时';
    }
  }

  ArticleReturnListModel(
      {this.id,
      this.name,
      this.code,
      this.beginDate,
      this.borrowTime,
      this.imgList});

  ArticleReturnListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    beginDate = json['beginDate'];
    borrowTime = json['borrowTime'];
    if (json['imgList'] != null) {
      imgList = [];
      json['imgList'].forEach((v) {
        imgList!.add(new ImgModel.fromJson(v));
      });
    }
  }

  factory ArticleReturnListModel.fail() => ArticleReturnListModel(
      id: -1, name: '', code: '', beginDate: '', borrowTime: 0, imgList: []);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['beginDate'] = this.beginDate;
    data['borrowTime'] = this.borrowTime;
    if (this.imgList != null) {
      data['imgList'] = this.imgList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
