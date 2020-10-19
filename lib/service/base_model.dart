class BaseModel {
  int code;
  dynamic result;
  String message;

  BaseModel({this.code, this.result, this.message});

  BaseModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'] != null ? json['Code'] : json['code'];
    result = json['Result'] != null ? json['Result'] : json['data'];
    message = json['Message'] != null ? json['Message'] : json['msg'];
  }
}
