import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'life_pay_list_model.g.dart';

@JsonSerializable(createToJson: true, explicitToJson: true)
class LifePayListModel extends Equatable {
  final int years;
  final int paymentNum;
  final List<DailyPaymentTypeVos> dailyPaymentTypeVos;
  LifePayListModel({
    required this.years,
    required this.paymentNum,
    required this.dailyPaymentTypeVos,
  });
  factory LifePayListModel.fromJson(Map<String, dynamic> json) =>
      _$LifePayListModelFromJson(json);
  factory LifePayListModel.zero() =>
      LifePayListModel(years: 0, paymentNum: 0, dailyPaymentTypeVos: [
        DailyPaymentTypeVos(id: 0, name: '', detailedVoList: [
          DetailedVoList(groupId: 0, paymentPrice: 0, detailsVoList: [])
        ])
      ]);
  Map<String, dynamic> toJson() => _$LifePayListModelToJson(this);
  @override
  List<Object?> get props => [years, paymentNum, dailyPaymentTypeVos];
}

@JsonSerializable(createToJson: true, explicitToJson: true)
class DailyPaymentTypeVos extends Equatable {
  final int id;
  final String name;
  final List<DetailedVoList> detailedVoList;
  DailyPaymentTypeVos({
    required this.id,
    required this.name,
    required this.detailedVoList,
  });
  factory DailyPaymentTypeVos.fromJson(Map<String, dynamic> json) =>
      _$DailyPaymentTypeVosFromJson(json);
  Map<String, dynamic> toJson() => _$DailyPaymentTypeVosToJson(this);
  @override
  List<Object> get props => [id, name, detailedVoList];
}

@JsonSerializable(createToJson: true, explicitToJson: true)
class DetailedVoList extends Equatable {
  final int groupId;
  final num paymentPrice;
  final List<DetailsVoList> detailsVoList;
  DetailedVoList({
    required this.groupId,
    required this.paymentPrice,
    required this.detailsVoList,
  });
  factory DetailedVoList.fromJson(Map<String, dynamic> json) =>
      _$DetailedVoListFromJson(json);
  Map<String, dynamic> toJson() => _$DetailedVoListToJson(this);
  @override
  List<Object> get props => [groupId, paymentPrice, detailsVoList];
}

@JsonSerializable(createToJson: true, explicitToJson: true)
class DetailsVoList extends Equatable {
  final int id;
  final String month;
  final num costPrice;
  final num paidPrice;
  final num totalPrice;
  final String beginDate;
  final String endDate;
  final String unitPriceType;
  @JsonKey(name: 'num')
  final int number;
  DetailsVoList({
    required this.id,
    required this.month,
    required this.costPrice,
    required this.paidPrice,
    required this.totalPrice,
    required this.beginDate,
    required this.endDate,
    required this.unitPriceType,
    required this.number,
  });
  factory DetailsVoList.fromJson(Map<String, dynamic> json) =>
      _$DetailsVoListFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsVoListToJson(this);
  @override
  List<Object> get props {
    return [
      id,
      month,
      costPrice,
      paidPrice,
      totalPrice,
      beginDate,
      endDate,
      unitPriceType,
      number,
    ];
  }
}
