class ActivityPeopleModel {
  int id;
  String name;
  String tel;
  List<ImgUrl> imgUrl;

  ActivityPeopleModel({this.id, this.name, this.tel, this.imgUrl});

  ActivityPeopleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tel = json['tel'];
    if (json['imgUrl'] != null) {
      imgUrl = [];
      json['imgUrl'].forEach((v) {
        imgUrl.add(new ImgUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tel'] = this.tel;
    if (this.imgUrl != null) {
      data['imgUrl'] = this.imgUrl.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImgUrl {
  String url;
  String size;
  int longs;
  int paragraph;
  int sort;

  ImgUrl({this.url, this.size, this.longs, this.paragraph, this.sort});

  ImgUrl.fromJson(Map<String, dynamic> json) {
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
