import 'package:aku_new_community/utils/hive_store.dart';
import 'package:json_annotation/json_annotation.dart';

import 'china_region_model.dart';

part 'picked_city_model.g.dart';

@JsonSerializable()
class PickedCityModel {
  final ChinaRegionModel province;
  final ChinaRegionModel city;
  final ChinaRegionModel district;
  factory PickedCityModel.fromJson(Map<String, dynamic> json) =>
      _$PickedCityModelFromJson(json);

  const PickedCityModel({
    required this.province,
    required this.city,
    required this.district,
  });
  factory PickedCityModel.fromId(
      {required int provinceId, required int cityId, required int distrctId}) {
    var provinces =
        HiveStore.chinaRegionBox!.values.cast<ChinaRegionModel>().toList();
    final _province =
        provinces.firstWhere((element) => element.id == provinceId);
    final _city =
        _province.cityList.firstWhere((element) => element.id == cityId);
    final _district =
        _city.cityList.firstWhere((element) => element.id == distrctId);

    return PickedCityModel(
      province: _province,
      city: _city,
      district: _district,
    );
  }

  String get address => province.name + city.name + district.name;

  int get id => district.id;
}
