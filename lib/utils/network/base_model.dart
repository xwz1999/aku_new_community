class BaseModel {
  int code;
  String message;
  bool status;
  dynamic data;
  BaseModel({
    this.code,
    this.message,
    this.data,
    this.status,
  });

  BaseModel.err({this.message = '未知错误', this.status = false});

  BaseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    data = json['data'] ?? null;
    status = json['status'] ?? false;
  }
}
