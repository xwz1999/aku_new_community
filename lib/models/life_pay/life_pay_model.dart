import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'life_pay_model.g.dart';


@JsonSerializable(createToJson: true, explicitToJson: true)
class LifePayModel extends Equatable {
  final int id;
  final String chargesName;
  final String billDateStart;
  final String billDateEnd;
  final String createDate;
  final double payPrincipal;
  final double defaultAmount;



    factory LifePayModel.fromJson(Map<String, dynamic> json) =>_$LifePayModelFromJson(json);
    Map<String,dynamic> toJson()=> _$LifePayModelToJson(this);

   LifePayModel({
    required this.id,
    required this.chargesName,
    required this.billDateStart,
    required this.billDateEnd,
    required this.createDate,
    required this.payPrincipal,
    required this.defaultAmount,
  });

  @override
  List<Object?> get props => [id, chargesName, billDateStart,billDateEnd,createDate,payPrincipal,defaultAmount];
}