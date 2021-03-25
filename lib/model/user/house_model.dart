import 'package:flustars/flustars.dart';

class HouseModel {
  int id;
  String roomName;
  int status;
  String effectiveTimeStart;
  String effectiveTimeEnd;

  DateTime get effectiveStartDate => DateUtil.getDateTime(effectiveTimeStart);
  DateTime get effectiveEndDate => DateUtil.getDateTime(effectiveTimeEnd);

  HouseModel(
      {this.id,
      this.roomName,
      this.status,
      this.effectiveTimeStart,
      this.effectiveTimeEnd});

  HouseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomName = json['roomName'];
    status = json['status'];
    effectiveTimeStart = json['effectiveTimeStart'];
    effectiveTimeEnd = json['effectiveTimeEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomName'] = this.roomName;
    data['status'] = this.status;
    data['effectiveTimeStart'] = this.effectiveTimeStart;
    data['effectiveTimeEnd'] = this.effectiveTimeEnd;
    return data;
  }
}
