class EventVotingModel {
  int id;
  String title;
  String content;
  String beginDate;
  String endDate;
  int status;
  List<String> imgUrls;
  List<HeadImgURls> headImgURls;

  EventVotingModel(
      {this.id,
      this.title,
      this.content,
      this.beginDate,
      this.endDate,
      this.status,
      this.imgUrls,
      this.headImgURls});

  EventVotingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    beginDate = json['beginDate'];
    endDate = json['endDate'];
    status = json['status'];
    imgUrls = json['imgUrls'].cast<String>();
    if (json['headImgURls'] != null) {
      headImgURls = new List<HeadImgURls>();
      json['headImgURls'].forEach((v) {
        headImgURls.add(new HeadImgURls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['beginDate'] = this.beginDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['imgUrls'] = this.imgUrls;
    if (this.headImgURls != null) {
      data['headImgURls'] = this.headImgURls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HeadImgURls {
  String url;
  String size;
  int longs;
  int paragraph;
  int sort;

  HeadImgURls({this.url, this.size, this.longs, this.paragraph, this.sort});

  HeadImgURls.fromJson(Map<String, dynamic> json) {
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
