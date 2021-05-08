import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'facility_type_detail_model.g.dart';

@JsonSerializable()
class FacilityTypeDetailModel extends Equatable {
  final int id;
  final String name;
  FacilityTypeDetailModel({
    required this.id,
    required this.name,
  });

  factory FacilityTypeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$FacilityTypeDetailModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
