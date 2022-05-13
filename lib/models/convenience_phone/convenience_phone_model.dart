import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'convenience_phone_model.g.dart';


@JsonSerializable()
class ConveniencePhoneModel extends Equatable {
  final int id;
  final String name;
  final String tel;
  final int type;

  factory ConveniencePhoneModel.fromJson(Map<String, dynamic> json) =>
      _$ConveniencePhoneModelFromJson(json);

  const ConveniencePhoneModel({
    required this.id,
    required this.name,
    required this.tel,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, tel, type,];
}
