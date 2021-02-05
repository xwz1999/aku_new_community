// Project imports:
import 'package:akuCommunity/model/common/img_model.dart';

class CommunityTopicModel {
  int id;
  String title;
  String summary;
  String content;
  List<ImgModel> imgUrl;
  int activityNum;

  String get firstImg {
    if (imgUrl.isEmpty)
      return '';
    else
      return imgUrl.first.url;
  }

  CommunityTopicModel(
      {this.id,
      this.title,
      this.summary,
      this.content,
      this.imgUrl,
      this.activityNum});

  CommunityTopicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    summary = json['summary'];
    content = json['content'];
    if (json['imgUrl'] != null) {
      imgUrl = new List<ImgModel>();
      json['imgUrl'].forEach((v) {
        imgUrl.add(new ImgModel.fromJson(v));
      });
    } else
      imgUrl = [];
    activityNum = json['activityNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['content'] = this.content;
    if (this.imgUrl != null) {
      data['imgUrl'] = this.imgUrl.map((v) => v.toJson()).toList();
    }
    data['activityNum'] = this.activityNum;
    return data;
  }
}
