class GoodsOutModel {
  int id;
  String name;
  int weight;
  String expectedTime;
  int approach;
  int status;
  String movingCompanyTel;

  GoodsOutModel(
      {this.id,
      this.name,
      this.weight,
      this.expectedTime,
      this.approach,
      this.status,
      this.movingCompanyTel});

  GoodsOutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    weight = json['weight'];
    expectedTime = json['expectedTime'];
    approach = json['approach'];
    status = json['status'];
    movingCompanyTel = json['movingCompanyTel'];
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
    return data;
  }
}
