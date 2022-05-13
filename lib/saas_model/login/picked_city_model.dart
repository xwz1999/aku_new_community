import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:aku_new_community/utils/hive_store.dart';
import 'china_region_model.dart';

part 'picked_city_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class PickedCityModel extends Equatable {
  @HiveField(0)
  final ChinaRegionModel province;
  @HiveField(1)
  final ChinaRegionModel city;
  @HiveField(2)
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
        HiveStore.dataBox!.get('cities').cast<ChinaRegionModel>().toList();
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

  @override
  List<Object?> get props => [province, city, district];
}
