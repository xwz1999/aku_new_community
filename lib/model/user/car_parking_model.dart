import 'package:flustars/flustars.dart';

class CarParkingModel {
  String code;
  int type;
  String effectiveTimeEnd;
  DateTime get effectiveDate => DateUtil.getDateTime(effectiveTimeEnd);
  bool get outdated {
    DateTime now = DateTime.now();
    return effectiveDate.isAfter(now);
  }

  CarParkingModel({this.code, this.type, this.effectiveTimeEnd});

  CarParkingModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    type = json['type'];
    effectiveTimeEnd = json['effectiveTimeEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['type'] = this.type;
    data['effectiveTimeEnd'] = this.effectiveTimeEnd;
    return data;
  }
}
