import 'package:common_utils/common_utils.dart';

import 'package:aku_new_community/model/common/img_model.dart';

class AdviceDetailModel {
  AppAdviceFBIDetailVo? appAdviceFBIDetailVo;
  List<AppAdviceFBIContentVos>? appAdviceFBIContentVos;

  AdviceDetailModel({this.appAdviceFBIDetailVo, this.appAdviceFBIContentVos});

  AdviceDetailModel.fromJson(Map<String, dynamic> json) {
    appAdviceFBIDetailVo = json['appAdviceFBIDetailVo'] != null
        ? new AppAdviceFBIDetailVo.fromJson(json['appAdviceFBIDetailVo'])
        : null;
    if (json['appAdviceFBIContentVos'] != null) {
      appAdviceFBIContentVos = [];
      json['appAdviceFBIContentVos'].forEach((v) {
        appAdviceFBIContentVos!.add(new AppAdviceFBIContentVos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appAdviceFBIDetailVo != null) {
      data['appAdviceFBIDetailVo'] = this.appAdviceFBIDetailVo!.toJson();
    }
    if (this.appAdviceFBIContentVos != null) {
      data['appAdviceFBIContentVos'] =
          this.appAdviceFBIContentVos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppAdviceFBIDetailVo {
  int? id;
  int? type;
  int? status;
  String? content;
  int? score;
  String? createDate;
  List<ImgModel>? imgUrls;

  DateTime? get date => DateUtil.getDateTime(createDate!);

  AppAdviceFBIDetailVo(
      {this.id,
      this.type,
      this.status,
      this.content,
      this.score,
      this.createDate,
      this.imgUrls});

  AppAdviceFBIDetailVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    content = json['content'];
    score = json['score'];
    createDate = json['createDate'];
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
    data['type'] = this.type;
    data['status'] = this.status;
    data['content'] = this.content;
    data['score'] = this.score;
    data['createDate'] = this.createDate;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppAdviceFBIContentVos {
  int? id;
  int? createUserType;
  String? content;
  String? createDate;
  int? parentId;

  AppAdviceFBIContentVos(
      {this.id,
      this.createUserType,
      this.content,
      this.createDate,
      this.parentId});

  DateTime? get date => DateUtil.getDateTime(createDate!);

  AppAdviceFBIContentVos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createUserType = json['createUserType'];
    content = json['content'];
    createDate = json['createDate'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createUserType'] = this.createUserType;
    data['content'] = this.content;
    data['createDate'] = this.createDate;
    data['parentId'] = this.parentId;
    return data;
  }
}
