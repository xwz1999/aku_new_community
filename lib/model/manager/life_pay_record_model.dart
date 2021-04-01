class LifePayRecordModel {
  int id;
  String chargesTemplateDetailName;
  String roomName;
  String years;
  int paidPrice;
  String createDate;
  int payType;
  String code;

  LifePayRecordModel(
      {this.id,
      this.chargesTemplateDetailName,
      this.roomName,
      this.years,
      this.paidPrice,
      this.createDate,
      this.payType,
      this.code});

  LifePayRecordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chargesTemplateDetailName = json['chargesTemplateDetailName'];
    roomName = json['roomName'];
    years = json['years'];
    paidPrice = json['paidPrice'];
    createDate = json['createDate'];
    payType = json['payType'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chargesTemplateDetailName'] = this.chargesTemplateDetailName;
    data['roomName'] = this.roomName;
    data['years'] = this.years;
    data['paidPrice'] = this.paidPrice;
    data['createDate'] = this.createDate;
    data['payType'] = this.payType;
    data['code'] = this.code;
    return data;
  }
}
