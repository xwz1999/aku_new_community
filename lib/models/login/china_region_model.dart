import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'china_region_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class ChinaRegionModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<ChinaRegionModel> cityList;

  factory ChinaRegionModel.fromJson(Map<String, dynamic> json) =>
      _$ChinaRegionModelFromJson(json);

  const ChinaRegionModel({
    required this.id,
    required this.name,
    required this.cityList,
  });

  static ChinaRegionModel empty(int parentId) {
    return ChinaRegionModel(id: 0, name: '', cityList: []);
  }
}
