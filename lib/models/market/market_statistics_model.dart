import 'package:json_annotation/json_annotation.dart';

part 'market_statistics_model.g.dart';

@JsonSerializable()
class MarketStatisticsModel {
  final int skuTotal;
  final int settledBrandsNum;
  final int newProductsTodayNum;
  factory MarketStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$MarketStatisticsModelFromJson(json);

  const MarketStatisticsModel({
    required this.skuTotal,
    required this.settledBrandsNum,
    required this.newProductsTodayNum,
  });
}
