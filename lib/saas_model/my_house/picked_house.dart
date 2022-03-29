import 'estate_cascade_model.dart';

class PickedHouseModel {
  final EstateCascadeModel? building;
  final Unit? unit;
  final Floor? floor;
  final House? house;

  const PickedHouseModel({
    this.building,
    this.unit,
    this.floor,
    this.house,
  });
}
