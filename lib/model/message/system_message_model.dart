class SystemMessageModel {
  int id;
  String content;
  int status;
  String title;

  SystemMessageModel({this.id, this.content, this.status, this.title});

  SystemMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    status = json['status'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }
}
