import 'package:aku_new_community/pages/services/old_age/old_enum.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'bracelet_list_model.g.dart';

@JsonSerializable()
class BraceletListModel extends Equatable {
  final int id;
  final int type;
  final String deviceType;
  final String imei;

  factory BraceletListModel.fromJson(Map<String, dynamic> json) =>
      _$BraceletListModelFromJson(json);

  BraceletBrand get braceletBrand => BraceletBrand.getValue(type);

  const BraceletListModel({
    required this.id,
    required this.type,
    required this.deviceType,
    required this.imei,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        deviceType,
        imei,
      ];
}
