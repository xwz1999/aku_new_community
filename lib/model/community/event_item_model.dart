import 'package:akuCommunity/model/common/img_model.dart';
import 'package:common_utils/common_utils.dart';

class EventItemModel {
  int id;
  int createId;
  int isComment;
  int isLike;
  String createName;
  String content;
  String gambitTitle;
  String createDate;
  List<LikeNames> likeNames;
  List<ImgModel> imgUrls;
  List<ImgModel> headSculptureImgUrl;
  List<GambitThemeCommentVoList> gambitThemeCommentVoList;
  DateTime get date => DateUtil.getDateTime(createDate);
  EventItemModel(
      {this.id,
      this.createId,
      this.isComment,
      this.isLike,
      this.createName,
      this.content,
      this.gambitTitle,
      this.createDate,
      this.likeNames,
      this.imgUrls,
      this.headSculptureImgUrl,
      this.gambitThemeCommentVoList});

  EventItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createId = json['createId'];
    isComment = json['isComment'];
    isLike = json['isLike'];
    createName = json['createName'];
    content = json['content'];
    gambitTitle = json['gambitTitle'];
    createDate = json['createDate'];
    if (json['likeNames'] != null) {
      likeNames = new List<LikeNames>();
      json['likeNames'].forEach((v) {
        likeNames.add(new LikeNames.fromJson(v));
      });
    }
    if (json['imgUrls'] != null) {
      imgUrls = new List<ImgModel>();
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgModel.fromJson(v));
      });
    } else
      imgUrls = [];
    if (json['headSculptureImgUrl'] != null) {
      headSculptureImgUrl = new List<ImgModel>();
      json['headSculptureImgUrl'].forEach((v) {
        headSculptureImgUrl.add(new ImgModel.fromJson(v));
      });
    } else
      headSculptureImgUrl = [];
    if (json['gambitThemeCommentVoList'] != null) {
      gambitThemeCommentVoList = new List<GambitThemeCommentVoList>();
      json['gambitThemeCommentVoList'].forEach((v) {
        gambitThemeCommentVoList.add(new GambitThemeCommentVoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createId'] = this.createId;
    data['isComment'] = this.isComment;
    data['isLike'] = this.isLike;
    data['createName'] = this.createName;
    data['content'] = this.content;
    data['gambitTitle'] = this.gambitTitle;
    data['createDate'] = this.createDate;
    if (this.likeNames != null) {
      data['likeNames'] = this.likeNames.map((v) => v.toJson()).toList();
    }
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    if (this.headSculptureImgUrl != null) {
      data['headSculptureImgUrl'] =
          this.headSculptureImgUrl.map((v) => v.toJson()).toList();
    }
    if (this.gambitThemeCommentVoList != null) {
      data['gambitThemeCommentVoList'] =
          this.gambitThemeCommentVoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikeNames {
  int id;
  String name;

  LikeNames({this.id, this.name});

  LikeNames.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class GambitThemeCommentVoList {
  int id;
  String parentName;
  String content;
  String createName;
  String createDate;

  GambitThemeCommentVoList(
      {this.id,
      this.parentName,
      this.content,
      this.createName,
      this.createDate});

  GambitThemeCommentVoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentName = json['parentName'];
    content = json['content'];
    createName = json['createName'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentName'] = this.parentName;
    data['content'] = this.content;
    data['createName'] = this.createName;
    data['createDate'] = this.createDate;
    return data;
  }
}
