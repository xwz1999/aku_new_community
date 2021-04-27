import 'package:aku_community/model/common/img_model.dart';

class VotingDetailModel {
  int id;
  String title;
  String content;
  int status;
  int totals;
  List<ImgModel> imgUrls;
  List<AppVoteCandidateVos> appVoteCandidateVos;

  VotingDetailModel(
      {this.id,
      this.title,
      this.content,
      this.status,
      this.totals,
      this.imgUrls,
      this.appVoteCandidateVos});

  VotingDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    status = json['status'];
    totals = json['totals'];
    if (json['imgUrls'] != null) {
      imgUrls = [];
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgModel.fromJson(v));
      });
    } else
      imgUrls = [];
    if (json['appVoteCandidateVos'] != null) {
      appVoteCandidateVos = [];
      json['appVoteCandidateVos'].forEach((v) {
        appVoteCandidateVos.add(new AppVoteCandidateVos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['status'] = this.status;
    data['totals'] = this.totals;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    if (this.appVoteCandidateVos != null) {
      data['appVoteCandidateVos'] =
          this.appVoteCandidateVos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImgUrls {
  String url;
  String size;
  int longs;
  int paragraph;
  int sort;

  ImgUrls({this.url, this.size, this.longs, this.paragraph, this.sort});

  ImgUrls.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    size = json['size'];
    longs = json['longs'];
    paragraph = json['paragraph'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['size'] = this.size;
    data['longs'] = this.longs;
    data['paragraph'] = this.paragraph;
    data['sort'] = this.sort;
    return data;
  }
}

class AppVoteCandidateVos {
  int id;
  String name;
  int total;
  List<ImgModel> imgUrls;

  AppVoteCandidateVos({this.id, this.name, this.total, this.imgUrls});

  AppVoteCandidateVos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    total = json['total'];
    if (json['imgUrls'] != null) {
      imgUrls = [];
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgModel.fromJson(v));
      });
    } else
      imgUrls = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total'] = this.total;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
