class EstatePaymentModel {
  int id;
  String roomName;
  int status;

  EstatePaymentModel({this.id, this.roomName, this.status});

  EstatePaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomName = json['roomName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomName'] = this.roomName;
    data['status'] = this.status;
    return data;
  }
}
