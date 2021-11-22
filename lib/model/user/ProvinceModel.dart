
class ProvinceModel {
  int? id;
  String? name;
  List<City>? cityList;

  ProvinceModel({this.id, this.name, this.cityList});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    if (json['cityList'] != null) {
      cityList = (json['cityList'] as List).map((e) => City.fromJson(e)).toList();

    }else
      cityList = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.cityList != null) {
      data['cityList'] = this.cityList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;
  List<District>? districts;

  City({this.id, this.name, this.districts});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['districts'] != null) {
      districts = (json['districts'] as List).map((e) => District.fromJson(e)).toList();

    }else
      districts = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.districts != null) {
      data['cityList'] = this.districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  int? id;
  String? name;

  District({this.id, this.name});

  District.fromJson(Map<String, dynamic> json) {
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