import 'package:aku_new_community/model/user/pick_building_model.dart';

class HouseItem {
  PickBuildingModel building;
  PickBuildingModel unit;
  PickBuildingModel room;

  HouseItem({
    required this.building,
    required this.unit,
    required this.room,
  });

  int? get houseCode => room.value;

  String get houseName => '${building.label}-${unit.label}单元-${room.label}';
}
