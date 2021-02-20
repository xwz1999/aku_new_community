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
  List<ImgUrls> imgUrls;

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
      this.imgUrls});

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
      imgUrls = new List<ImgUrls>();
      json['imgUrls'].forEach((v) {
        imgUrls.add(new ImgUrls.fromJson(v));
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
