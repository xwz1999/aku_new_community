import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'integral_goods_list_model.g.dart';

@JsonSerializable()
class IntegralGoodsListModel extends Equatable {
  final int id;
  final String skuName;
  final String mainPhoto;
  final int points;
  final int? saleNum;

  factory IntegralGoodsListModel.fromJson(Map<String, dynamic> json) =>
      _$IntegralGoodsListModelFromJson(json);

  const IntegralGoodsListModel({
    required this.id,
    required this.skuName,
    required this.mainPhoto,
    required this.points,
    this.saleNum,
  });

  @override
  List<Object?> get props => [
        id,
        skuName,
        mainPhoto,
        points,
        saleNum,
      ];
}
