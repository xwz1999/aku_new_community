class MineGoodsModel {
  int? id;
  String? name;
  int? code;
  String? beginDate;
  String? endDate;
  int? borrowDate;
  int? borrowStatus;

  MineGoodsModel(
      {this.id,
      this.name,
      this.code,
      this.beginDate,
      this.endDate,
      this.borrowDate,
      this.borrowStatus});

  MineGoodsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    beginDate = json['beginDate'];
    endDate = json['endDate'];
    borrowDate = json['borrowDate'];
    borrowStatus = json['borrowStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['beginDate'] = this.beginDate;
    data['endDate'] = this.endDate;
    data['borrowDate'] = this.borrowDate;
    data['borrowStatus'] = this.borrowStatus;
    return data;
  }
}
