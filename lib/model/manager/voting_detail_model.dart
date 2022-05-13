import 'package:common_utils/common_utils.dart';

import 'package:aku_new_community/model/common/img_model.dart';

class VotingDetailModel {
  int? id;
  String? title;
  String? content;
  int? status;
  int? totals;
  String? beginDate;
  String? endDate;
  List<ImgModel>? imgUrls;
  List<AppVoteCandidateVos>? appVoteCandidateVos;
  bool? vote;
  bool? allowVote;


  DateTime? get beginDT => DateUtil.getDateTime(beginDate!);

  DateTime? get endDT => DateUtil.getDateTime(endDate!);

  VotingDetailModel(
      {this.id,
      this.title,
      this.content,
      this.status,
      this.totals,
      this.beginDate,
      this.endDate,
      this.imgUrls,
      this.appVoteCandidateVos,
      this.vote,
      this.allowVote});

  VotingDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    status = json['status'];
    totals = json['totals'];
    beginDate = json['beginDate'];
    endDate = json['endDate'];
    if (json['imgList'] != null) {
      imgUrls = [];
      json['imgList'].forEach((v) {
        imgUrls!.add(new ImgModel.fromJson(v));
      });
    } else
      imgUrls = [];
    if (json['candidateVoList'] != null) {
      appVoteCandidateVos = [];
      json['candidateVoList'].forEach((v) {
        appVoteCandidateVos!.add(new AppVoteCandidateVos.fromJson(v));
      });
    }
    vote = json['vote'];
    allowVote = json['allowVote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['status'] = this.status;
    data['totals'] = this.totals;
    if (this.imgUrls != null) {
      data['imgList'] = this.imgUrls!.map((v) => v.toJson()).toList();
    }
    if (this.appVoteCandidateVos != null) {
      data['candidateVoList'] =
          this.appVoteCandidateVos!.map((v) => v.toJson()).toList();
    }
    data['vote']=this.vote;
    data['allowVote']=this.allowVote;
    return data;
  }
}

class ImgUrls {
  String? url;
  String? size;
  int? longs;
  int? paragraph;
  int? sort;

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
  int? id;
  String? name;
  int? total;
  List<ImgModel>? imgUrls;

  AppVoteCandidateVos({this.id, this.name, this.total, this.imgUrls});

  AppVoteCandidateVos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    total = json['total'];
    if (json['imgList'] != null) {
      imgUrls = [];
      json['imgList'].forEach((v) {
        imgUrls!.add(new ImgModel.fromJson(v));
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
      data['imgList'] = this.imgUrls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
