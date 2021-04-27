class BaseFileModel {
  String? message;
  String? url;
  bool? status;
  BaseFileModel({
    this.message,
    this.url,
    this.status,
  });

  BaseFileModel.err(
      {this.message = '未知错误', this.url = '', this.status = false});

  BaseFileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    url = json['url'] ?? null;
    status = json['status'] ?? false;
  }
}
