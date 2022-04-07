import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 7)
class CommunityModel extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String address;
  @HiveField(3)
  final String addressDetails;

  factory CommunityModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityModelFromJson(json);

  const CommunityModel({
    required this.id,
    required this.name,
    required this.address,
    required this.addressDetails,
  });

  @override
  List<Object?> get props => [id, name, address, addressDetails];
}
