import 'package:common_utils/common_utils.dart';

class VisitorListItemModel {
  int? id;
  int? estateId;
  String? roomName;
  String? name;
  String? tel;
  int? sex;
  String? carNumber;
  String? visitDateStart;
  String? visitDateEnd;
  int? status;
  int? createId;
  String? createDate;

  DateTime? get date => DateUtil.getDateTime(createDate ?? '');

  bool get drive => carNumber != null;

  VisitorListItemModel(
      {this.id,
      this.estateId,
      this.roomName,
      this.name,
      this.tel,
      this.sex,
      this.carNumber,
      this.visitDateStart,
      this.visitDateEnd,
      this.status,
      this.createId,
      this.createDate});

  VisitorListItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estateId = json['estateId'];
    roomName = json['roomName'];
    name = json['name'];
    tel = json['tel'];
    sex = json['sex'];
    carNumber = json['carNumber'];
    visitDateStart = json['visitDateStart'];
    visitDateEnd = json['visitDateEnd'];
    status = json['status'];
    createId = json['createId'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['estateId'] = this.estateId;
    data['roomName'] = this.roomName;
    data['name'] = this.name;
    data['tel'] = this.tel;
    data['sex'] = this.sex;
    data['carNumber'] = this.carNumber;
    data['visitDateStart'] = this.visitDateStart;
    data['visitDateEnd'] = this.visitDateEnd;
    data['status'] = this.status;
    data['createId'] = this.createId;
    data['createDate'] = this.createDate;
    return data;
  }
}
