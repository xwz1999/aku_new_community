class UserInfoModel {
  int id;
  List<String> imgUrls;
  String name;
  String nickName;
  String tel;
  int sex;
  String birthday;

  UserInfoModel(
      {this.id,
      this.imgUrls,
      this.name,
      this.nickName,
      this.tel,
      this.sex,
      this.birthday});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
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
