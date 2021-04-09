class AkuShopClassModel {
  int cid;
  String mainName;
  List<Data> data;

  AkuShopClassModel({this.cid, this.mainName, this.data});

  AkuShopClassModel.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    mainName = json['main_name'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['main_name'] = this.mainName;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String nextName;
  List<Info> info;

  Data({this.nextName, this.info});

  Data.fromJson(Map<String, dynamic> json) {
    nextName = json['next_name'];
    if (json['info'] != null) {
      info = [];
      json['info'].forEach((v) {
        info.add(new Info.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_name'] = this.nextName;
    if (this.info != null) {
      data['info'] = this.info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  String sonName;
  String imgurl;

  Info({this.sonName, this.imgurl});

  Info.fromJson(Map<String, dynamic> json) {
    sonName = json['son_name'];
    imgurl = json['imgurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['son_name'] = this.sonName;
    data['imgurl'] = this.imgurl;
    return data;
  }
}
