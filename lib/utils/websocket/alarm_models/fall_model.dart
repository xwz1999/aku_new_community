import 'package:json_annotation/json_annotation.dart';

part 'fall_model.g.dart';

@JsonSerializable()
class FallModel {
  final String? userName;
  final String? tel;
  final String? address;
  final num? lon;
  final num? lat;
  final int? type;
  factory FallModel.fromJson(Map<String, dynamic> json) =>
      _$FallModelFromJson(json);

  const FallModel({
    this.userName,
    this.tel,
    this.address,
    this.lon,
    this.lat,
    this.type,
  });
}
