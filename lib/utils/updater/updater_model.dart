import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'updater_model.g.dart';

@JsonSerializable()
class UpdaterModel extends Equatable{
  final int id;
  final String versionNumber;
  final String buildNo;
  final int forceUpdate;
  final String createDate;

  factory UpdaterModel.fromJson(Map<String, dynamic> json) =>_$UpdaterModelFromJson(json);

  const UpdaterModel({
    required this.id,
    required this.versionNumber,
    required this.buildNo,
    required this.forceUpdate,
    required this.createDate,
  });

  @override
  List<Object?> get props => [
    id,versionNumber,buildNo,forceUpdate,createDate,
  ];
}

