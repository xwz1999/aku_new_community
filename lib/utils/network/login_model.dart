class LoginModel {
  String message;
  String token;
  bool status;

  LoginModel({this.message, this.token, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['status'] = this.status;
    return data;
  }
}
