class UserInfoModel {
  Data data;
  String message;
  bool status;

  UserInfoModel({this.data, this.message, this.status});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int id;
  List<String> imgUrls;
  String name;
  String nickName;
  String tel;
  int sex;
  String birthday;

  Data(
      {this.id,
      this.imgUrls,
      this.name,
      this.nickName,
      this.tel,
      this.sex,
      this.birthday});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgUrls = json['imgUrls'].cast<String>();
    name = json['name'];
    nickName = json['nickName'];
    tel = json['tel'];
    sex = json['sex'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imgUrls'] = this.imgUrls;
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    data['tel'] = this.tel;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    return data;
  }
}
