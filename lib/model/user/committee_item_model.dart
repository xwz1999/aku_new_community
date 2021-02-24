// Project imports:
import 'package:akuCommunity/model/common/img_model.dart';

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
  List<ImgModel> imgUrls;

  String get firstImg {
    if (imgUrls.isEmpty) return '';
    return imgUrls.first.url;
  }

  String get sexValue {
    if (sexId == 0 || sexId == null) return '未设置';
    if (sexId == 1) return '男';
    if (sexId == 2) return '女';
    return '未设置';
  }

  String get positionValue {
    switch (positionId) {
      case 1:
        return '业委会主任';
      case 2:
        return '业委会副主任';
      case 3:
        return '业委会委员';
      default:
        return '';
    }
  }

  CommitteeItemModel({
    this.id,
    this.positionId,
    this.name,
    this.sexId,
    this.age,
    this.educationId,
    this.roomName,
    this.profession,
    this.roomNumber,
    this.unitNo,
    this.estateNo,
    this.imgUrls,
  });

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
    if (json['imgUrls'] != null) {
      imgUrls =
          (json['imgUrls'] as List).map((e) => ImgModel.fromJson(e)).toList();
    } else
      imgUrls = [];
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
