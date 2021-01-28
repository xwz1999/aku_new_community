class MovingCompanyModel {
  List<AppMovingCompanyVoList> appMovingCompanyVoList;

  MovingCompanyModel({this.appMovingCompanyVoList});

  MovingCompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['appMovingCompanyVoList'] != null) {
      appMovingCompanyVoList = new List<AppMovingCompanyVoList>();
      json['appMovingCompanyVoList'].forEach((v) {
        appMovingCompanyVoList.add(new AppMovingCompanyVoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appMovingCompanyVoList != null) {
      data['appMovingCompanyVoList'] =
          this.appMovingCompanyVoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppMovingCompanyVoList {
  String name;
  String tel;

  AppMovingCompanyVoList({this.name, this.tel});

  AppMovingCompanyVoList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tel'] = this.tel;
    return data;
  }
}
