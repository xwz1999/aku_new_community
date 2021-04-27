import 'package:aku_community/model/common/img_model.dart';

class CommentMessageModel {
  int id;
  int gambitThemeId;
  String respondentName;
  int type;
  String content;
  int receiverAccount;
  int sendStatus;
  String createName;
  String createDate;
  List<ImgModel> imgUrls;
  List<ImgModel> headSculpture;

  CommentMessageModel(
      {this.id,
      this.gambitThemeId,
      this.respondentName,
      this.type,
      this.content,
      this.receiverAccount,
      this.sendStatus,
      this.createName,
      this.createDate,
      this.imgUrls,
      this.headSculpture});

  CommentMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gambitThemeId = json['gambitThemeId'];
    respondentName = json['respondentName'];
    type = json['type'];
    content = json['content'];
    receiverAccount = json['receiverAccount'];
    sendStatus = json['sendStatus'];
    createName = json['createName'];
    createDate = json['createDate'];
    if (json['imgUrls'] != null) {
      imgUrls = [];
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgModel.fromJson(v));
      });
    }
    if (json['headSculpture'] != null) {
      headSculpture = [];
      json['headSculpture'].forEach((v) {
        headSculpture.add(new ImgModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gambitThemeId'] = this.gambitThemeId;
    data['respondentName'] = this.respondentName;
    data['type'] = this.type;
    data['content'] = this.content;
    data['receiverAccount'] = this.receiverAccount;
    data['sendStatus'] = this.sendStatus;
    data['createName'] = this.createName;
    data['createDate'] = this.createDate;
    if (this.imgUrls != null) {
      data['imgUrls'] = this.imgUrls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
