import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'test.g.dart';

@JsonSerializable()
class Test extends Equatable {
  final int id;

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);

  @override
  List<Object?> get props => [
        id,
      ];

  const Test({
    required this.id,
  });
}
