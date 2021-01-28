// Package imports:
import 'package:common_utils/common_utils.dart';

// Project imports:
import 'package:akuCommunity/model/common/img_model.dart';

class ActivityItemModel {
  int id;
  String title;
  String location;
  int status;
  String registrationStartTime;
  String registrationEndTime;
  List<ImgModel> imgUrls;
  List<ImgModel> headImgURls;

  DateTime get begin => DateUtil.getDateTime(registrationStartTime);
  DateTime get end => DateUtil.getDateTime(registrationEndTime);

  ActivityItemModel(
      {this.id,
      this.title,
      this.location,
      this.status,
      this.registrationStartTime,
      this.registrationEndTime,
      this.imgUrls,
      this.headImgURls});

  ActivityItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    location = json['location'];
    status = json['status'];
    registrationStartTime = json['registrationStartTime'];
    registrationEndTime = json['registrationEndTime'];
    if (json['imgUrls'] != null) {
      imgUrls = new List<ImgModel>();
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgModel.fromJson(v));
      });
    } else {
      imgUrls = [];
    }
    if (json['headImgURls'] != null) {
      headImgURls = new List<ImgModel>();
      json['headImgURls'].forEach((v) {
        headImgURls.add(new ImgModel.fromJson(v));
      });
    } else {
      headImgURls = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['location'] = this.location;
    data['status'] = this.status;
    data['registrationStartTime'] = this.registrationStartTime;
    data['registrationEndTime'] = this.registrationEndTime;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    if (this.headImgURls != null) {
      data['headImgURls'] = this.headImgURls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
