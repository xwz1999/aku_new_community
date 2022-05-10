import 'package:aku_new_community/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';

class EventVotingModel {
  int? id;
  String? title;
  String? content;
  String? beginDate;
  String? endDate;
  int? status;
  List<ImgModel>? imgUrls;
  List<ImgModel>? headImgURls;
  bool? vote;
  bool? allowVote;

  DateTime? get beginDT => DateUtil.getDateTime(beginDate!);
  DateTime? get endDT => DateUtil.getDateTime(endDate!);

  EventVotingModel(
      {this.id,
      this.title,
      this.content,
      this.beginDate,
      this.endDate,
      this.status,
      this.imgUrls,
      this.headImgURls,
      this.vote,
      this.allowVote,});

  EventVotingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    beginDate = json['beginDate'];
    endDate = json['endDate'];
    status = json['status'];
    if (json['imgList'] != null) {
      imgUrls = [];
      json['imgList'].forEach((v) {
        imgUrls!.add(new ImgModel.fromJson(v));
      });
    } else
      imgUrls = [];
    if (json['headImgList'] != null) {
      headImgURls = [];
      json['headImgList'].forEach((v) {
        headImgURls!.add(new ImgModel.fromJson(v));
      });
    } else
      headImgURls = [];
    vote=json['vote'];
    allowVote=json['allowVote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['beginDate'] = this.beginDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    if (this.imgUrls != null) {
      data['imgList'] = this.imgUrls!.map((v) => v.toJson()).toList();
    }
    if (this.headImgURls != null) {
      data['headImgList'] = this.headImgURls!.map((v) => v.toJson()).toList();
    }
    data['vote'] = this.vote;
    data['allowVote'] = this.allowVote;
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
