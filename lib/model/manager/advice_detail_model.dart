import 'package:flustars/flustars.dart';

import 'package:akuCommunity/model/common/img_model.dart';

class AdviceDetailModel {
  AppAdviceDetailVo appAdviceDetailVo;

  AdviceDetailModel({this.appAdviceDetailVo});

  AdviceDetailModel.fromJson(Map<String, dynamic> json) {
    appAdviceDetailVo = json['appAdviceDetailVo'] != null
        ? new AppAdviceDetailVo.fromJson(json['appAdviceDetailVo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appAdviceDetailVo != null) {
      data['appAdviceDetailVo'] = this.appAdviceDetailVo.toJson();
    }
    return data;
  }
}

class AppAdviceDetailVo {
  AppAdviceVo appAdviceVo;
  List<AppAdviceContentVos> appAdviceContentVos;

  AppAdviceDetailVo({this.appAdviceVo, this.appAdviceContentVos});

  AppAdviceDetailVo.fromJson(Map<String, dynamic> json) {
    appAdviceVo = json['appAdviceVo'] != null
        ? new AppAdviceVo.fromJson(json['appAdviceVo'])
        : null;
    if (json['appAdviceContentVos'] != null) {
      appAdviceContentVos = [];
      json['appAdviceContentVos'].forEach((v) {
        appAdviceContentVos.add(new AppAdviceContentVos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appAdviceVo != null) {
      data['appAdviceVo'] = this.appAdviceVo.toJson();
    }
    if (this.appAdviceContentVos != null) {
      data['appAdviceContentVos'] =
          this.appAdviceContentVos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppAdviceVo {
  int id;
  int type;
  int status;
  String content;
  String createDate;
  List<ImgModel> imgUrls;

  DateTime get date => DateUtil.getDateTime(createDate);

  AppAdviceVo(
      {this.id,
      this.type,
      this.status,
      this.content,
      this.createDate,
      this.imgUrls});

  AppAdviceVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    content = json['content'];
    createDate = json['createDate'];
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
    data['content'] = this.content;
    data['createDate'] = this.createDate;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppAdviceContentVos {
  int id;
  int createUserType;
  String content;
  String createDate;
  int parentId;

  AppAdviceContentVos(
      {this.id,
      this.createUserType,
      this.content,
      this.createDate,
      this.parentId});

  DateTime get date => DateUtil.getDateTime(createDate);

  AppAdviceContentVos.fromJson(Map<String, dynamic> json) {
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
