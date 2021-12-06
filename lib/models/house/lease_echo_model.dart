import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lease_echo_model.g.dart';

@JsonSerializable()
class LeaseEchoModel extends Equatable {
  final String? name;
  final num? sex;
  final String tel;
  final String? idNumber;

  LeaseEchoModel({
    required this.name,
    required this.sex,
    required this.tel,
    required this.idNumber,
  });

  factory LeaseEchoModel.fromJson(Map<String, dynamic> json) =>
      _$LeaseEchoModelFromJson(json);

  factory LeaseEchoModel.fail() =>
      LeaseEchoModel(name: '', sex: 0, tel: '', idNumber: '');

  @override
  List<Object?> get props => [name, sex, tel, idNumber];
}
