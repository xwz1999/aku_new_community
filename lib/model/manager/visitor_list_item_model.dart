import 'package:flustars/flustars.dart';

class VisitorListItemModel {
  int? id;
  int? accessCode;
  int? visitorStatus;
  String? name;
  int? isDrive;
  String? carNum;
  String? effectiveTime;

  DateTime? get date => DateUtil.getDateTime(effectiveTime!);
  bool get drive => isDrive == 1;

  VisitorListItemModel(
      {this.id,
      this.accessCode,
      this.visitorStatus,
      this.name,
      this.isDrive,
      this.carNum,
      this.effectiveTime});

  VisitorListItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessCode = json['accessCode'];
    visitorStatus = json['visitorStatus'];
    name = json['name'];
    isDrive = json['isDrive'];
    carNum = json['carNum'];
    effectiveTime = json['effectiveTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accessCode'] = this.accessCode;
    data['visitorStatus'] = this.visitorStatus;
    data['name'] = this.name;
    data['isDrive'] = this.isDrive;
    data['carNum'] = this.carNum;
    data['effectiveTime'] = this.effectiveTime;
    return data;
  }
}
