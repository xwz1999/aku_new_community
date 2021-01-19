class ConvenientPhoneModel {
  int id;
  String name;
  String tel;

  ConvenientPhoneModel({this.id, this.name, this.tel});

  ConvenientPhoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tel'] = this.tel;
    return data;
  }
}
