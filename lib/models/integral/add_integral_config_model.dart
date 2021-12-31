import 'package:json_annotation/json_annotation.dart';

part 'add_integral_config_model.g.dart';

@JsonSerializable()
class AddIntegralConfigModel {
  final int addIntegral;
  final bool hasClocked;
  factory AddIntegralConfigModel.fromJson(Map<String, dynamic> json) =>
      _$AddIntegralConfigModelFromJson(json);

  const AddIntegralConfigModel({
    required this.addIntegral,
    required this.hasClocked,
  });
}
