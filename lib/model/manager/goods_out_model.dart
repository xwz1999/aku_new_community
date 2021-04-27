class GoodsOutModel {
  int? id;
  String? name;
  int? weight;
  String? expectedTime;
  int? approach;
  int? status;
  String? movingCompanyTel;
  List<ImgUrl>? imgUrl;

  GoodsOutModel(
      {this.id,
      this.name,
      this.weight,
      this.expectedTime,
      this.approach,
      this.status,
      this.movingCompanyTel,
      this.imgUrl});

  GoodsOutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    weight = json['weight'];
    expectedTime = json['expectedTime'];
    approach = json['approach'];
    status = json['status'];
    movingCompanyTel = json['movingCompanyTel'];
    if (json['imgUrl'] != null) {
      imgUrl = [];
      json['imgUrl'].forEach((v) {
        imgUrl!.add(new ImgUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['weight'] = this.weight;
    data['expectedTime'] = this.expectedTime;
    data['approach'] = this.approach;
    data['status'] = this.status;
    data['movingCompanyTel'] = this.movingCompanyTel;
    if (this.imgUrl != null) {
      data['imgUrl'] = this.imgUrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImgUrl {
  String? url;
  String? size;
  int? longs;
  int? paragraph;
  int? sort;

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
