class MessageCenterModel {
  String? commentTitle;
  int? sysCount;
  String? sysTitle;
  int? commentCount;

  MessageCenterModel.zero() {
    commentTitle = '';
    sysCount = 0;
    sysTitle = '';
    commentCount = 0;
  }

  MessageCenterModel(
      {this.commentTitle, this.sysCount, this.sysTitle, this.commentCount});

  MessageCenterModel.fromJson(Map<String, dynamic> json) {
    commentTitle = json['commentTitle'];
    sysCount = json['sysCount'];
    sysTitle = json['sysTitle'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentTitle'] = this.commentTitle;
    data['sysCount'] = this.sysCount;
    data['sysTitle'] = this.sysTitle;
    data['commentCount'] = this.commentCount;
    return data;
  }
}
