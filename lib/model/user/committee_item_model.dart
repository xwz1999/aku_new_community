class CommitteeItemModel {
  int id;
  int positionId;
  String name;
  int sexId;
  int age;
  int educationId;
  String roomName;
  String profession;
  String roomNumber;
  int unitNo;
  int estateNo;

  String get sexValue {
    if (sexId == 0 || sexId == null) return '未设置';
    if (sexId == 1) return '男';
    if (sexId == 2) return '女';
    return '未设置';
  }

  CommitteeItemModel(
      {this.id,
      this.positionId,
      this.name,
      this.sexId,
      this.age,
      this.educationId,
      this.roomName,
      this.profession,
      this.roomNumber,
      this.unitNo,
      this.estateNo});

  CommitteeItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positionId = json['positionId'];
    name = json['name'];
    sexId = json['sexId'];
    age = json['age'];
    educationId = json['educationId'];
    roomName = json['roomName'];
    profession = json['profession'];
    roomNumber = json['roomNumber'];
    unitNo = json['unitNo'];
    estateNo = json['estateNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['positionId'] = this.positionId;
    data['name'] = this.name;
    data['sexId'] = this.sexId;
    data['age'] = this.age;
    data['educationId'] = this.educationId;
    data['roomName'] = this.roomName;
    data['profession'] = this.profession;
    data['roomNumber'] = this.roomNumber;
    data['unitNo'] = this.unitNo;
    data['estateNo'] = this.estateNo;
    return data;
  }
}
