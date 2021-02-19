class MessageCenterModel {
  int sysCount;
  String sysTitle;

  MessageCenterModel.zero() {
    sysCount = 0;
    sysTitle = '';
  }

  MessageCenterModel({this.sysCount, this.sysTitle});

  MessageCenterModel.fromJson(Map<String, dynamic> json) {
    sysCount = json['sysCount'];
    sysTitle = json['sysTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sysCount'] = this.sysCount;
    data['sysTitle'] = this.sysTitle;
    return data;
  }
}
