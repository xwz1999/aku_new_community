import 'package:aku_community/model/common/img_model.dart';

class FixedSubmitModel {
  int id;
  int type;
  int status;
  String reportDetail;
  List<ImgModel> imgUrls;

  FixedSubmitModel(
      {this.id, this.type, this.status, this.reportDetail, this.imgUrls});

  FixedSubmitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    reportDetail = json['reportDetail'];
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
    data['type'] = this.type;
    data['status'] = this.status;
    data['reportDetail'] = this.reportDetail;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
