import 'package:akuCommunity/model/common/img_model.dart';

class ArticleBorrowModel {
  int id;
  String name;
  int quantity;
  List<ImgModel> imgUrls;

  ArticleBorrowModel({this.id, this.name, this.quantity, this.imgUrls});

  ArticleBorrowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    if (json['imgUrls'] != null) {
      imgUrls = [];
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
