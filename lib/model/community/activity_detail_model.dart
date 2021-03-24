import 'package:flustars/flustars.dart';

import 'package:akuCommunity/model/common/img_model.dart';

class ActivityDetailModel {
  int id;
  String title;
  String content;
  String location;
  String activityStartTime;
  String activityEndTime;
  String registrationEndTime;
  int countRegistration;
  List<ImgModel> imgUrls;
  List<ImgModel> headImgURls;

  DateTime get startDate => DateUtil.getDateTime(activityStartTime);
  DateTime get endDate => DateUtil.getDateTime(activityEndTime);
  DateTime get registEndDate => DateUtil.getDateTime(registrationEndTime);

  ActivityDetailModel(
      {this.id,
      this.title,
      this.content,
      this.location,
      this.activityStartTime,
      this.activityEndTime,
      this.registrationEndTime,
      this.countRegistration,
      this.imgUrls,
      this.headImgURls});

  ActivityDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    location = json['location'];
    activityStartTime = json['activityStartTime'];
    activityEndTime = json['activityEndTime'];
    registrationEndTime = json['registrationEndTime'];
    countRegistration = json['countRegistration'];
    if (json['imgUrls'] != null) {
      imgUrls = new List<ImgModel>();
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgModel.fromJson(v));
      });
    } else
      imgUrls = [];
    if (json['headImgURls'] != null) {
      headImgURls = new List<ImgModel>();
      json['headImgURls'].forEach((v) {
        headImgURls.add(new ImgModel.fromJson(v));
      });
    } else
      headImgURls = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['location'] = this.location;
    data['activityStartTime'] = this.activityStartTime;
    data['activityEndTime'] = this.activityEndTime;
    data['registrationEndTime'] = this.registrationEndTime;
    data['countRegistration'] = this.countRegistration;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    if (this.headImgURls != null) {
      data['headImgURls'] = this.headImgURls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
