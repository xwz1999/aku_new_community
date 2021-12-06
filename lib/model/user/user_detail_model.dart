class UserDetailModel {
  int? id;
  String? name;
  int? type;
  String? tel;
  int? idType;
  String? idNumber;
  String? pwd;
  String? confuse;
  String? email;
  int? createId;
  String? createDate;
  String? identity;
  int? roomStatus;
  String? nickName;
  List<String>? estateNames;
  int? nowEstateExamineId;

  UserDetailModel(
      {this.id,
      this.name,
      this.type,
      this.tel,
      this.idType,
      this.idNumber,
      this.pwd,
      this.confuse,
      this.email,
      this.createId,
      this.createDate,
      this.identity,
      this.roomStatus,
      this.nickName,
      this.estateNames,
      this.nowEstateExamineId});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    tel = json['tel'];
    idType = json['idType'];
    idNumber = json['idNumber'];
    pwd = json['pwd'];
    confuse = json['confuse'];
    email = json['email'];
    createId = json['createId'];
    createDate = json['createDate'];
    identity = json['identity'];
    roomStatus = json['roomStatus'];
    nickName = json['nickName'];
    if (json['estateNames'] != null)
      estateNames = json['estateNames'].cast<String>();
    else
      estateNames = [];
    if (json['estateNames'] == null) {
      estateNames = [];
    }
    nowEstateExamineId = json['nowEstateExamineId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['tel'] = this.tel;
    data['idType'] = this.idType;
    data['idNumber'] = this.idNumber;
    data['pwd'] = this.pwd;
    data['confuse'] = this.confuse;
    data['email'] = this.email;
    data['createId'] = this.createId;
    data['createDate'] = this.createDate;
    data['identity'] = this.identity;
    data['roomStatus'] = this.roomStatus;
    data['nickName'] = this.nickName;
    data['estateNames'] = this.estateNames;
    data['nowEstateExamineId'] = this.nowEstateExamineId;
    return data;
  }
}
